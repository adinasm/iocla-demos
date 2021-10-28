#IOCLA REMEMBERS

SRC = $(shell find . -name *.c | cut -c3-)
OBJ = $(basename $(SRC))
CC = gcc
CFLAGS=-Wall -Wextra -m32

.PHONY: all
all: build

.PHONY: build
build:
	$(CC) $(CFLAGS) $(SRC) -o $(OBJ)

.PHONY: run
run:
	./$(OBJ)

.PHONY: clean
clean:
	rm $(OBJ)
