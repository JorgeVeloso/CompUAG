%{
#include <stdio.h>
#include "tabela.h"

int yylex(void);
void yyerror(char *);

pilha_contexto *pilha;

%}

%token WHILE IF THEN ELSE READ LET NEXT TYPE PRINT NUMBER ID EXPR_ARIT EXPR_REL ATTR DIM AS SUB STRING BREAK OPLOG OPREL DECL RETURN NEW FLOATING
%token INTEGER FLOAT ARRAY MODULE   	// tipos
%token MAIS MENUS MULT DIV MOD 		// aritmeticas
%nonassoc AND OR NOT 	       		// logica
%left LT GT GE LE NE      		// condicionais
%left '+' '-'
%left '/' '*'
//%nonassoc
%%

program:
			
	program funcao	{ }
	|
	; 


funcao:
	DIM ID '(' listaParametroVazio ')' AS TYPE bloco
	;

listaParametroVazio:
	listaParametro
	|
	;

listaParametro:
	listaParametro ',' parametro
	| parametro
	;

parametro: 
	DIM ID AS TYPE
	;

funCall:
	ID '(' argsVazio ')'
	;

argsVazio:
	args
	|
	;
args:
	args ',' expr_arit
	| expr_arit
	;

bloco: 
	'{' 			{ tabela *contexto = criar_contexto(topo_pilha(pilha));
				  pilha = empilhar_contexto(pilha, contexto);

				}
	
	decls stmts '}'		{ imprimir_contexto(topo_pilha(pilha));
				  desempilhar_contexto(&pilha); }
	| funcao
	;

decls: 
	decls decl		{ }
	|
	;
	
decl:
	DIM ID AS TYPE		{	simbolo * s = criar_simbolo((char *) $2, $1); 
					inserir_simbolo(topo_pilha(pilha), s); 
				}
	| array
	;

array:	DIM ID '('NUMBER')' '=' '{'listaValores'}' AS TYPE;

listaValores:	listaValores','valor
		| valor
		;
valor: NUMBER;

stmts: 
	stmts stmt
	| 	
	;

stmt:
	expr_arit
	| expr_rel
	| bloco
	| if_stmt
	| while_stmt
	| attr			
	| PRINT ID		{ simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $2);
				  if(s == NULL)
					yyerror("Identificador não declarado!");
				  else  {
					printf(">>>%d\n", s->val.dval);
			          }
				}		
	;
attr: 
	ID '=' expr_arit 		{ 
					simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
					if(s == NULL)
					yyerror("Identificador não declarado!!");
				  	else  {
					s->val.dval = $3;
				  }
				}
	;

numeros: numeros','valor	{}
	|valor
	;

valor: 
	NUMBER
	;

expr_arit:

	NUMBER		{ $$ = $1; }
	
	| FLOATING	{ $$ = $1;}

	| ID			{ simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
				  if(s == NULL)
					yyerror("Identificador não declarado!!!");
				  else  {
//					printf("(%d, %s, %d)", s->tipo, s->lexema, s->val.dval);
					$$ = s->val.dval;
				  }
				}

	| expr_arit'+' expr_arit	{ $$ = $1 + $3; }
	| expr_arit '-' expr_arit	{ $$ = $1 - $3;}
	| '(' expr_arit ')'		{ $$ = $2; }
	| funCall
	; 


expr_rel:
	  NUMBER		{ $$ = $1; }
	| ID
        | expr_rel OPREL expr_rel
	;	



if_stmt: 
	  IF expr_rel THEN stmt
	| IF expr_rel THEN stmt ELSE stmt			
	;

array:
	DIM ID'(' NUMBER ')' '=' '(' listaValores ')'

	;

listaValores:
	listaValores ',' valor
	| valor
	;

valor: 
	NUMBER
	;

while_stmt: WHILE expr_rel stmt 
	;

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	pilha = NULL;
	yyparse();
	return 0;
}
