// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

#include "xorstr.hpp"
#include "aes.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

#pragma warning(disable: 4996)

int encrypt()
{
    uint8_t cipher[] = { 0x7e, 0xed, 0xf, 0xd7, 0xa6, 0xe8, 0xea, 0x5e, 0x43, 0x6b, 0x4, 0xa4, 0xa7, 0xb1, 0x40, 0x5e, 0x8d, 0xf0, 0xdb, 0xa3, 0xa4, 0x88, 0x77, 0x47, 0xcd, 0xd4, 0x13, 0x8f, 0x4e, 0x6c, 0x6e, 0x55, 0xb2, 0x9b, 0x4f, 0xb8, 0xf5, 0x1e, 0x94, 0x69, 0xe5, 0xa5, 0x3, 0x25, 0x5, 0xdc, 0x1f, 0x40, 0xe3, 0x96, 0xe9, 0x65, 0x5a, 0x89, 0x89, 0xeb, 0x2, 0x38, 0x50, 0x20, 0x4f, 0x14, 0xe, 0xfd };
    uint8_t iv[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
    uint8_t key[] = { 0x6c, 0x61, 0x6e, 0x6c, 0x65, 0x66, 0x74, 0x68, 0x75, 0x73, 0x74, 0x62, 0x6b, 0x73, 0x65, 0x63 };
    uint8_t pt[256];

    memset(pt, 0, 256);
    puts(xorstr("Input your flag: ").crypt_get());
    scanf("%64s", &pt);

    if (strlen((char*)pt) != 64) {
        puts(xorstr("Wrong length of flag...\n").crypt_get());
        return 0;
    }

    struct AES_ctx ctx;

    AES_init_ctx_iv(&ctx, key, iv);
    AES_CBC_encrypt_buffer(&ctx, pt, 64);

    /*for (int i = 0; i < 64; i++) printf("0x%x, ", pt[i]);
    printf("\n");*/

    if (memcmp((char*)cipher, (char*)pt, 64) == 0) {
        puts(xorstr("You get the flag!!!\n").crypt_get());

        return 0;
    }
    else {
        puts(xorstr("You wrong...\n").crypt_get());
        return 0;
    }

}

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        encrypt();
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

