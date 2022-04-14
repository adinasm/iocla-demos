%include "../../utils/printf32.asm"

struc demo_struct
    .num: resw 1
    name: resb 20
endstruc

struc another_struct
    x: resd 3
    y: resb 1
    z: resw 12
    .num: resb 1
endstruc

section .data
    array dw 12, 3, 45, 1, 24, 17, 5, 6, 9, 10
    arr2 times 5 dw 12
    len equ 10

    struct_instance:
    istruc demo_struct
        at demo_struct.num, dw 0x1234
        at name, db "pclp", 0 ; 'p', 'c', 'l', 'p', 0
    iend

section .bss
    number resd 1

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    PRINTF32 `num = %d\n\x0`, demo_struct.num
    PRINTF32 `name = %d\n\x0`, name

    PRINTF32 `x = %d\n\x0`, x
    PRINTF32 `y = %d\n\x0`, y
    PRINTF32 `z = %d\n\x0`, z

    PRINTF32 `struct_instance.num = 0x%hx\n\x0`, [struct_instance]
    PRINTF32 `struct_instance.num = 0x%hx\n\x0`, [struct_instance + demo_struct.num]
    PRINTF32 `struct_instance.num = 0x%hx\n\x0`, [struct_instance + x]

    PRINTF32 `struct_instance.name = %c\n\x0`, [struct_instance + name]
    PRINTF32 `struct_instance.name = %s\n\x0`, struct_instance + name

    mov word [struct_instance + demo_struct.num], 0x5678
    PRINTF32 `struct_instance.num = 0x%hx\n\x0`, [struct_instance + demo_struct.num]

    mov byte [struct_instance + name], 'b'
    mov byte [struct_instance + name + 1], 'u'
    mov byte [struct_instance + name + 2], 'n'
    mov byte [struct_instance + name + 3], 'a'
    PRINTF32 `struct_instance.name = %s\n\x0`, struct_instance + name

    mov dword [struct_instance + name], "bruh"
    PRINTF32 `struct_instance.name = %s\n\x0`, struct_instance + name

    mov ecx, demo_struct_size

    xor ecx, ecx

print_struct:
    cmp ecx, demo_struct_size
    jz print_struct_end

    PRINTF32 `struct_instance[%d] = 0x%hhx\n\x0`, ecx, [struct_instance + ecx]

    inc ecx
    jmp print_struct

print_struct_end:

    mov ecx, len

    xor eax, eax

add_odd:
    mov ebx, [array + ecx * 2 - 2]
    test ebx, 1
    jz skip_even

    PRINTF32 `arr[%d] = %hd\n\x0`, ecx, ebx

    add eax, ebx

skip_even:
    loop add_odd

    PRINTF32 `sum = %hd\n\x0`, eax

    mov dx, 0
    mov ax, 37

    mov bx, 5

    div bx

    PRINTF32 `C = %hd\n\x0`, eax
    PRINTF32 `R = %hd\n\x0`, edx

    mov ecx, 5

arr2_loop:
    mov ebx, [arr2 + ecx * 2 - 2]
    PRINTF32 `arr2[%d] = %hd\n\x0`, ecx, ebx

    loop arr2_loop

    xor eax, eax
    leave
    ret
