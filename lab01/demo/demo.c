#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	// (1 + 1) << 2 = 8
	int n = 1 + 1 << 2;
	printf("n = %d\n", n);

	// 1 + (1 << 2) = 5
	int n_ok = 1 + (1 << 2);
	printf("n_ok = %d\n", n_ok);

	// sizeof(int) = 4 (octeti, adica 32 biti)
	int n_shift = 1 << 32;
	printf("n_shift = %d\n", n_shift);

	// sizeof(long long) = 8 (octeti, adica 64 biti)
	long long n_ll_shift = 1 << 32;
	printf("n_ll_shift = %lld\n", n_ll_shift);

	long long n_ll_shift_ok = 1LL << 32;
	printf("n_ll_shift_ok = %lld\n", n_ll_shift_ok);

	// m = 0b1010 .... => negativ
	int m = 0xabcdef01;
	int *p = &m;

	printf("p: %p -> 0x%x\n", p, *p);

	printf("m >> 1 = %d\n", m >> 1);

	// sistem 32 biti => 4 octeti, 64 biti => 8 octeti
	printf("sizeof(p) = %zu\n", sizeof(p));

	char *char_ptr = (char *)&m;

	printf("sizeof(char_ptr) = %zu\n", sizeof(char_ptr));

	// %x - hex int (4)
	// %hx - hex short (2)
	// %hhx - hex char (1)

	for (size_t i = 0; i < sizeof(m); ++i) {
		printf("char_ptr + %zu: %p -> 0x%hhx\n", i, char_ptr + i, *(char_ptr + i));
	}

	char v[] = {0xab, 0xcd, 0xef, 0x01};
	for (size_t i = 0; i < sizeof(v) / sizeof(*v); ++i) {
		printf("v + %zu: %p -> 0x%hhx\n", i, v + i, *(v + i));
	}

	// int v[10];
	// v[1] = *(v + 1) = *(1 + v) = 1[v] ("*(v + sizeof(*v) * 1")

	return 0;
}
