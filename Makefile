all: bin/hello-mac bin/numbers-mac bin/numbers bin/cmdargs-mac bin/cmdargs2-mac



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



cmdargs-mac: bin/cmdargs-mac

bin/cmdargs-mac: bin/cmdargs-mac.o
	ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o bin/cmdargs-mac bin/cmdargs-mac.o

bin/cmdargs-mac.o: src/cmdargs-mac.asm
	nasm -fmacho64 -o bin/cmdargs-mac.o src/cmdargs-mac.asm



cmdargs2-mac: bin/cmdargs2-mac

bin/cmdargs2-mac: bin/cmdargs2-mac.o
	ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o bin/cmdargs2-mac bin/cmdargs2-mac.o

bin/cmdargs2-mac.o: src/cmdargs2-mac.asm
	nasm -fmacho64 -o bin/cmdargs2-mac.o src/cmdargs2-mac.asm



clean:
	rm -f bin/*

.PHONY: all clean hello-mac numbers-mac numbers cmdargs-mac cmdargs2-mac
