#include <stdio.h>
#include <stdbool.h>
#include <math.h>

// generated files
#include "parser.h"
#include "lexer.h"

int yyparse(yyscan_t scanner);
int compile(const char *source) {
    yyscan_t scanner;
    YY_BUFFER_STATE state;

    if (yylex_init(&scanner)) {
        return 1; /* could not initialize */
    }

    state = yy_scan_string(source, scanner);
    if (yyparse(scanner)) {
        return 2; /* error parsing */
    }
    
    yy_delete_buffer(state, scanner);
    yylex_destroy(scanner);
    return 0;
}

// int id = -1;
// int newid(void) {
//     id++;
//     // printf("new id = %d\n", id);
//     return id;
// }


void catfile(char* destination, char *filename) {
	FILE *f = fopen(filename, "r");
    if (f == NULL) perror("file not found");
    // safe?
	char line[100];
	while (fgets(line, 100, f))
		strcat(destination, line);
    fclose(f);
}

// INIT

// struct init
// {
//   char const *name;
//   func_t *fun;
// };

// struct init const funs[] =
// {
//   { "atan", atan },
//   { "cos",  cos  },
//   { "exp",  exp  },
//   { "ln",   log  },
//   { "sin",  sin  },
//   { "sqrt", sqrt },
//   { 0, 0 },
// };

/* The symbol table: a chain of 'struct symrec'. */
// symrec *sym_table;

// /* Put functions in table. */
// static void init_table (void)
// {
// 	for (int i = 0; funs[i].name; i++)
// 	{
// 		symrec *ptr = putsym (funs[i].name, FUN);
// 		ptr->value.fun = funs[i].fun;
// 	}
// }


int main(int argc, char** argv) {
    // ++argv;
    // --argc;

    char file[800];
    catfile(file, "./test/test.txt");
    int code = compile(file);
    return code;
}
