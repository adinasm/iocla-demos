%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139 ; 1000 1011 -> {7, 3, 1, 0}
    mov ebx, 169 ; 1010 1001 -> {7, 5, 3, 0}
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; TODO1: reuniunea a doua multimi
    ; or


    ; TODO2: adaugarea unui element in multime
    ; 0100 0000

    ; mov edx, 1
    ; shl edx, 2 -> edx = 4

    ; or


    ; TODO3: intersectia a doua multimi
    ; and


    ; TODO4: complementul unei multimi
    ; not ATENTIE


    ; TODO5: eliminarea unui element
    ; 1 << x; not; and


    ; TODO6: diferenta de multimi EAX-EBX
    ; A \ B = (A ^ B) ^ B


    xor eax, eax
    ret
