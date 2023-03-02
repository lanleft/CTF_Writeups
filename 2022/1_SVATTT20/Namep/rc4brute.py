
from Crypto.Cipher import ARC4
import string

ALPHABET = string.printable
KEY_LENGTH = 4

data = b'\xAD\x29\xA9\x8C\x28\x69\x72\xB0\xB4\xE8\x83\xA4\xEE\x23\xBE\xB5\x94\x94\x19\x4A\x8C\x30\x19\x29'
ARC4.key_size = range(1,257)
for i in ALPHABET:
    for j in ALPHABET:
        for k in ALPHABET:
            for l in ALPHABET:
                key = i + j + k + l
                # print (key)
                decr = ARC4.new(bytes(key, 'utf-8')).decrypt(data)
                # print (decr)
                if b'ASCI' in decr:
                    print (key)
                    print (decr)
                    break
