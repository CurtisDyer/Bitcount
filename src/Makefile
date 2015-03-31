# Makefile - build from source
# Author: Curtis Dyer
# Class: CS-3
#
# Midterm

CC=gcc
AS=nasm
CFLAGS=-std=c99 -O2 -g
ASFLAGS=-f elf64
BIN=driver

%.o: %.asm
	$(AS) $(CFLAGS) -o $@ $< $(ASFLAGS)

$(BIN): prompt.o bitcount.o
	$(CC) $(CFLAGS) -o $(BIN) prompt.o bitcount.o driver.c

.PHONY: clean

clean:
	rm -f *.o $(BIN)
