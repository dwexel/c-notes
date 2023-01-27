# object files
OBJS = stack.o eval.o

# complier program
CC = gcc

.PHONY: all clean

all: build/program.exe

clean:
	if exist *.o            del *.o

build:
	@if not exist build mkdir build

# need the pipe
build/program.exe: ${OBJS} | build
	${CC} -o $@ ${OBJS}

%.o: %.c
	${CC} -c $< -o $@

# Dependencies
stack.c : common.h
eval.c : common.h
