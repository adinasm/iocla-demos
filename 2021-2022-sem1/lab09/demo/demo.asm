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

; short get_sum(char *v, int len);
get_sum:
    push ebp
    mov ebp, esp

    ; short sum = 0; (sum e variabila locala)
    sub esp, 2
    mov word [ebp - 2], 0 ; sau [esp]

    ; [ebp + 4] - adresa de retur
    mov ebx, [ebp + 8] ; v
    mov ecx, [ebp + 12] ; len

    xor edx, edx

add_val:
    mov dl, [ebx + ecx - 1]
    add [ebp - 2], dx
    loop add_val

    mov ax, [ebp - 2]

    leave
    ; echiv:
    ; mov esp, ebp
    ; pop ebp

    ret ; pop eip

; cdecl
; - parametrii se pun pe stiva
; - functia apelanta pune param ep stiva si tot ea ii scoate de acolo
; - valoarea de retur: al (8b), ax (16b), eax (32b), (sau pe stiva daca nu incape intr-un registru)

main:
    push ebp
    mov ebp, esp

    ; printf("%d\n", len);
    push dword [len] ; len
    push fmt_len    ; fmt_len
    call printf
    add esp, 8

    push dword [len]
    push v
    call get_sum
    ; pune pe stiva adresa de retur (adresa urm instr == add esp, 8)
    ; jmp get_sum

    add esp, 8

    ; printf("%hd\n", ax);
    push ax
    push fmt_sum
    call printf
    add esp, 6

    leave
    ret
