CC=gcc
CFLAGS=-Wall -Wextra -m32

build: operations

operations: operations.o
	$(CC) $(CFLAGS) $^ -o $@

operations.o: operations.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./operations

clean:
	rm *.o operations
