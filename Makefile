NAME  = $(shell basename `pwd`)
PNAME = rand_demo

all: $(PNAME)

main.o: main.c
	gcc -fPIC -O3 -c $^ -o $@

$(PNAME): main.o $(NAME).o
	gcc -pie -s $^ -o $@

$(NAME).o: $(NAME).asm
	nasm -f elf64 $^ -o $@

edit:
	vim -c 'set nu et' $(NAME).asm

clean:
	-rm -f $(PNAME) main.o $(NAME).o

.PHONY: all edit clean
