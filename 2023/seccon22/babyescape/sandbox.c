#include <linux/seccomp.h>
#include <sys/prctl.h>
#include <unistd.h>

static void install_seccomp() {
  static unsigned char filter[] = {
    32,0,0,0,4,0,0,0,21,0,0,12,62,0,0,192,32,0,0,0,0,0,0,0,53,0,10,0,0,0,0,
    64,21,0,9,0,161,0,0,0,21,0,8,0,165,0,0,0,21,0,7,0,16,1,0,0,21,0,6,0,
    169,0,0,0,21,0,5,0,101,0,0,0,21,0,4,0,54,1,0,0,21,0,3,0,55,1,0,0,21,0,2,
    0,48,1,0,0,21,0,1,0,155,0,0,0,6,0,0,0,0,0,255,127,6,0,0,0,0,0,0,0
  };
  struct prog {
    unsigned short len;
    unsigned char *filter;
  } rule = {
    .len = sizeof(filter) >> 3,
    .filter = filter
  };
  if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0) _exit(1);
  if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &rule) < 0) _exit(1);
}

int main(void) {
  char *args[] = {"/bin/sh", NULL};

  if (chroot("sandbox")) {
    write(STDERR_FILENO, "chroot failed\n", 14);
    _exit(1);
  }
  if (chdir("sandbox")) {
    write(STDERR_FILENO, "chdir failed\n", 13);
    _exit(1);
  }

  install_seccomp();
  return execve(args[0], args, NULL);
}
