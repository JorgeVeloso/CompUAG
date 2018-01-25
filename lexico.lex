%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}

letra	[a-z|A-Z|_] 
integer	[0-9]
float {integer}+(\.{integer}+)?(E[+-]?{integer}+)?
identificador	{letra}({letra}|{integer})*
string "{identificador}"
boolean [true|false]
and	"and"
or	"or"
not	"not"
if	"if"
else 	"else"
for 	"for"
OPREL 	"="|"<>"|"<"|">"|">="|"<="
OPLOG	"and"|"or"|"not"

%%

{integer}+	{ yylval = atoi(yytext);
		  return NUMBER;
		}


"INTEGER"	{	yylval = INT;
			return TYPE;
		}
"FLOAT"		{
			yylval = FLOAT;
			return TYPE;
		}

PRINT		{	return PRINT; 
		}

{identificador}+ {	printf("teste2");
			yylval = strdup(yytext);
			return ID;
		}	

[-+=(){};%,]	{	return *yytext; }


[ \t\n] 	; /* skip whitespace */
. 	yyerror("invalid character");
%%
int yywrap(void) {
return 1;
}
