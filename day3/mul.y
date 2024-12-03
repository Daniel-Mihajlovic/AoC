%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%union {
  int ival;
  char *sval;
}

%token MUL
%token LPAR
%token RPAR
%token NEWLINE
%token COMMA
%token <sval> JUNK
%token <ival> INT
%token <sval> STRING

%%
file:
    line
;

line: 
    line seq
    | line mul
    | seq
;

seq: 
    STRING      {printf("STRING\n");}
    | INT       {printf("INT\n");}
    | MUL       {printf("MUL\n");}
    | LPAR      {printf("LPAR\n");}
    | RPAR      {printf("RPAR\n");}
    | COMMA     {printf("COMMA\n");}
    | JUNK      {printf("JUNK\n");}
    | NEWLINE   {printf("NEWLINE\n");}
;

mul:
    MUL LPAR INT ',' INT RPAR {
        int result = $3 * $5;
        printf("FOUND MUL - RESULT: %d\n", result);
    }
;
%%

int main(int, char**) {
    FILE *fp = fopen("test.txt", "r");
    if (!fp) {
        printf("error reading file");
        return -1;
    }

    yyin = fp;
    yyparse();
}

void yyerror(const char *s) {
  printf("parse error!  Message: %s", s);
  exit(-1);
}