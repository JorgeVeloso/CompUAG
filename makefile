all:
	yacc -d interpretador.yacc	
	lex interpretador.lex	
	gcc -o main *.c
	./main
