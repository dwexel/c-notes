#include <stdio.h>
#include <stdbool.h>

// generated files
#include "lexer.h"

// my files
// #include "include/mainf.h"

int main(int argc, char** argv)
{
    ++argv;
    --argc;

    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else
        yyin = stdin;
    
    int tok;
    while(tok = yylex())
    {
        // printf("tok = %i\n", tok);
    }
    // yylex();


}

// int main(void) 
// {   
//     char line[100];
//     puts("enter expression:");
//     fgets(line, 100, stdin);
//     return 0;
// }
