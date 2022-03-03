%include "../utils/printf32.asm"

section .data

section .text
extern printf
global main

main:
    ; V2
    mov ebp, esp

    mov eax, 0x12345678
    push eax        ; 4
    push word 0xab  ; 2

    push 0xcdef     ; 4
    push byte 0xf   ; 4

    ; push al -> NU

    ; push 0x1357
    sub esp, 4
    mov dword [esp], 0x1357

    ; mov ax, [esp]
    ; add esp, 2
    pop ax

    ; mov ebx, [esp]
    ; add esp, 4
    pop ebx

    ; V1:
    ; PUSH: 4 * 4 + 2 = 18
    ; POP: 2 + 4 = 6
    ; add esp, 12

    sub esp, 32
    mov dword [esp], 0x142345
    mov word [esp + 8], 0x78

    add esp, 32

    ; V2
    mov esp, ebp

    ret
