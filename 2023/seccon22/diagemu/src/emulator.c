#include <unicorn/unicorn.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define ADDR_CODE_BASE 0x400000
#define SIZE_CODE      0x1000

#define v2ofs(addr) ((addr) - ADDR_CODE_BASE)
#define ABORT_ON_FAILURE(cond, msg)             \
  if (cond) {                                   \
    puts("[FATAL] " msg);                       \
    exit(1);                                    \
  }

uint64_t last_insn_addr;
uint16_t last_insn_size;

/* Record last instruction fetched */
static void record_insn(uc_engine *uc, uint64_t address, uint16_t size,
                        void *_user_data) {
  last_insn_addr = address;
  last_insn_size = size;
}

/* Print crash dump */
void show_crash_dump(uint8_t *code) {
  uint32_t pos = v2ofs(last_insn_addr);
  printf("[FATAL] Segmentation fault\nCrash at 0x%lx (insn:", last_insn_addr);
  for (uint32_t i = 0; i < last_insn_size; i++)
    printf(" %02x", code[pos + i]);
  printf(")\n");
}

/* Read string */
void reads(const char *msg, uint8_t *buf, uint16_t size) {
  printf("%s", msg);
  for (uint16_t i = 0; i < size; i++) {
    if (read(STDIN_FILENO, buf + i, 1) <= 0)
      exit(1);
  }
}

/* Read integer */
uint16_t readi(const char *msg) {
  uint8_t buf[0x10] = {};
  printf("%s", msg);
  read(STDIN_FILENO, buf, sizeof(buf)-1);
  return atoi(buf);
}

int main() {
  uc_engine *uc;
  uc_hook tr;
  uint8_t *code;

  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);
  setvbuf(stderr, NULL, _IONBF, 0);

  /* Input code */
  uint16_t size = readi("Size: ");
  ABORT_ON_FAILURE(size > SIZE_CODE, "Size too big");
  ABORT_ON_FAILURE(!(code = (uint8_t*)malloc(size)), "Memory error")
  reads("Code: ", code, size);

  /* Setup unicorn */
  ABORT_ON_FAILURE(uc_open(UC_ARCH_X86, UC_MODE_64, &uc),
                   "uc_open() failed");
  uc_mem_map(uc, ADDR_CODE_BASE, SIZE_CODE, UC_PROT_READ | UC_PROT_EXEC);
  uc_hook_add(uc, &tr, UC_HOOK_CODE, record_insn, NULL,
              ADDR_CODE_BASE, ADDR_CODE_BASE + SIZE_CODE);

  /* Start diagnostic emulation */
  while (1) {
    // Update code
    ABORT_ON_FAILURE(uc_mem_write(uc, ADDR_CODE_BASE, code, size),
                     "uc_mem_write() failed");

    // Emulate
    if (uc_emu_start(uc, ADDR_CODE_BASE, ADDR_CODE_BASE + SIZE_CODE, 0, 0)) {
      // Patch on crash
      show_crash_dump(code);
      reads("Patch: ", code + v2ofs(last_insn_addr), last_insn_size);
      continue;
    }

    break;
  }

  puts("[INFO] Emulation done");
  uc_close(uc);
  return 0;
}
