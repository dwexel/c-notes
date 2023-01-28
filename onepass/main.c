#include <stdio.h>

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

int main(void) {
    char test[] = "4 + 2*10 + 3*(5 + 1)";
    int code = compile(test);
    return code;
}

