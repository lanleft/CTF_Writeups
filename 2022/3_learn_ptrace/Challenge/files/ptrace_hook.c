#define _GNU_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <dlfcn.h>
//#include <sys/ptrace.h>
#include <sys/types.h>
#include <stdarg.h>
#include <sys/utsname.h>
#include <sys/stat.h>

void print_hex(const char *s, int idx)
{
    while (idx != 0) printf("\\x%x", *s++ & 0xff);
    printf("\n");
}

long int (*orig_ptrace) (int request, pid_t pid, void *addr, void *data);

long int ptrace (int request, pid_t pid, void *addr, void *data)
{
    if (!orig_ptrace) orig_ptrace = dlsym(RTLD_NEXT, "ptrace");
    unsigned int val = (unsigned int)request;
    if (val == 13){
        unsigned long rdi = *((unsigned long*)data + 15*8);
        printf("SETREGS: rdi: 0x%lx\n", rdi); 
        char* s = (char*)rdi;
        print_hex(s, 8); 
    }
    return orig_ptrace(request, pid, addr, data);
}

// gcc -shared -fPIC ptrace_hook.c -ldl -o ptrace_hook.so && LD_PRELOAD=./ptrace_hook.so ./ch29.bin