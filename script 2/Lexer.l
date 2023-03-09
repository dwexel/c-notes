%{
  #include <stdio.h>
  #include <math.h>
  #include <string.h>
  // headers
  #include <parser.h>
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
                  return TOKEN_INTEGER;
                }

{digit}+"."{digit}*   {
                        // printf("a demical: %lf\n", atof(yytext));

                        yylval->fval = atof(yytext);
                        return TOKEN_DECIMAL;
                      }

do              { 
                  return TOKEN_KEYWORD_DO; 
                }

{id}        {
              // sscanf(yytext, "%s", &yylval->sval);
              // printf("lexer. identifier = %s\n", yytext);
              if (strlen(yytext) > 100) perror("identifier too long");
              strcpy(yylval->name, yytext);
              return TOKEN_ID;
            }
"+"         { return TOKEN_PLUS; }
"*"         { return TOKEN_STAR; }
"-"         { return TOKEN_HYPH; }
"/"         { return TOKEN_FSLASH; }

"("         { return TOKEN_LPAREN; }
")"         { return TOKEN_RPAREN; }
"{"         { return TOKEN_LBRACE; }
"}"         { return TOKEN_RBRACE; }
.           {
              printf("unrecognized character: %s\n", yytext);
            }
