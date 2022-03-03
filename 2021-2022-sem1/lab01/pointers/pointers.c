#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	int n = 0xabcdef01;
	int *p = &n;

	printf("p: %p -> 0x%x\n", p, *p);

	char *cp = (char *) &n;

	// %hhx - hex char
	printf("cp: %p -> 0x%hhx\n", cp, *cp);
	printf("cp + 1: %p -> 0x%hhx\n", (cp + 1), *(cp + 1));
	printf("cp + 2: %p -> 0x%hhx\n", (cp + 2), *(cp + 2));
	printf("cp + 3: %p -> 0x%hhx\n", (cp + 3), *(cp + 3));

	// %x - hex int
	// Numerele negative au MSB = 1, pe cand cele pozitive au MSB = 0 in cazul
	// in care numarul este interpretat ca fiind cu semn (signed).
	// Astfel, 0x01 e pozitiv, 0xab este negativ.
	// *(cp + i) este "promovat" la int din cauza lui "%x", asa ca afisarea
	// e tradusa in limbaj de asamblare ca un set de instructiuni ce contine si
	// un movsx (discutam despre acesta instructiune peste cateva laboratoare),
	// care copiaza octetul respectiv intr-un registru cu dimensiune de 4 octeti,
	// extinzand bitul de semn.
	printf("cp: %p -> 0x%x\n", cp, *cp);
	printf("cp + 1: %p -> 0x%x\n", (cp + 1), *(cp + 1));
	printf("cp + 2: %p -> 0x%x\n", (cp + 2), *(cp + 2));
	printf("cp + 3: %p -> 0x%x\n", (cp + 3), *(cp + 3));

	// v - adresa, i - int
	// v[i] = *(v + i) = *(i + v) = i[v]
	// int v[10]; => *(v + 1) = v[1] ("*(v + 1 * sizeof(*v))")

	printf("main: %p\n", main);

	// %zu - pentru size_t
	// 8 pe sistem de 64b, 4 pe sistem de 32b
	printf("sizeof(cp) %zu\n", sizeof(cp));

	return 0;
}
