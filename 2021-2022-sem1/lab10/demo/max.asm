section .text

global asm_max

asm_max:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov edx, [ebp + 12]

	cmp eax, edx
	jae done
	xchg eax, edx

done:
	leave
	ret
