all: lex yacc
	g++ lex.yy.c y.tab.c -o program

yacc: projecty.y
	yacc -d -v projecty.y

lex: projectl.l
	lex projectl.l

clean:
	rm -f lex.yy.c y.tab.c program y.tab.h

run: all
	chmod +x run.sh
	./run.sh

test1: all
	cp test1.txt input.txt
	chmod +x run.sh
	./run.sh

test2: all
	cp test2.txt input.txt
	chmod +x run.sh
	./run.sh

test3: all
	cp test3.txt input.txt
	chmod +x run.sh
	./run.sh

test4: all
	cp test4.txt input.txt
	chmod +x run.sh
	./run.sh

test5: all
	cp test5.txt input.txt
	chmod +x run.sh
	./run.sh
