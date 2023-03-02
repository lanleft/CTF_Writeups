import struct

# print(struct.unpack('d', b'\xc8[\x9a36\x7f&A'))
with open("res.bin", "rb") as fp:
    array_bytes = fp.read()
    fp.close()

array_bytes.split(b"=========END========")