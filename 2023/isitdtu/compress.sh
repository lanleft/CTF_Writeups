#!/bin/sh

gcc exploit.c -no-pie -o exp -lmnl -lnftnl
mv ./exp ./initramfs
cd initramfs
find . -print0 \
| cpio --null -ov --format=newc \
| gzip -9 > initramfs.cpio.gz
mv ./initramfs.cpio.gz ../
