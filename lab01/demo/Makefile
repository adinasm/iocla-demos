CC=gcc
CFLAGS=-Wall -Wextra -m32

build: demo

demo: demo.o
	$(CC) $(CFLAGS) $^ -o $@

demo.o: demo.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./demo

clean:
	rm *.o demo
