%{
  #include <stdbool.h>
  // headers
  #include <parser.h>
  #include <lexer.h>

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
  int       ival;
  double    fval;
  char      name[100];
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

%token <ival> TOKEN_INTEGER "integer"
%token <fval> TOKEN_DECIMAL "decimal"
%token <name> TOKEN_ID "id"

%type <none> start
%type <none> input
%type <none> line

%type <fval> expr
%type <fval> number
%type <sympointer> block

%left "+"
%left "*"

%%

start:
  input                     {
                              // if (yychar == YYEOF) printf("input parsed\n"); 
                              // printf("most recent symbol = %lf", sym_table->value.f);
                            }

input:
  | input line


line:
  block                     { $$ = NULL; }
  | expr                    { 
                              printf("lonely expression: "); 
                              // printf("    %s\n", $1);
                              printf("%lf\n", $1);
                              $$ = NULL; 
                            }

block:
  "id" "{" expr "}"         {
                              symrec *p = putsym($1, SYM_TYPE_INSERT_HERE);
                              p->value.f = $3;
                              $$ = p;

                              // printf("parsed block, value of block = %lf\n", $3);
                            }

expr:                         
  number                    { $$ = $1; }
  | expr "-" expr           { $$ = $1 - $3; }
  | expr "+" expr           { $$ = $1 + $3; } 
  | expr "/" expr           { $$ = $1 / $3; }
  | expr "*" expr           { $$ = $1 * $3; }
  | "(" expr ")"            { $$ = $2; }
  | "id"                    {
                              symrec *p = getsym($1);
                              
                              if (p == NULL) 
                              {
                                fprintf(stderr, "unkown identifier: %s\n", $1);
                                return 1;
                              }


                              $$ = p->value.f;
                              //printf("invoked identifier %s: %lf\n", p->name, p->value.f);
                            }

number:
  "integer"                 { $$ = (double) $1; }
  | "decimal"               { $$ = $1;          }

