%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Print the start indices for all occurrences of the substring in source_text
    mov eax, source_text

search_start:
    mov dl, [eax]
    test dl, dl
    je exit

    cmp dl, [substring]
    jne skip_check

    mov esi, eax
    mov edi, substring

search_substring:
    inc esi
    inc edi

    mov dl, [esi]
    mov dh, [edi]

    test dh, dh
    je found_string

    test dl, dl
    je exit

    cmp dl, dh
    je search_substring

    jmp skip_check

found_string:
    pusha

    sub eax, source_text
    push eax
    push print_format
    call printf
    add esp, 8

    popa

skip_check:
    inc eax
    jmp search_start

exit:
    leave
    ret
