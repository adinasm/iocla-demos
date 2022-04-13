%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
search:
    cmp ebx, eax ; ebx - eax
    jg done

    test ebx, eax ; ebx & eax
    jz skip

    PRINTF32 `%d\n\x0`, ebx

skip:
    shl ebx, 1 ; ebx <<= 1

    jmp search

done:
    leave
    ret
