%{
  #include <stdio.h>
  #include "parser.h"
%}

%%

[ \r\n\t]*   { continue; /* Skip blanks. */ }
[0-9]+       { sscanf(yytext, "%d", &yylval->value); 
               return TOKEN_NUMBER; }
"*"          { return TOKEN_STAR; }
"+"          { return TOKEN_PLUS; }
"("          { return TOKEN_LPAREN; }
")"          { return TOKEN_RPAREN; }
.            { continue; /* Ignore unexpected characters. */}
