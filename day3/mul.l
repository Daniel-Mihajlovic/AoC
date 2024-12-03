%option noyywrap
%{
#include "mul.tab.h"
%}
%%

[ \t]               ;
[\n]		        {
                        return NEWLINE;
                    }
"mul"               {
                        return MUL;
                    }
","                 {
                        return COMMA;
                    }
"("                 {
                        return LPAR;
                    }
")"                 {
                        return RPAR;
                    }
[a-zA-Z]+           {
                        yylval.sval = strdup(yytext); 
                        return STRING;
                    } 
[^a-zA-Z0-9\(\)]    {
                        yylval.sval = strdup(yytext);
                        return JUNK;
                    }
[0-9]+              {
                        yylval.ival = atoi(yytext);
                        return INT;
                    }
%%