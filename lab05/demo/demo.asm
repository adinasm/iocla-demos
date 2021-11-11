%include "../io.mac"

section .data
    myString: db "Hello, World!", 0
    val: dd 123

section .text
    global main
    extern printf

; x86 - CISC
; ISA
; - instructiuni
; - moduri de adresarea memoriei
; - registre
; - tipuri de date
; ...

; EAX                AX      AL
; 31                15  AH  7       0
; |................|.......|.......|
; |................|.......|.......|

; Registre - x86 (32 biti) / x86_64 (64 biti)
; - general purpose - EAX/RAX, EBX/RBX, ...
; - IP/PC - EIP/RIP
; - SP - ESP/RSP (f -> g -> h)
; - FLAGS - EFLAGS

main:
    ; instructiuni
    ; - folosim sintaxa Intel

    ; Tipuri
    ; - operator
    ; - op <opnd1>
    ; - op <opnd1> <opnd2>

    ; Tipuri
    ; - aritmetice/logice:
    ;     add, sub, mul, div, xor, and, or, shl, ...
    ;     inc, dec, not, ...
    ; - control: jmp (salt neconditionat), jnz, je, jc (salturi conditionate),
    ;     cmp, test, call (apel de functie), ret
    ; - transfer de date: mov (move, load, store)

    ; gdb -> info registers

    mov ecx, 6                      ; N = valoarea registrului ecx
    mov eax, 2
    mov ebx, 1
    ; sub eax, ebx ; eax <- eax - ebx, modifica eax + eflags
    cmp eax, ebx ; eax - ebx, nu modifica eax, dar modifica eflags
    je print                        ; TODO1: eax > ebx?


    ; jmp la print daca eax e 0
    ; cmp eax, 0
    ; and eax, eax; eax <- eax & eax
    ; test eax, eax ; eax & eax, nu modifica eax, dar modifica eflags
    ; je print
    ; ret

    ; val - o adresa
    ; ebx <- val
    mov ebx, val
    PRINTF32 `%x\n\x0`, ebx

    ; eax <- ebx
    mov eax, ebx
    PRINTF32 `%x\n\x0`, eax

    ; eax <- *ebx
    mov eax, [ebx]
    PRINTF32 `%d\n\x0`, eax

    ; eax <- eax + 2; NU modifica ce se afla la adresa val
    add eax, 2
    PRINTF32 `%d\n\x0`, eax

    ; *ebx += 2; modifica
    add DWORD [ebx], 2
    PRINTF32 `%d\n\x0`, [ebx]
    

print:
    PRINTF32 `%s\n\x0`, myString
                                    ; TODO2.2: afisati "Hello, World!" de N ori
                                    ; TODO2.1: afisati "Goodbye, World!"

    ret
