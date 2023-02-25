# GEN_DIR = gen

FILES = gen/lexer.c gen/parser.c main.c

CC = gcc
FLEX = win_flex
BISON = win_bison

build/main: $(FILES)
	$(CC) $(CFLAGS) $(FILES) -o build/main

gen/lexer.c gen/lexer.h: lexer.l
	$(FLEX) --outfile=lexer.c --header-file=lexer.h --nodefault \
		--reentrant --bison-bridge --nounistd --noyywrap --never-interactive --warn Lexer.l

gen/parser.c gen/parser.h: parser.y gen/lexer.c
	$(BISON) --output=parser.c --defines=parser.h --warnings=deprecated parser.y

clean:
	del lexer.c lexer.h parser.c parser.h

	
