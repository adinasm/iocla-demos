#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	// 0b 0001 1001 1101 1100
	// 0x 1 9 D C
	// 1 octet (byte) = 8 biti
	// A = 1010

	// x in {0, 1}

	// &
	// 0b0010
	// 0b1010
	// 0b0010 (2)
	// x & 0 = 0
	// x & 1 = x

	// |
	// 0b0010
	// 0b1010
	// 0b1010 (10)
	// x | 0 = x
	// x | 1 = 1

	// ^
	// 0b0010
	// 0b1010
	// 0b1000 (8)
	// x ^ 0 = x
	// x ^ 1 = ~x
	// x ^ x = 0
	// x ^ ~x = 1

	// 1 << p == pow(2, p)
	// int n = 1 << 2;
	int n = 3 << 2; // 0b 0000 0011 => 0b 0000 1100
	printf("n = %d\n", n);

	// warning
	// n = 1 << 32;
	// printf("n = %d\n", n);

	// warning, 1 e tratat ca int
	// long long n_ll = 1 << 32;
	// printf("n_ll = %lld\n", n_ll);

	long long n_ll = 1LL << 32;
	printf("n_ll = %lld\n", n_ll);

	int x = 2 + 1 << 2; // 3 << 2
	printf("x = %d\n", x);

	x = 2 + (1 << 2); // 6
	printf("x = %d\n", x);

	x = 2 + 3 >> 2; // 5 >> 2
	printf("x = %d\n", x);

	return 0;
}
