
#include "stdlib.h"
#include "stdio.h"
#include <GL/gl.h>
#include <GL/glut.h>
#include <ctype.h>
#include "escena.h"

    // variables que determninan la posicion y tamaño de la ventana X
   int UI_window_pos_x=50,UI_window_pos_y=50,UI_window_width=500,UI_window_height=500;
//***************************************************************************
// Funcion de incializacion
//***************************************************************************
    Escena escena;
    void draw_scene(void){escena.draw_scene();}
    void change_window_size(int Ancho1,int Alto1){escena.change_window_size(Ancho1,Alto1);}
    void normal_keys(unsigned char Tecla1,int x,int y){escena.normal_keys(Tecla1,x,y);}
    void special_keys(int Tecla1,int x,int y){escena.special_keys(Tecla1,x,y);}
    void idle(void){escena.idle();}







//***************************************************************************
// Programa principal
//
// Se encarga de iniciar la ventana, asignar las funciones e comenzar el
// bucle de eventos
//***************************************************************************

int main(int argc, char **argv)
{
     // se llama a la inicialización de glut
    glutInit(&argc, argv);

    // se indica las caracteristicas que se desean para la visualización con OpenGL
    // Las posibilidades son:
    // GLUT_SIMPLE -> memoria de imagen simple
    // GLUT_DOUBLE -> memoria de imagen doble
    // GLUT_INDEX -> memoria de imagen con color indizado
    // GLUT_RGB -> memoria de imagen con componentes rojo, verde y azul para cada pixel
    // GLUT_RGBA -> memoria de imagen con componentes rojo, verde, azul y alfa para cada pixel
    // GLUT_DEPTH -> memoria de profundidad o z-bufer
    // GLUT_STENCIL -> memoria de estarcido
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);

    // posicion de la esquina inferior izquierdad de la ventana
    glutInitWindowPosition(escena.GetUI_window_pos_x(),escena.GetUI_window_pos_y());

    // tamaño de la ventana (ancho y alto)
    glutInitWindowSize(escena.GetUI_window_width(),escena.GetUI_window_height());

    // llamada para crear la ventana, indicando el titulo (no se visualiza hasta que se llama
    // al bucle de eventos)
    glutCreateWindow("Javier Castillo Palomo");

    // asignación de la funcion llamada "dibujar" al evento de dibujo
    glutDisplayFunc(draw_scene);
    // asignación de la funcion llamada "cambiar_tamanio_ventana" al evento correspondiente
    glutReshapeFunc(change_window_size);
    // asignación de la funcion llamada "tecla_normal" al evento correspondiente
    glutKeyboardFunc(normal_keys);
    // asignación de la funcion llamada "tecla_Especial" al evento correspondiente
    glutSpecialFunc(special_keys);
    glutIdleFunc( idle ) ;
    // funcion de inicialización
    escena.initialize();

    // inicio del bucle de eventos
    glutMainLoop();
    return 0;
}
