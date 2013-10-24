#include <stddef.h>
#include <stdlib.h>
#include "frecuencias.h"

/**
 * Función interna para insertar o actualizar la frecuencia de un elemento
 * @param frecuencias
 * @param caracter
 */
void insertaFrecuencia(ListaFrecuencia * frecuencias, char caracter);

void generaFrecuencias(ListaFrecuencia * frecuencias, char caracteres[], int length) {
    // Comprobamos que la lista esté iniciada, si no lo está, la inicializamos
    if (frecuencias->inicio == NULL) {
        frecuencias->lenght = 0;
    }
    int ix;
    // Recorremos el arreglo de caracteres para insertarlos en la lista de frecuencia
    for (ix = 0; ix < length; ix++) {
        insertaFrecuencia(frecuencias, caracteres[ix]);
    }
}


/**
 * Función para insertar (o actualizar) en la lista de frecuencias
 * @param frecuencias La lista de frecuencias
 * @param caracter El caracter que queremos insertar o actualizar
 */
void insertaFrecuencia(ListaFrecuencia * frecuencias, char caracter) {
    // Buscamos si la frecuencia ya existe
    int x;
    NodoFrecuencia * f;
    //f = frecuencias->inicio;
    for(f = frecuencias->inicio;f != NULL; f = f->siguiente)
    {
		if (f->frecuencia.caracter == caracter) { 
            // En caso de que exista solo incrementamos sus ocurrencias
            f->frecuencia.apariciones++;
            // y salimos de la función
            return;
        }
		
	}
    
    // Insertamos el nodo en la lista
    f = (NodoFrecuencia *) malloc(sizeof (NodoFrecuencia));
    f->frecuencia.caracter = caracter;
    f->frecuencia.apariciones = 1;


    NodoFrecuencia * aux = frecuencias->inicio;
    f->siguiente = aux;
    frecuencias->inicio = f;
}

