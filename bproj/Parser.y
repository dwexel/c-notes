%{
  #include <stdbool.h>
  #include "parser.h"
  #include "lexer.h"
  #include "include/mainf.h"
  void yyerror(yyscan_t scanner, const char *msg) 
  {
    fprintf(stderr, "Error: %s\n", msg);
  }
%}

%pure-parser
%lex-param   { void* scanner }
%parse-param { void* scanner }

%union {
  int value;
}

%token TOKEN_LPAREN   "("
%token TOKEN_RPAREN   ")"
%token TOKEN_PLUS     "+"
%token TOKEN_STAR     "*"
%token <value> TOKEN_NUMBER "number"

%type <void> input
%left "+"
%left "*"

%%

input:
  expr        { printf("input parsed\n"); }

expr:
      "number"  
              { 
                printf("number = %d\n", $1);
                push_number($1);    
              }
  | expr "+" expr   
              { 
                printf("add\n");  
                pop_add();
              }
  | expr "*" expr   
              {
                printf("mult\n"); 
                pop_multiply();
              }
  | "(" expr ")"   
              { 
                printf("paren\n");
              }
