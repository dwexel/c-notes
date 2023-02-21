#include <stdio.h>
#include <stdbool.h>

// generated files
#include "parser.h"
#include "lexer.h"

// my files
#include "include/stack.h"
#include "include/mainf.h"

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

// node stuff
typedef struct node node;
node* new(node n);

enum node_types {
    AST_NUMBER,
    AST_MUL,
    AST_ADD
};

struct node
{
    enum node_types tag;
};

node* node_new(node n)
{
    node *ptr = malloc(sizeof(node));
    if (ptr) *ptr = n;
    return ptr;
}

// global stack
// make static?
stack* main_stack;

void push_number(int n)
{
    push(main_stack, n);
}

void pop_multiply()
{
    int right = pop(main_stack);
    int left = pop(main_stack);
    push(main_stack, right * left);
}

void pop_add()
{
    int right = pop(main_stack);
    int left = pop(main_stack);
    push(main_stack, right + left);
}

int main(void) {
    main_stack = new_stack();

    char line[100];

    puts("enter expression:");
    fgets(line, 100, stdin);

    // puts(line);

    int code = compile(line);

    // char test[] = "4 + 2*10 + 3*(5 + 1)";
    // int code = compile(test);

    while(!empty(main_stack))
    {
        printf("\nstack number = %d", pop(main_stack));
    }

    return code;
}
