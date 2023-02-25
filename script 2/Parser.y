%{
  #include <stdbool.h>
  #include "gen/parser.h"
  #include "gen/lexer.h"
  // #include "include/main.h"
  void yyerror(yyscan_t scanner, const char *msg) 
  {
    fprintf(stderr, "Error: %s\n", msg);
  }
%}

%pure-parser
%lex-param   { void* scanner }
%parse-param { void* scanner }

%union {
  int    ival;
  char   name[100];
}

%token TOKEN_LPAREN   "("
%token TOKEN_RPAREN   ")"
%token TOKEN_PLUS     "+"
%token TOKEN_STAR     "*"
%token TOKEN_LBRACE   "{"
%token TOKEN_RBRACE   "}"
%token TOKEN_DO       "do"

%token <ival> TOKEN_NUMBER "number"
%token <name> TOKEN_ID "id"

%type <ival> input
%type <ival> expr
%type <ival> block

%left "+"
%left "*"

%%

input:
  expr                { 
                        printf("parsed expression: %d\n", $1);
                      }
  | block             { }
  | expr block        { }


expr:
  "number"                  { 
                              // printf("parsed number = %d\n", $1);
                              $$ = $1;
                            }
  | expr "+" expr           {
                              //printf("add\n");   
                              $$ = $1 + $3;
                            }
  | expr "*" expr           { 
                              //printf("mult\n");  
                              $$ = $1 * $3;
                            }
  | "(" expr ")"            { 
                              //printf("paren\n");
                              $$ = $2;
                            }

block:
  "id" "{" expr "}"       { 
                            printf("identified block\n");
                            printf("identifier = %s\n", $1);
                            $$ = 0;
                          }