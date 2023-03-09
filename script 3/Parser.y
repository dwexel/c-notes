%{
  #include <stdbool.h>

  // bridges
  #include <parser.h>
  #include <lexer.h>
  #include <math.h>

  void yyerror(yyscan_t scanner, const char *msg) 
  {
    fprintf(stderr, "Error: %s\n", msg);
  }
%}

%define api.pure
%lex-param   { void* scanner }
%parse-param { void* scanner }

%code requires {
  #include <sym.h>
}

%union {
  int ival;
  double fval;
  // char* sval;
  char sval[100];
  
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
%token TOKEN_COMMA    ","
%token TOKEN_KEYWORD_FN "fn"
%token TOKEN_KEYWORD_END "end"

%token <ival> TOKEN_INTEGER "INTEGER"
%token <fval> TOKEN_DECIMAL "DECIMAL"
%token <sval> TOKEN_ID "ID"

%type <none> start
%type <none> input
%type <none> line

%type <fval> expr
%type <fval> number

%type <sympointer> def
%type <sympointer> params

%left "+"
%left "*"

%%

start:
  input                     {
                              // if (yychar == YYEOF) printf("input parsed\n"); 
                            }

input:
  | input line

line:
  expr                      {
                              // printf("lonely expression: %g\n", $1);
                              $$ = NULL;
                            }
  | def                     { $$ = NULL; }

expr:
  number                    { $$ = $1;      }
  | expr "-" expr           { $$ = $1 - $3; }
  | expr "+" expr           { $$ = $1 + $3; } 
  | expr "/" expr           { $$ = $1 / $3; }
  | expr "*" expr           { $$ = $1 * $3; }
  | "(" expr ")"            { $$ = $2;      }
  | "ID"                    { 
                              printf("identifier: %s\n", $1);
                            }

def:
  "fn" "ID" "(" params ")" expr "end"     {
                                            // put symbol
                                            printf("def parsed\n");
                                            printf("params: %p\n", $4);
                                            for (symrec *p = $4; p; p = p->next)
                                              printf("%p\t%s\t%d\n", p, p->name, p->type);
                                          }

params:
                            { 
                              $$ = NULL; 
                            }
  | "ID"                    {
                              symrec *new = (symrec *) malloc (sizeof (symrec));
                              new->name = strdup($1);
                              $$ = new;
                            }
  | params "," "ID"         {
                              symrec *new = (symrec *) malloc (sizeof (symrec));
                              new->name = strdup($3);
                              new->next = $1;
                              $$ = new;
                            }

number:
  "INTEGER"                 { $$ = (double) $1; }
  | "DECIMAL"               { $$ = $1;          }

