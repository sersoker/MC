#!/bin/bash
g++ inicial.cpp -o practica
./practica >index.html

lex imagenes.l 
g++ lex.yy.c -o practica -ll
./practica Tumblr1.html > img.html

lex videos.l 
g++ lex.yy.c -o practica -ll
./practica Tumblr1.html > vid.html

lex otros.l 
g++ lex.yy.c -o practica -ll
./practica Tumblr1.html > otr.html

rm ./lex.yy.c
rm ./practica