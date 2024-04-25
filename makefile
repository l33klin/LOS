BUILDTOOLS  = ./build-tools/local
AS		= ./build-tools/local/bin/i686-elf-as
GCC		= ./build-tools/local/bin/i686-elf-gcc
RM    = rm

.PHONY : clean all link

all: clean link

clean:
	$(RM) -f *.o *.bin *.elf

boot.o: boot.s
	$(AS) boot.s -o boot.o

kernel.o: kernel.c
	$(GCC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

link: linker.ld boot.o kernel.o
	$(GCC) -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
