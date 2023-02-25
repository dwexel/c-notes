CC = gcc
FLEX = win_flex
BISON = win_bison

FILES = lexer.c main.c

build/main: $(FILES)
	$(CC) $(CFLAGS) $(FILES) -o build/main

lexer.c lexer.h: lexer.l
	$(FLEX) --outfile=lexer.c --header-file=lexer.h --nodefault \
		--reentrant --nounistd --noyywrap --warn Lexer.l

clean:
	del lexer.c lexer.h parser.c parser.h

	
