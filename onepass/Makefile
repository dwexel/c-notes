FILES = lexer.c parser.c main.c

FLEX = win_flex

CC = gcc

main: $(FILES)
	$(CC) $(CFLAGS) $(FILES) -o main

# .c and .h file depend
lexer.c lexer.h: lexer.l
	$(FLEX) --outfile=lexer.c --header-file=lexer.h --nodefault \
		--reentrant --bison-bridge --nounistd --noyywrap --never-interactive --warn Lexer.l

parser.c parser.h: parser.y lexer.c
	bison --output=parser.c --defines=parser.h parser.y

clean:
# rm -f *.o *~ lexer.c lexer.h parser.c parser.h main
	del lexer.c lexer.h parser.c parser.h main
