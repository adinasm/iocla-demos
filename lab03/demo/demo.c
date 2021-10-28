#include <stdio.h>

/*
	GDB
	- breakpoint la o adresa: b *0x00100748
*/

/*
	Build:
	- preprocesare (.c -> .i)
	- compilare (.i -> .s)
	- asamblare (.s -> .o)
	- linkare (1 sau mai multe .o, biblioteci -> executabil)

	Load time:
	- executabil -> proces

	Run time:
	- proces
*/

/*
	Linux kernel: https://elixir.bootlin.com/linux/latest/source
*/

int main() {
// 	for (...)
// 		for (...)
// 			for(...)
// 				if (ceva)
// 					goto out; // jmp label
// out:

	int condition = 0;

	// If - clasic
	if (condition) {
		printf("Then\n");
		// then branch
	} else {
		printf("Else\n");
		// else branch
	}

	printf("Done\n");

	// If - gotos
	if (condition)
		goto then_branch;

// else_branch:
	printf("Else\n");
	// else branch

	goto if_exit;

then_branch:
	printf("Then\n");
	// then branch

if_exit:
	printf("Done\n");

	return 0;
}
