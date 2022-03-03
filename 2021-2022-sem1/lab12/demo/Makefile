CFLAGS = -Wall -m32 -g -fno-stack-protector -Wno-unused-function -mpreferred-stack-boundary=2 -fno-PIC
LDFLAGS = -no-pie -m32

all: demo

demo: demo.o

clean:
	-rm -f *~
	-rm -f peda-session*.txt
	-rm -f demo.o
	-rm -f demo
