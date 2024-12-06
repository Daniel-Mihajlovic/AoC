%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%union {
  int ival;
  char *sval;
}

%token        MUL
%token        LPAR 
%token        COMMA
%token        RPAR
%token <ival> INT
%token        CORRUPTED

%%

input: | input corrupt_expr | input expr | input tokens ;

tokens
    : LPAR 
    | INT
    | COMMA
    | RPAR
    | op
;

expr 
    : op LPAR INT COMMA INT RPAR { printf("FOUND EXPR: (%d,%d)\n", $3, $5); }
;

corrupt_expr
    : CORRUPTED 
    | op CORRUPTED
    | op LPAR CORRUPTED
    | op LPAR INT CORRUPTED
    | op LPAR INT COMMA CORRUPTED
    | op LPAR INT COMMA INT CORRUPTED
;

op
    : MUL { printf("MUL\n"); }
;

%%

int main(int, char**) {
    yydebug = 1;

    FILE *fp = fopen("input", "r");
    if (!fp) {
        printf("error reading file");
        return -1;
    }

    yyin = fp;
    yyparse();
}

void yyerror(const char *s) {
  printf("parse error!  Message: %s\n", s);
  exit(-1);
}