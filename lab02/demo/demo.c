#include <stdio.h>
#include <stdlib.h>

char global_str[] = "salut";

char *ptr1 = "salut"; // ptr1 - data, "salut" - rodata

int *func() {
	int n = 1; // stiva

	return &n;
}

int f(int n) {
	return n + 2;
}

int main() {
	int v[10];

	// v - eticheta, label
	printf("v = %p\n", v);
	printf("&v = %p\n", &v);
	printf("sizeof(v) = %zu\n", sizeof(v)); // 10 * sizeof(int)
	printf("num_elements = %zu\n", sizeof(v) / sizeof(*v));

	int *vp = &v;
	printf("vp = %p\n", vp);
	printf("&vp = %p\n", &vp);
	printf("sizeof(vp) = %zu\n", sizeof(vp));

	int *p = malloc(10);
	printf("p = %p\n", p);
	printf("&p = %p\n", &p);
	printf("sizeof(p) = %zu\n", sizeof(p));
	free(p);

	printf("global_str = %p\n", global_str);
	printf("&global_str = %p\n", &global_str);
	printf("sizeof(global_str) = %zu\n", sizeof(global_str));

	char stack_str[] = "salut";
	printf("stack_str = %p\n", stack_str);
	printf("&stack_str = %p\n", &stack_str);
	printf("sizeof(stack_str) = %zu\n", sizeof(stack_str));

	printf("ptr1 = %p\n", ptr1);
	printf("&ptr1 = %p\n", &ptr1);
	printf("sizeof(ptr1) = %zu\n", sizeof(ptr1));

	char *ptr2 = "salut"; // ptr2 - pe stiva, "salut" - in rodata
	printf("ptr2 = %p\n", ptr2);
	printf("&ptr2 = %p\n", &ptr2);
	printf("sizeof(ptr2) = %zu\n", sizeof(ptr2));

	printf("func() = %p\n", func());

	// int *f_ptr(int) -  declarare de functie
	int (*f_ptr)(int) = f;

	printf("f = %p\n", f);
	printf("f_ptr = %p\n", f_ptr);

	printf("f_ptr(3) = %d\n", f_ptr(3));

	printf("printf = %p\n", printf);

	sleep(1000);

	return 0;
}
