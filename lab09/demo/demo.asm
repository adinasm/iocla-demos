%include "../utils/printf32.asm"

section .data
len: dd 5
fmt_len: db "%d", 10, 0
fmt_sum: db "%hd", 10, 0
v: db 1, 2, 3, 4, 5

section .text
extern printf
global main

; https://docs.google.com/presentation/d/1BwDVE_Qo0oo9WduuorB09m3k3QPXAQATZ-7yiqhxnuw/edit?usp=sharing

get_sum:
    push ebp
    mov ebp, esp

    sub esp, 2
    mov word [ebp - 2], 0

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]

    xor edx, edx

add_val:
    mov dl, [ebx + ecx - 1]
    add [ebp - 2], dx
    loop add_val

    mov ax, [ebp - 2]

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; printf("%d", 5);
    push dword [len]
    push fmt_len
    call printf
    add esp, 8

    push dword [len]
    push v
    call get_sum
    add esp, 8

    push ax
    push fmt_sum
    call printf
    add esp, 6

    leave
    ret
