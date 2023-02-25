#include <stdio.h>
#include <stdbool.h>

// generated files
#include "gen/parser.h"
#include "gen/lexer.h"

// my files
#include "main.h"

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

int id = -1;
int newid(void) {
    id++;
    // printf("new id = %d\n", id);
    return id;
}

int main(void) {
    FILE *f;
    char line[100];
    
    f = fopen("test.txt", "r");
    if (f == NULL) perror("file not found");
    fgets(line, sizeof(line), f);
    fclose(f);

    //printf("line = %s\n", line);
    int code = compile(line);
    return code;
}
