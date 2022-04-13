%include "../utils/printf32.asm"

section .data
    var_byte db 'A'
    var_byte1 db 0x41
    var_byte2 db 65

    var_word dw 10
    var_dword dd 1
    var_qword dq 0x0123456789ABCDEF

    str: db "salut", 0
    str1 db 's', 'a', 'l', 'u', 't', 0

    arr dd 0, 1, 2, 3

section .rodata
    str2 db "salut", 0

section .bss
    v_byte resb 1
    v_bytes resb 10
    v_word resw 1
    v_words resw 100

section .text

extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; Mem, reg
    mov eax, var_dword
    PRINTF32 `var_dword = 0x%x\n\x0`, eax

    mov [var_dword], dword 30
    PRINTF32 `var_dword = 0x%x\n\x0`, [eax]

    mov eax, [var_dword]
    PRINTF32 `[var_dword] = %d\n\x0`, eax

    mov dword [var_dword], 10
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    mov [var_dword], dword 200000000
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    mov [var_dword], byte 255
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    PRINTF32 `[var_qword] = 0x%x\x0`, [var_qword + 4]
    PRINTF32 `%x\n\x0`, [var_qword]

;     ; Arrays
;     mov ecx, 4
;     xor eax, eax
;     PRINTF32 `arr:\n\x0`

; print:
;     PRINTF32 `%d\n\x0`, [arr + eax * 4]
;     inc eax
;     cmp ecx, eax
;     jnz print

;     ; Multiplication
;     mov eax, 12
;     mov ebx, 3

;     mul bl
;     PRINTF32 `%d\n\x0`, eax

;     mov eax, 12

;     mul byte [var_byte]
;     PRINTF32 `%d\n\x0`, eax

;     mov eax, 14
;     mov ebx, 5

;     div bl
;     PRINTF32 `{R, C} = 0x%x\n\x0`, eax

;     xor ebx, ebx
;     mov bl, al
;     PRINTF32 `C = %d\n\x0`, ebx

;     xor ebx, ebx
;     mov bl, ah
;     PRINTF32 `R = %d\n\x0`, ebx

    leave
    ret
