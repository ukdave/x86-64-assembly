all: bin/hello-mac bin/numbers-mac bin/numbers



hello_mac: bin/hello-mac

bin/hello-mac: bin/hello-mac.o
	ld -static -o bin/hello-mac bin/hello-mac.o

bin/hello-mac.o: src/hello-mac.asm
	nasm -fmacho64 -o bin/hello-mac.o src/hello-mac.asm



numbers-mac: bin/numbers-mac

bin/numbers-mac: bin/numbers-mac.o
	ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o bin/numbers-mac bin/numbers-mac.o

bin/numbers-mac.o: src/numbers-mac.asm
	nasm -fmacho64 -o bin/numbers-mac.o src/numbers-mac.asm



numbers: bin/numbers

bin/numbers: src/numbers.c
	gcc -o bin/numbers src/numbers.c



clean:
	rm -f bin/*

.PHONY: all clean hello-mac numbers-mac numbers
