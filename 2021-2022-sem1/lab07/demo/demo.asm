%include "../utils/printf32.asm"

struc some_struct
    x: resw 1
    y: resd 1
    z: resb 20
endstruc

struc other_struct
    t: resd 1
    u: resd 1

section .data:
    s:
    istruc some_struct
        at t, dw 1
        at y, dd 14
        at z, db "Sal", 0
    iend
    ; echivalent cu ce e mai sus
    ; s:
    ; istruc some_struct
    ;     at 0, dw 1
    ;     at 2, dd 14
    ;     at 6, db "Sal", 0
    ; iend

    ; err
    ; s1:
    ; istruc some_struct
    ;     at x, dd 0x12345678
    ;     at y, dw 0xabcd
    ;     at z, db "Sal", 0
    ; iend
    s1:
    istruc some_struct
        at t, dd 0x12345678
        at u, dw 0xabcd
        at z, db "Sal", 0
    iend
    ; 0x78 0x56 0x34 0x12 0xcd 0xab S a l 0x00

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    PRINTF32 `x = %d\n\x0`, x
    PRINTF32 `y = %d\n\x0`, y
    PRINTF32 `z = %d\n\x0`, z

    PRINTF32 `t = %d\n\x0`, t
    PRINTF32 `u = %d\n\x0`, u

    PRINTF32 `s.x = %hu\n\x0`, [s + x]
    PRINTF32 `s.y = %d\n\x0`, [s + y]
    PRINTF32 `s.z = %s\n\x0`, s + z

    xor eax, eax
    mov ax, [s + x]
    mov ebx, [s + y]
    ; mov ecx, s + z
    lea ecx, [s + z]

    PRINTF32 `s.x = %hu\n\x0`, eax
    PRINTF32 `s.y = %d\n\x0`, ebx
    PRINTF32 `s.z = %s\n\x0`, ecx

    ; Macro NASM
    PRINTF32 `sizeof(struct some_struct) = %d\n\x0`, some_struct_size

    PRINTF32 `s1.x = %hx\n\x0`, [s1 + x]
    PRINTF32 `s1.y = %x\n\x0`, [s1 + y]
    PRINTF32 `s1.z = %s\n\x0`, s1 + z

    xor eax, eax
    leave
    ret
