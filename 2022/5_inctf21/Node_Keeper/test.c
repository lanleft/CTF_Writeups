#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
    int size;
    scanf("%d", &size);
    char *p = (char*)malloc(size);
    char *p2 = (char*)malloc(0x20);
    memcpy(p2, "BBBBBBBBBBBBBBBBBB", 20);
    memcpy(p, "AAAAAAAAAAAAAAAAAA", 20);

    free(p);
    free(p2);

    return 0;
}