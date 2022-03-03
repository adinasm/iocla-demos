#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

/*
Inspectat sectiuni (mai sunt si altele pe langa cele din comenzile de azi):
		readelf -x .rodata demo
		readelf -x .data demo

Mapari memorie:
	pmap $(pidof demo)

Permisiuni sectiuni discutate:
- rodata: r--
- data: rw-
- text: r-x

Comenzi gdb discutate:
- start (ca un b main urmat de run)
- run
- b/break
- c/continue
- p/print
- x

cheatsheet gdb: https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf
Imaginea unui proces in memorie: https://i.stack.imgur.com/9ZHwD.png
*/

// global_str e adresa din data la care e salvat "salut"
char global_str[] = "salut";

// ptr1 - in data, contine adresa lui "salut", "salut" - in rodata
char *ptr1 = "salut";

int *func() {
	int n = 1; // pe stiva

	return &n; // big nono
}

int f(int n) {
	return n + 2;
}

int main() {
	// v - eticheta, label
	// pe stiva
	int v[10];

	printf("v = %p\n", v);
	printf("&v = %p\n", &v);
	printf("sizeof(v) = %zu\n", sizeof(v)); // 10 * sizeof(int)
	printf("num_elements = %zu\n", sizeof(v) / sizeof(*v));

	// vp - pe stiva, contine o adresa de pe stiva
	int *vp = (int *)&v;
	printf("vp = %p\n", vp);
	printf("&vp = %p\n", &vp);
	printf("sizeof(vp) = %zu\n", sizeof(vp));

	// eroare de compilare
	// v = 20;

	// poate fi modificat
	// vp = 20;

	// p - pe stiva, contine adresa de pe heap la care a fost alocata memoria
	int *p = malloc(10);
	assert(p != NULL);
	printf("p = %p\n", p);
	printf("&p = %p\n", &p);
	printf("sizeof(p) = %zu\n", sizeof(p));
	free(p);

	printf("global_str = %p\n", global_str);
	printf("&global_str = %p\n", &global_str);
	printf("sizeof(global_str) = %zu\n", sizeof(global_str));

	// stack_str e o adresa de pe stiva la care e salvat "salut"
	char stack_str[] = "salut";
	printf("stack_str = %p\n", stack_str);
	printf("&stack_str = %p\n", &stack_str);
	printf("sizeof(stack_str) = %zu\n", sizeof(stack_str));

	printf("ptr1 = %p\n", ptr1);
	printf("&ptr1 = %p\n", &ptr1);
	printf("sizeof(ptr1) = %zu\n", sizeof(ptr1));

	// ptr2 - pe stiva, contine adresa din rodata a lui "salut"
	char *ptr2 = "salut";
	printf("ptr2 = %p\n", ptr2);
	printf("&ptr2 = %p\n", &ptr2);
	// !!! sizeof(ptr2) != strlen(ptr2)
	// sizeof(ptr2) == sizeof(void *) aka dimensiunea unei adrese, pe cand
	// strlen(ptr2) reprezinta lungimea lui "salut"
	printf("sizeof(ptr2) = %zu\n", sizeof(ptr2));
	printf("strlen(ptr2) = %zu\n", strlen(ptr2));

	printf("func() = %p\n", func());

	// int *f_ptr(int) - declarare de functie
	// int (*f_ptr)(int) - pointer la functie
	int (*f_ptr)(int) = f;

	// f_ptr contine o adresa din zona text
	printf("f = %p\n", f);
	printf("f_ptr = %p\n", f_ptr);

	printf("f_ptr(3) = %d\n", f_ptr(3));

	// peste mai multe laburi: mapare biblioteci
	printf("printf = %p\n", printf);

	sleep(1000);

	return 0;
}
