%{
  #include <stdbool.h>
  #include "parser.h"
  #include "lexer.h"

  void yyerror(yyscan_t scanner, const char *msg) 
  {
    fprintf(stderr, "Error: %s\n", msg);
  }
%}

%define api.pure
%lex-param   { void* scanner }
%parse-param { void* scanner }

%code requires {
  #include "sym.h"
}

%union {
  int    ival;

  double fval;

  char   name[100];

  symrec*   sympointer;
  void*     none;
}

%token TOKEN_LPAREN   "("
%token TOKEN_RPAREN   ")"
%token TOKEN_PLUS     "+"
%token TOKEN_STAR     "*"
%token TOKEN_HYPH     "-"
%token TOKEN_FSLASH   "/"

%token TOKEN_LBRACE   "{"
%token TOKEN_RBRACE   "}"
%token TOKEN_KEYWORD_DO  "do"

%token <ival> TOKEN_NUMBER "number"
%token <name> TOKEN_ID "id"

%type <none> input
%type <none> line

%type <ival> expr
%type <sympointer> block

%left "+"
%left "*"

%%

input:
  | input line    { 
                  }


line:
  block           { 
                    printf("block id = %p\n", $1);
                    symrec *p = $1;
                    printf("value in block = %lf\n", p->value.var);
                  }
  | expr          { 
                  }

block:
  "id" "{" expr "}"       {
                            symrec *p = putsym($1, SYM_TYPE_INSERT_HERE);
                            p->value.var = $3;
                            // printf("block. %lf\n", p->value.var);
                            //printf("block. name = %s, value of exp = %d, pointer = %p\n", $1, $3, p);
                            $$ = p;
                          }

expr:                         
  "number"                  { $$ = $1; }
  | expr "+" expr           { $$ = $1 + $3; } 
  | expr "*" expr           { $$ = $1 * $3; }
  | expr "-" expr           { $$ = $1 - $3; }
  | expr "/" expr           { $$ = $1 / $3; }
  | "(" expr ")"            { $$ = $2; }



