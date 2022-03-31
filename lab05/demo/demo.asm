%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    val: dd 123

section .text
    global main
    extern printf

main:
    push 0
    popf

    mov eax, 0
    xor eax, eax
    test eax, eax ; eax & eax (pe biti), nu modifica eax

    push 0
    popf

    mov ebx, 0xffffffff
    test ebx, ebx ; ebx & ebx, nu modifica ebx

    push 0
    popf

    mov al, 250
    mov bl, 10
    add al, bl

    push 0
    popf

    mov al, 0
    mov bl, 1
    sub al, bl

    push 0
    popf

    mov al, 120
    mov bl, 120
    add al, bl

    push 0
    popf

    mov al, 129
    mov bl, 129
    add al, bl

    mov eax, 2
    mov ebx, 1
    cmp eax, ebx ; eax - ebx, nu modifica eax
    je print

    mov ebx, val
    PRINTF32 `ebx = 0x%x\n\x0`, ebx

    mov eax, ebx
    PRINTF32 `eax = 0x%x\n\n\x0`, eax

    mov eax, [ebx]
    PRINTF32 `eax = %d\n\n\x0`, eax

    add eax, 2
    PRINTF32 `eax = %d\n\x0`, eax
    PRINTF32 `[val] = %d\n\n\x0`, DWORD [val]

    add DWORD [ebx], 2
    PRINTF32 `[ebx] = %d\n\x0`, [ebx]
    PRINTF32 `[val] = %d\n\n\x0`, DWORD [val]

print:
    PRINTF32 `%s\n\x0`, myString

    ret
