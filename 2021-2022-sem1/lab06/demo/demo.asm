%include "../utils/printf32.asm"

; global initialized variables
; perm: rw-
section .data
    var_byte db 'A'     ; db = define byte (8b, ex: char var_byte = 'A')
    var_byte1 db 0x41   ; same as above
    var_byte2 db 65     ; same as above

    var_word dw 10      ; dw = define word (16b, ex: short var_word = 10)
    var_dword dd 1      ; dd = define double word (32b, ex: int var_dword = 1)
    var_qword dq 12     ; dq = define quad word (64b, ex: long long var_qword = 12)

    str: db "salut", 0                  ; char str[] = "salut"; 0 => '\0'
    str1 db 's', 'a', 'l', 'u', 't', 0  ; same as above

    arr dd 0, 1, 2, 3                   ; int arr[] = {0, 1, 2, 3}
    ; arr2: dd 0                           ; same as above
    ;         1
    ;         2
    ;         3

; global constant variables
; perm: r--
section .rodata
    str2 db "salut", 0
    ; same in .data

; global uninitialized variables
; perm: rw-
section .bss
    v_byte resb 1       ; char v_byte;
    v_bytes resb 10     ; char v_bytes[10];
    v_word resw 1       ; short v_word;
    v_words resw 100    ; short v_words[100];
    ; resd
    ; resq


; instructions
; perm: r-x
section .text

extern printf

global main

main:
    push ebp
    mov ebp, esp

    ; eax - contine adresa
    mov eax, var_dword
    PRINTF32 `var_dword = 0x%x\n\x0`, eax

    ; eax - contine valoarea de la adresa var_dword
    mov eax, [var_dword]
    PRINTF32 `[var_dword] = %d\n\x0`, eax

    mov dword [var_dword], 10
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    mov [var_dword], dword 200000000
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    mov [var_dword], byte 255
    PRINTF32 `[var_dword] = %d\n\x0`, [var_dword]

    ; var_qword           var_qword + 4
    ; 0x0c 0x00 0x00 0x00 | 0x00 0x00 0x00 0x00
    PRINTF32 `[var_qword] = 0x%x\x0`, [var_qword + 4]
    PRINTF32 `%x\n\x0`, [var_qword]

    mov ecx, 4
    xor eax, eax ; eax <- 0; eax e i
    ; sub eax, eax
    ; mov eax, 0
    PRINTF32 `arr:\n\x0`

print:
    ; arr[i] = *(arr + i) = "*(arr + i * sizeof(*arr))"
    PRINTF32 `%d\n\x0`, [arr + eax * 4]
    inc eax
    cmp ecx, eax
    jnz print


    mov ecx, 4
    PRINTF32 `arr_rev:\n\x0`

print_rev:
    ; arr[i] = *(arr + i) = "*(arr + i * sizeof(*arr))"
    PRINTF32 `%d\n\x0`, [arr + (ecx - 1) * 4] ; [arr + ecx * 4 - 4]
    loop print_rev

    mov ecx, 4
    PRINTF32 `arr_rev:\n\x0`

print_rev_no_loop:
    ; arr[i] = *(arr + i) = "*(arr + i * sizeof(*arr))"
    PRINTF32 `%d\n\x0`, [arr + (ecx - 1) * 4] ; [arr + ecx * 4 - 4]
    dec ecx
    jnz print_rev_no_loop

    ; Multiply
    ; res = D * I
    ; syntax: mul I (I - reg/mem)
    ;
    ; I = 8b => trebuie sa plasam D in AL; res = AX
    ; I = 16b => trebuie sa plasam D in AX; res = DX:AX
    ; I = 32b => trebuie sa plasam D in EAX; res = EDX:EAX
    mov eax, 12
    mov ebx, 3

    ; AX = al * bl (8b * 8b)
    mul bl
    PRINTF32 `%d\n\x0`, eax

    mov eax, 12

    ; AX = al * *(var_byte) (8b * 8b)
    mul byte [var_byte]
    PRINTF32 `%d\n\x0`, eax

    ; Divide
    ; D = I * C + R
    ; syntax: div I (I - reg/mem)
    ; I = 8b => trebuie sa plasam D in AX; C = AL, R = AH
    ; I = 16b => trebuie sa plasam D in DX:AX; C = AX, R = DX
    ; I = 32b => trebuie sa plasam D in EDX:EAX; C = EAX, R = EDX
    mov eax, 14
    mov ebx, 5

    ; AX = bl * al + ah
    div bl
    PRINTF32 `{R, C} = 0x%x\n\x0`, eax

    xor ebx, ebx
    mov bl, al
    PRINTF32 `C = %d\n\x0`, ebx

    xor ebx, ebx
    mov bl, ah
    PRINTF32 `R = %d\n\x0`, ebx

    ; pentru numere negative: idiv, cdq

    leave
    ret
