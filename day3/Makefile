all: mul.tab.c lex.yy.c mul

mul.tab.c mul.tab.h: mul.y
	bison -d mul.y

lex.yy.c: mul.l mul.tab.h
	flex mul.l

mul: lex.yy.c mul.tab.c mul.tab.h
	gcc mul.tab.c lex.yy.c -o mul

debug: 
	bison -d mul.y -v

clean:
	rm lex.yy.c mul.tab.c mul.tab.h mul.output