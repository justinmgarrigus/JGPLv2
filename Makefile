# Usage: 
#   $ make
#   $ cat examples/simple.jg | bin/parse
#   $ make clean 

all: 
	mkdir -p bin 
	yacc --defines=bin/y.tab.h -o bin/y.tab.c src/syn.y
	lex -o bin/lex.yy.c src/lex.l
	gcc bin/y.tab.c bin/lex.yy.c -o bin/parse

clean: 
	rm -rf bin
