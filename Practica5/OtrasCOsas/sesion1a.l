/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>

%}

caracter		[a-zA-Z0-9_\-\.~\/]
https			https:\/\/
http			http:\/\/
protocolo		({http}|{https})
www				www\.

/*----- Sección de Reglas ----------------*/
%%
{caracter}+@{caracter}+\.{caracter}{2,3}$		{ printf ("Correo detectado: %s\n",yytext);}
{protocolo}{www}?{caracter}+					{ printf ("Pagina Web Detectada: %s\n",yytext);}
[a-zA-Z0-9_\-\.~:\b\t]{1,}						{}
.												{}
\n 												{}
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

void addName(String nombre){

}