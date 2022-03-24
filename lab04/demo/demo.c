#include <stdio.h>

int main() {
	int cond = 0;

	if (cond)
		printf("If\n");
	else
		printf("else\n");

	if (cond)
		goto if_branch;

	printf("else\n");

	goto stop;

if_branch:
	printf("If\n");
	
stop:
	return 0;
}
