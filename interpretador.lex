%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}

letra	[a-z|A-Z|_] 
numero	[0-9]
float {numero}+(\.{numero}+)?(E[+-]?{numero}+)?
identificador	{letra}({letra}|{numero})*
OPREL 	"<>"|"<"|">"|">="|"<="

%%

"<>" 		{	return OPREL;
		}
"<"		{	return OPREL;
		}
">" 		{	return OPREL;
		}
">="		{	return OPREL;
		}
"<=" 		{	return OPREL;
		}
"=="		{	return OPREL;
		}

"DIM"  		{	return DIM;
		}
"AS"  		{	return AS;
		}


"IF" 		{       return IF;
		}

"ELSE"		{	return ELSE;
		}

"WHILE"		{	return WHILE;
		}

"THEN"		{	return THEN;
		}

"NUMBER" 	{	yylval = atoi(yytext);
		  	return NUMBER;
		}


{numero}+	{ 	yylval = atoi(yytext);
		  	return NUMBER;
		}

"INTEGER"	{	yylval = INTEGER;
			return TYPE;
		}
"FLOAT"		{
			yylval = FLOAT;
			return TYPE;
		}


PRINT		{	return PRINT; 
		}

{identificador}	{
			yylval = (int) strdup(yytext);
			return ID;
		}

[-+=(){};,]	{	return *yytext; }



[ \t\n] 	; /* skip whitespace */
. 	yyerror("invalid character");
%%
int yywrap(void) {
return 1;
}
