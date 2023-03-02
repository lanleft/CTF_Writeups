#!/bin/bash

if [ ! -f "vmlinux-3.2.0-4-4kc-malta" ]; then
    wget https://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta
fi
if [ ! -f "debian_wheezy_mips_standard.qcow2" ]; then
    wget https://people.debian.org/~aurel32/qemu/mips/debian_wheezy_mips_standard.qcow2
fi

sudo qemu-system-mips -m 1024M -M malta \
	-nographic \
	-kernel vmlinux-3.2.0-4-4kc-malta \
	-hda debian_wheezy_mips_standard.qcow2 \
	-append "root=/dev/sda1 console=tty0" \
	-device VGA \
	-net user,hostfwd=tcp::80-:80,hostfwd=tcp::443-:443,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:8080,hostfwd=tcp::9999-:9999,hostfwd=udp::22126-:22126,hostfwd=udp::111-:111,hostfwd=udp::62976-:62976,hostfwd=udp::62720-:62720 \
	-net nic -no-reboot