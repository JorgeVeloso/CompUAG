%{
#include <stdio.h>
#include "tabela.h"
#include "arvore.h"
#include "codigo_intermediario.h"

int yylex(void);
void yyerror(char *);

pilha_contexto *pilha;

%}

%token FOR IF THEN ELSE READ LET NEXT TYPE PRINT NUMBER ID EXPR ATTR END
%token INT FLOAT BOOL ARRAY  // tipos
%token ADD SUB MULT DIV MOD  // aritmeticas
%token AND OR NOT 	     // logica
%token LT GT GE LE EQ NE     // condicionais
%left '+' '-'
%left '/' '*'

%%


program:
			
	program bloco		{ }
	|
	; 	

bloco: 
	'{' 			{ tabela *contexto = criar_contexto(topo_pilha(pilha));
				  pilha = empilhar_contexto(pilha, contexto);

				}
	decls stmts '}'		{ imprimir_contexto(topo_pilha(pilha));
				  desempilhar_contexto(&pilha); }
	;

decls: 
	decls decl		{ }
	|
	;
	
decl:
		ID ';'		{	simbolo * s = criar_simbolo((char *) $2, $1); 
					inserir_simbolo(topo_pilha(pilha), s); }

	;

stmts: 
	stmts stmt
	| 	
	;

stmt:
	expr ';'		{	gerar_codigo((no_arvore *) $1); }
	| bloco
	| attr			{	gerar_codigo((no_arvore *) $1); }
	| if_stmt		{	gerar_codigo((no_arvore *) $1); }
	;

attr: 
	ID '=' expr ';'		{ simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
				  if(s == NULL)
					yyerror("Identificador não declarado");
				  else  {
					no_arvore *n = criar_no_atribuicao(s, (void *) $3);
					$$ = (int) n;
				  }
				}
	;
if_stmt: if expr THEN stmt
	|if expr THEN stmt else stmt	

expr:
	 NUMBER			{ no_arvore *n = criar_no_expressao(NUMBER, (void *) $1, NULL); 
				  $$ = (int) n; }
	| ID			{ simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
				  if(s == NULL)
					yyerror("Identificador não declarado");
				  else  {
					no_arvore *n = criar_no_expressao(ID, s, NULL);
					$$ = (int) n;
				  }
				}
	| expr '+' expr		{ no_arvore *n = criar_no_expressao('+', (void *) $1, (void *) $3); 
				  $$ = (int) n; }
	| expr '-' expr		{ no_arvore *n = criar_no_expressao('-', (void *) $1, (void *) $3);
				  $$ = (int) n; }
/*	
	| expr '*' expr		{ no_arvore *n = criar_no_expressao('*', (void *) $1, (void *) $3);
				  $$ = (int) n; }

	| expr '/' expr		{ no_arvore *n = criar_no_expressao('/', (void *) $1, (void *) $3);
				  $$ = (int) n; }

*/
	| '(' expr ')'		{ $$ = $2; }
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
