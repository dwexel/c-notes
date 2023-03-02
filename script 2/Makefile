FILES = lexer.c parser.c main.c sym.c

FLEX = win_flex
BISON = win_bison

CC = gcc
CFLAGS = -I"C:\Users\dexte\Documents\GitHub\c-notes\script 2\include"
HEADER_DIR = include

build/main: $(FILES)
	$(CC) $(CFLAGS) $(FILES) -o build/main

# .c and .h file depend
lexer.c lexer.h: lexer.l
	$(FLEX) --outfile=lexer.c --header-file=$(HEADER_DIR)/lexer.h --nodefault \
		--reentrant --bison-bridge --nounistd --noyywrap --never-interactive --warn Lexer.l

parser.c parser.h: parser.y lexer.c
	$(BISON) --output=parser.c --defines=$(HEADER_DIR)/parser.h parser.y

clean:
# rm -f *.o *~ lexer.c lexer.h parser.c parser.h main
	del lexer.c lexer.h parser.c parser.h
