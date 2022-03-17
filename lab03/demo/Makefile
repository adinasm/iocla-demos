CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -no-pie -m32

.DEFAULT_GOAL: all

.PHONY: all clean

all: main_static main_dynamic

main_dynamic: main.o hidden.o plain.o
	$(CC) $(LDFLAGS) -o $@ $^
	# ld -dynamic-linker /lib/ld-linux.so.2 -m elf_i386 -o $@ /usr/lib32/crt1.o /usr/lib32/crti.o $^ -lc /usr/lib32/crtn.o

main_static: main.o hidden.o plain.o
	$(CC) $(LDFLAGS) -static -o $@ $^
	# ld -static -m elf_i386 -L/usr/lib/gcc/x86_64-linux-gnu/9/32/ -o $@ /usr/lib32/crt1.o /usr/lib32/crti.o $^ --start-group -lc -lgcc -lgcc_eh --end-group /usr/lib32/crtn.o

main.o: main.c ops.h

hidden.o: hidden.c

plain.o: plain.c

clean:
	-rm -f main_static main_dynamic main.o hidden.o plain.o
	-rm -f *~
