%{
  #include "parser.h"
  #include "lexer.h"

  #define emit printf

  void yyerror(yyscan_t scanner, const char *msg) {
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
                   { emit(".global main\n");
                     emit("main:\n"); }
  expr             { emit("  pop %%rax\n");
                     emit("  ret\n"); }

expr:
    "number"       { emit("  push $%d\n", $1); }
  | expr "+" expr  { emit("  pop %%rax\n");
                     emit("  pop %%rbx\n");
                     emit("  add %%rbx, %%rax\n");
                     emit("  push %%rax\n"); }
  | expr "*" expr  { emit("  pop %%rax\n");
                     emit("  pop %%rbx\n");
                     emit("  mul %%rbx\n");
                     emit("  push %%rax\n"); }
  | "(" expr ")"   { /* No action. */ }
