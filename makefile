BUILDTOOLS  = ./build-tools/local
AS		= ./build-tools/local/bin/i686-elf-as
GCC		= ./build-tools/local/bin/i686-elf-gcc
RM    = rm

.PHONY : build clean all link

all: clean build link

clean:
	$(RM) -f *.o *.bin *.elf

build:
  ./build-tools/local/bin/i686-elf-as boot.s -o boot.o
  ./build-tools/local/bin/i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

link: ./build-tools/local/bin/i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
