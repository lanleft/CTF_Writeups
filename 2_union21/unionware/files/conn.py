from pwn import *

p = remote("62.159.241.35.bc.googleusercontent.com", 1337)

p.send("KADMKLAFD:LSM$OPM@FLK:FM!N$@N$")
x = p.recv()
# print (x)

i = 0x1000
a = x
while i < 0x6B200 :
    # sleep(1)
    x = p.recv()
    a += x
    i += len(x)

open("out.exe", "wb").write(a)
print ("ok")

# print (hex(len(a)))
# # open("out.exe", "wb").write(p.recv())
# print ("part1")
# a = p.recv()
# print (hex(len(a)))
# print ("part2")
# # addr = 002D3FF0
# # 0x6B200

# ??_7InvertibleRSAFunction@CryptoPP@@6B@

# ??_7PK_EncryptorFilter@CryptoPP@@6B@

# 0x56
# ??_7AlgorithmParameters@CryptoPP@@6B@