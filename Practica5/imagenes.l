/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>
	#include <iostream>
	#include <vector>
	int np;
	std::string nombreBlog;
	void muestraImagen(char * nombre);
	void guardaNombre(char * nombre);

%}

https				https:\/\/
http				http:\/\/
protocolo			({http}|{https})
inicioDocumento		"<!DOCTYPE html>"
inicioPost			"START POSTS"
cualquierC			(.|\n)
inicioP 			"post_container"
nombreB 			"data-tumblelog-name"
foto				"data-big-photo"
otros				[.\n\;]
caracter			[a-zA-Z0-9_\-\.~\/]
www					www\.

/*----- Sección de Reglas ----------------*/
%START estadoNombre estadoFoto estadoMuestraFoto 
%%
{inicioDocumento}{cualquierC}+{inicioPost}.{4}		{}
{nombreB}\=											{BEGIN estadoNombre;}
<estadoNombre>\"[^\"\=]+\"							{guardaNombre(yytext);BEGIN estadoFoto;}
<estadoFoto>{foto}\=								{BEGIN estadoMuestraFoto;}
<estadoMuestraFoto>\"[^\"\=]+\"						{muestraImagen(yytext);BEGIN 0;}
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

std::cout << "<body bgcolor=\"#36465d\" ><head><title>Resumen Imagenes</title></head>";
std::cout << "<center><h1 style=\"color:white;display:inline-block;\">Resumen de Fotos del dia</h1></center>";
std::cout << "<div align=\"center\">";
	yylex ();
std::cout << "</div>";
std::cout << "<center><a href=index.html> <img src=https://secure.assets.tumblr.com/images/logo_page/img_logo_bluebg_2x.png \"></a></center>";
std::cout << "</body>";
	return 0;
}

void muestraImagen(char * nombre){
	std::cout << "<b>"<< nombreBlog << "</b>"<<"<br/>";
	std::cout << "<a href=" << nombre << ">"<< " <img src="<< nombre<< " height=\"250\" width=\"250\"> "" </a>";
	std::cout << "<br/>";
}

void guardaNombre(char * nombre){
	std::string str(nombre);
	nombreBlog=str;
}