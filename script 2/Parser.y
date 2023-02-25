%{
  #include <stdbool.h>
  #include "parser.h"
  #include "lexer.h"
  #include "../main.h"
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
%type <ival> line


%left "+"
%left "*"

%%

input:
  | input line       { printf("line parsed\n"); }

line:
  block            { printf("block id = %d\n", $1); }
  | expr           { printf("value of expression = %d\n", $1); }

block:
  "id" "{" expr "}"       { 
                            // printf("identified block\n");
                            // printf("identifier = %s\n", $1);
                            $$ = newid();
                          }
expr:
  "number"                  { $$ = $1; }
  | expr "+" expr           { $$ = $1 + $3; } 
  | expr "*" expr           { $$ = $1 * $3; }
  | "(" expr ")"            { $$ = $2; }

