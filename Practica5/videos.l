/*----- Sección de Declaraciones --------------*/
%{
	#include <stdio.h>
	#include <iostream>
	#include <vector>
	int np;
	std::string nombreBlog;
	void generaVideo(char * nombre);
	void guardaNombre(char * nombre);

%}

https				https:\/\/
http				http:\/\/
protocolo			({http}|{https})
inicioDocumento		"<!DOCTYPE html>"
inicioPost			"START POSTS"
cualquierC			(.|\n)
nombreB 			"data-tumblelog-name"
tagv 				"https://www.youtube.com/watch?v="
inicioTag			"<a class=\"post_tag\" href=\""
permitidos			[a-zA-Z0-9]

/*----- Sección de Reglas ----------------*/
%START estadoNombre estadoFoto estadoVideo gVideo
%%
{inicioDocumento}{cualquierC}+{inicioPost}.{4}		{}
{nombreB}\=											{BEGIN estadoNombre;}
<estadoNombre>\"[^\"\=]+\"							{guardaNombre(yytext);BEGIN estadoVideo;}
<estadoVideo>{tagv}									{BEGIN gVideo;}
<gVideo>{permitidos}+									{generaVideo(yytext);BEGIN 0;}
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

std::cout << "<body bgcolor=\"#36465d\" ><head><title>Resumen Videos</title></head>";
std::cout << "<center><h1 style=\"color:white\">Resumen de videos del dia</h1></center>";
std::cout << "<div align=\"center\">";
	yylex ();
std::cout << "</div>";
std::cout << "<center><a href=index.html> <img src=https://secure.assets.tumblr.com/images/logo_page/img_logo_bluebg_2x.png \"></a></center>";
std::cout << "</body>";
	return 0;
}

void generaVideo(char * nombre){
	std::cout << "<b>"<< nombreBlog << "</b>"<<"<br/>";
	std::cout << "<iframe width=\"560\" height=\"315\"";
	std::cout << "src=\"https://www.youtube.com/embed/";
	std::cout << nombre;
	std::cout << "\" frameborder=\"0\" allowfullscreen></iframe>";

}

void guardaNombre(char * nombre){
	std::string str(nombre);
	nombreBlog=str;
}