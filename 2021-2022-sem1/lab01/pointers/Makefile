CC=gcc
CFLAGS=-Wall -Wextra

build: pointers

pointers: pointers.o
	$(CC) $(CFLAGS) $^ -o $@

pointers.o: pointers.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./pointers

clean:
	rm *.o pointers
