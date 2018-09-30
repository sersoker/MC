/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>

%}

cLinea		"//"

/*----- Sección de Reglas ----------------*/
%%

{cLinea}.{1,}							{printf ("Comentario En Linea: %s \n",yytext);}
"/*"[^"*/"]*"*/"		{printf ("Comentario En Bloque: %s \n",yytext);}
.										{}
\n 										{}
%%

/*----- Sección de Procedimientos --------*/
int main (int argc, char *argv[]) {
	if (argc == 2) {
		yyin = fopen (argv[1], "rt");
		if (yyin == NULL) {
			printf ("El fichero %s no se puede abrir\n", argv[1]);
			exit (-1);
		}
	}
	else 
		yyin = stdin;

	yylex ();
	return 0;
}
