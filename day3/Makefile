all: parser.tab.c lex.yy.c main

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

main: lex.yy.c parser.tab.c parser.tab.h
	gcc parser.tab.c lex.yy.c -o main

d: 
	flex lexer.l
	bison -d parser.y -v --graph
	gcc parser.tab.c lex.yy.c -o main

c:
	rm lex.yy.c parser.tab.c parser.tab.h main.output parser.gv parser.output main