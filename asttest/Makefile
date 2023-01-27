CC = gcc

all: program.exe

program.exe: main.o
	${CC} -o $@ main.o

%.o: %.c
	${CC} -c $< -o $@


