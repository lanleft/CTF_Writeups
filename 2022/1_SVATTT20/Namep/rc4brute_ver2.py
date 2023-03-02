<<<<<<< HEAD:2022/1_SVATTT20/Namep/rc4brute_ver2.py
## version_2 => faster
import multiprocessing
from Crypto.Cipher import ARC4
from tqdm import tqdm
import string
import itertools

def crack(ct,first_bytes_set):    
    for key in gen_key(first_bytes_set):
        rc4 = ARC4.new(key)
        tmp = rc4.encrypt(ct)
        if b'ASCIS{' in tmp: return (key,tmp)  
    return b''

def gen_key(first_bytes_set):
    alphabet = b'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'#string.printable[:-6].encode()
    for c in first_bytes_set:
        for key in itertools.product(alphabet,repeat=3):yield bytes([c])+bytes(key)

def do_error(result):return f"Error: {result}"


if __name__=='__main__':
    alphabet = b'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    process_pool=multiprocessing.Pool(5) 
    queue = multiprocessing.SimpleQueue()
    
    ct = b"\xAD\x29\xA9\x8C\x28\x69\x72\xB0\xB4\xE8\x83\xA4\xEE\x23\xBE\xB5\x94\x94\x19\x4A\x8C\x30\x19\x29"
    
    step = len(alphabet)//5 + 1
    for i in range(0,len(alphabet),step):
        process_pool.apply_async(crack,(ct,alphabet[i:i+step]),callback=queue.put,error_callback=do_error)

    process_pool.close()
    for _ in range(5):
        tmp=queue.get()
=======
## version_2 => faster
import multiprocessing
from Crypto.Cipher import ARC4
from tqdm import tqdm
import string
import itertools

def crack(ct,first_bytes_set):    
    for key in gen_key(first_bytes_set):
        rc4 = ARC4.new(key)
        tmp = rc4.encrypt(ct)
        if b'ASCIS{' in tmp: return (key,tmp)  
    return b''

def gen_key(first_bytes_set):
    alphabet = b'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'#string.printable[:-6].encode()
    for c in first_bytes_set:
        for key in itertools.product(alphabet,repeat=3):yield bytes([c])+bytes(key)

def do_error(result):return f"Error: {result}"


if __name__=='__main__':
    alphabet = b'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    process_pool=multiprocessing.Pool(5) 
    queue = multiprocessing.SimpleQueue()
    
    ct = b"\xAD\x29\xA9\x8C\x28\x69\x72\xB0\xB4\xE8\x83\xA4\xEE\x23\xBE\xB5\x94\x94\x19\x4A\x8C\x30\x19\x29"
    
    step = len(alphabet)//5 + 1
    for i in range(0,len(alphabet),step):
        process_pool.apply_async(crack,(ct,alphabet[i:i+step]),callback=queue.put,error_callback=do_error)

    process_pool.close()
    for _ in range(5):
        tmp=queue.get()
>>>>>>> 7ecbfe18d299a69dc9a64d115d6606d93a5892a8:1_SVATTT20/Namep/rc4brute_ver2.py
        print(tmp)