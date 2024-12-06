%option noyywrap
%{
#include "parser.tab.h"
%}
%%

"mul"               return MUL;
","                 return COMMA;
"("                 return LPAR;
")"                 return RPAR;
[0-9]+              {
                        yylval.ival = atoi(yytext);
                        return INT;
                    }      
.                   return CORRUPTED;
%%