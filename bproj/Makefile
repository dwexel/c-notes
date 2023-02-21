FILES = lexer.c parser.c main.c stack.c

CC = gcc
FLEX = win_flex
BISON = win_bison

build/main: $(FILES)
	$(CC) $(CFLAGS) $(FILES) -o build/main

lexer.c lexer.h: lexer.l
	$(FLEX) --outfile=lexer.c --header-file=lexer.h --nodefault \
		--reentrant --bison-bridge --nounistd --noyywrap --never-interactive --warn Lexer.l

parser.c parser.h: parser.y lexer.c
	$(BISON) --output=parser.c --defines=parser.h parser.y

clean:
	del lexer.c lexer.h parser.c parser.h

	
