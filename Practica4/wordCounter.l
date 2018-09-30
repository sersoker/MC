/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>

	int nc, np, nl;
	void escribir_datos (int dato1, int dato2, int dato3);
%}


/*----- Sección de Reglas ----------------*/
%%
[^ \t\n]+	{ np++; nc+=yyleng;} /*Busca una palabra que no tenga tabulador o salto de Aumenta el contador de palabras y el de caracteres en la longitud de la palabra*/
[ \t]+		{ nc += yyleng; }	/*Cualquier sucesion de espacios en blanco y no cuenta palabras pero si los caracteres*/
\n		{ nl++; nc++; }		/*Salto de linea, aumenta el contador de lineas y el de caracteres*/

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
	nc = np = nl = 0;
	yylex ();
	escribir_datos(nc,np,nl);
	return 0;
	}
void escribir_datos (int dato1, int dato2, int dato3) {
  printf ("Num_caracteres=%d\tNum_palabras=%d\tNum_líneas=%d\n", dato1,dato2,dato3);
}
