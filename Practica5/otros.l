/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>
	#include <iostream>
	#include <vector>
	int np=0;
	std::string nombreBlog;
	void muestraNombre(char * nombre);
	void guardaNombre(char * nombre);

%}

https				https:\/\/
http				http:\/\/
protocolo			({http}|{https})
inicioDocumento		"<!DOCTYPE html>"
inicioPost			"START POSTS"
cualquierC			(.|\n)
inicioP 			"post-source-footer"
nombreB 			"data-tumblelog-name"

/*----- Sección de Reglas ----------------*/
%START estadoNombre estadoTag muestraTag
%%
{inicioDocumento}{cualquierC}+{inicioPost}.{4}		{}
{nombreB}\=											{BEGIN estadoNombre;}
<estadoNombre>\"[^\"\=]+\"							{guardaNombre(yytext);BEGIN estadoTag;}
<estadoTag>{inicioP}								{BEGIN muestraTag;}
<muestraTag>#(\n*[A-Za-z_]+\n*)						{muestraNombre(yytext);BEGIN muestraTag;}
.|\n 												{}
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
std::cout << "<body bgcolor=\"#36465d\" ><head><title>Resumen Otros</title></head>";
std::cout << "<center><h1 style=\"color:white\">Resumen de Tag's del dia</h1></center>";
std::cout << "<div align=\"center\">";
	yylex ();
std::cout << "</div>";
std::cout << "<center><a href=index.html> <img src=https://secure.assets.tumblr.com/images/logo_page/img_logo_bluebg_2x.png \"></a></center>";
std::cout << "</body>";
	return 0;
}

void muestraNombre(char * nombre){
	if(np==0)
	std::cout << "<br/><b>"<< nombreBlog << "</b>"<<"<br/>";
	std::cout << nombre;
	std::cout << "<br/>";
	np++;
}

void guardaNombre(char * nombre){
	np=0;
	std::string str(nombre);
	nombreBlog=str;
}