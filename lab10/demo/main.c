#include <stdio.h>

/**
 * ABI = Application Binary Interface
 * c -> .o
 * asm -> .o
 * 
 * - calling conventions
 * 		- parameters - x86: stack, reverse order
 * 					 - x86_64: registers (rdi, rsi, rdx, rcx, r8, r9) + 7th param -> ... (stack)
 * 		- return value - x86: eax
 * 						- x86_64: rax
 * - data types: size, alignment
 * - syscalls
 * ...
 */

unsigned int asm_max(unsigned int a, unsigned int b);

// Not always inlined
// static inline unsigned int inline_max(unsigned int a, unsigned int b) {
// 	return a >= b ? a : b;
// }

static __attribute__((always_inline)) unsigned int inline_max(unsigned int a, unsigned int b) {
	return a >= b ? a : b;
}

int main(void)
{
	unsigned int a = 4;
	unsigned int b = 10;
	unsigned int inline_asm_max;

	printf("asm_max: %u\n", asm_max(a, b));

	printf("inline_max: %u\n", inline_max(a, b));

	// %0 - inline_asm_max, %1 - a, %2 - b
	// cmp reversed?
	__asm__(
		"mov %0, %1\n"
		"cmp %2, %1\n"
		"jae done\n"
		"xchg %2, %0\n"
		"done:\n"
		: "=r" (inline_asm_max) // output
		: "a" (a), "d" (b) // input
		: // registers used in asm code
	);

	printf("inline_asm_max: %u\n", inline_asm_max);

	return 0;
}
