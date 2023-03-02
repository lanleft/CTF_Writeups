# Node Keeper

## Bug

UAF ở hàm *Unlink* .

1. Tạo một linkedlist  1-2-3
2. Unlink node số 2 tại linked list trên thì ta sẽ đc 2 linked list (1-3 và 2-3) 

## Solution

- Dùng UAF fake Node --> leak heap
- Fake một chunk có size > 0x400 rồi free (thì sẽ vào unsorted bin) --> leak libc
- ghi đè *__free_hook_* (vì trên tcache ko check size của chunk khi được malloc)

[Script](b.py)

*Script cồng kềnh vler*  :'< 







