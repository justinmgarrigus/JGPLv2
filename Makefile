# Usage: 
#   $ make
#   $ cat examples/simple.jg | bin/parse
#   $ make clean 

all: 
	mkdir -p bin 
	yacc --defines=bin/y.tab.h -o bin/y.tab.cc src/syn.y
	lex -o bin/lex.yy.c src/lex.l
	g++ -c bin/y.tab.cc -o bin/y.tab.o -Isrc
	gcc -c bin/lex.yy.c -o bin/lex.yy.o
	g++ -c src/parse.cc -o bin/parse.o
	g++ bin/lex.yy.o bin/y.tab.o bin/parse.o -o bin/parse

clean: 
	rm -rf bin