/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>

%}

numero		[0-9]
mes1		[1]
dia1		[0-2]
mes			({mes1}{dia1})|{numero}
dia			(3(0|1))|(2{numero})|(1{numero})|({numero})
idPais		(0034|\+34)
separador	[\-\-\.\:\|\\]
letras		[A-Z]
cp			CP
nif			K|L|M|X|Y|Z

/*----- Sección de Reglas ----------------*/
%%
{dia}{separador}{mes}{separador}{numero}{4}							{ printf ("Fecha Detectada: %s \n",yytext);}
({idPais}?)\b?{numero}{3}{separador}{numero}{6}						{ printf ("Numero de Telefono: %s\n",yytext);}
{numero}{4}{separador}{letras}{3}									{ printf ("Matricula: %s\n",yytext);}
{cp}{separador}{numero}{5}											{ printf ("%s\n",yytext);}
{nif}{numero}{8}													{ printf ("NIF: %s\n",yytext);}
.																	{}
\n 																	{}
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
