import re 


s = """
.rodata:0000000000400C60    xor     rcx, rcx
.rodata:0000000000400C63    mov     rax, [rdi]
.rodata:0000000000400C66    add     rdi, 8
.rodata:0000000000400C6A    mov     rbx, 7FFF427749597942h
.rodata:0000000000400C74    xor     rax, rbx
.rodata:0000000000400C77    mov     rax, ds:0DEADBEEFh
.rodata:0000000000400C81    cmp     rax, rcx
.rodata:0000000000400C84    int     3               ; Trap to Debugger
.rodata:0000000000400C85    nop
.rodata:0000000000400C86    int     3               ; Trap to Debugger
.rodata:0000000000400C87    nop
.rodata:0000000000400C88    mov     rax, ds:0DEADBEEFh
.rodata:0000000000400C92    cmp     rax, rcx
.rodata:0000000000400C95    int     3               ; Trap to Debugger
.rodata:0000000000400C96    nop
.rodata:0000000000400C97    int     3               ; Trap to Debugger
.rodata:0000000000400C98    nop
.rodata:0000000000400C99    mov     rax, [rdi]
.rodata:0000000000400C9C    add     rdi, 8
.rodata:0000000000400CA0    xor     rax, rbx
.rodata:0000000000400CA3    mov     rax, ds:0DEADBEEFh
.rodata:0000000000400CAD    cmp     rax, rcx
.rodata:0000000000400CB0    int     3               ; Trap to Debugger
.rodata:0000000000400CB1    nop
.rodata:0000000000400CB2    int     3               ; Trap to Debugger
.rodata:0000000000400CB3    nop
.rodata:0000000000400CB4    mov     rax, ds:0DEADBEEFh
.rodata:0000000000400CBE    cmp     rax, rcx
.rodata:0000000000400CC1    int     3               ; Trap to Debugger
.rodata:0000000000400CC2    nop
.rodata:0000000000400CC3    int     3               ; Trap to Debugger
.rodata:0000000000400CC4    nop
.rodata:0000000000400CC5    xor     rax, rax
.rodata:0000000000400CC8    mov     ax, [rdi]
.rodata:0000000000400CCB    add     rax, 9999h
.rodata:0000000000400CD1    cmp     rax, 1130Bh
.rodata:0000000000400CD7    int     3               ; Trap to Debugger
.rodata:0000000000400CD8    nop
.rodata:0000000000400CD9    int     3               ; Trap to Debugger
.rodata:0000000000400CDA    nop
.rodata:0000000000400CDB    cmp     ax, 0D8FEh
.rodata:0000000000400CDF    int     3               ; Trap to Debugger
.rodata:0000000000400CE0    nop
.rodata:0000000000400CE1    int     3               ; Trap to Debugger
.rodata:0000000000400CE2    nop
.rodata:0000000000400CE3    xor     rax, rax
.rodata:0000000000400CE6    inc     al
.rodata:0000000000400CE8    mov     edi, 1
.rodata:0000000000400CED    mov     rsi, offset aWrong ; "Wrong."
.rodata:0000000000400CF7    mov     edx, 5
.rodata:0000000000400CFC    syscall                 ; LINUX - sys_write
.rodata:0000000000400CFE    mov     al, 3Ch ; '<'
.rodata:0000000000400D00    xor     rdi, rdi
.rodata:0000000000400D03    syscall                 ; LINUX - sys_exit
.rodata:0000000000400D05    xor     rax, rax
.rodata:0000000000400D08    inc     al
.rodata:0000000000400D0A    mov     edi, 1
.rodata:0000000000400D0F    mov     rsi, offset aGood ; "Good."
.rodata:0000000000400D19    mov     edx, 5
.rodata:0000000000400D1E    syscall                 ; LINUX - sys_write
.rodata:0000000000400D20    mov     al, 3Ch ; '<'
.rodata:0000000000400D22    xor     rdi, rdi
.rodata:0000000000400D25    syscall
"""
rip_val = [0x24, 0x0, 0x39, 0x26, 0x1, 0x54, 0x35, 0x1, 0x83, 0x37, 0x0, 0x65,
0x50, 0x0, 0x65, 0x52, 0x1, 0x28, 0x61, 0x1, 0x83, 0x63, 0x0, 0x39,
0x77, 0x0, 0x83, 0x79, 0x1, 0x7B, 0x7F, 0x1, 0x83, 0x81, 0x2, 0xA5]

rcx_val = [0x209A2A23162D490C, 0x28, 0x0B962F1827381727, 0x43, 0x0D9011282E6D1504, 0x54, 0x14962E0226201626]
base = 0x400C60

sigsegv = re.findall(r"^.*mov\s.*rax,\sds:0DEADBEEFh", s, re.MULTILINE)
sigtrap = re.findall(r"(^.*int\s.*3)", s, re.MULTILINE)

s1 = s

# change sigsegv
for idx in range(len(sigsegv)):
    a = sigsegv[idx][:28] +  "mov     rcx, " + str(rcx_val[idx*2]) + 'h'
    s1 = s1.replace(sigsegv[idx], a)

# change sigtrap
for idx in range(len(sigtrap)):
    if rip_val[3*idx + 1] == 0:
        a = sigtrap[idx][:28] +  "jz      " + hex(base + rip_val[3*idx + 2])[2:].upper() + 'h'
        s1 = s1.replace(sigtrap[idx], a)
    if rip_val[3*idx + 1] == 1:
        a = sigtrap[idx][:28] +  "jnz     " + hex(base + rip_val[3*idx + 2])[2:].upper() + 'h'
        s1 = s1.replace(sigtrap[idx], a)
    else:
        a = sigtrap[idx][:28] +  "jmp     " + hex(base + rip_val[3*idx + 2])[2:].upper() + 'h'
        s1 = s1.replace(sigtrap[idx], a)
        # continue
       
print (s1)
# print (s.replace('.rodata:0000000000400C77    mov     rax, ds:0DEADBEEFh', "test"))