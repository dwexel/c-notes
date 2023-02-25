%{
  #include <stdio.h>
  #include <math.h>
  #include <string.h>
  #include "gen/parser.h"
%}

whitespace [ \r\n\t]
digit [0-9]
alpha [A-Za-z_]
id    {alpha}*

%%

{whitespace}*   { continue; /* Skip blanks. */ }
{digit}+        { 
                  //sscanf(yytext, "%d", &yylval->ival);
                  yylval->ival = atoi(yytext);
                  return TOKEN_NUMBER; 
                }

do          { return TOKEN_DO; }

{id}        {
              // sscanf(yytext, "%s", &yylval->sval);
              // printf("lex id = %s\n", yytext);
              strcpy(yylval->name, yytext);
              return TOKEN_ID;
            }
"*"         { return TOKEN_STAR; }
"+"         { return TOKEN_PLUS; }
"("         { return TOKEN_LPAREN; }
")"         { return TOKEN_RPAREN; }
"{"         {
              // printf("token lbrace\n"); 
              return TOKEN_LBRACE;
            }
"}"         { 
              // printf("token rbrace\n"); 
              return TOKEN_RBRACE; 
            }
.           { printf("unrecognized character: %s", yytext); }
