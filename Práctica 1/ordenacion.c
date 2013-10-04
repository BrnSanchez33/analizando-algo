#include "ordenacion.h"
#include "arbol.h"

/*
 * Funci�n del algoritmo de inserci�n
 * Recibe:
 *	array, el arreglo a ordenar
 *  n, el tama�o del arreglo
 * */
void Insercion(int * array, int n)
{
	// Inicializamos una variable
	// auxiliar para recorrer el arreglo
	int ix = 1;
	for(;ix < n; ++ix) // Recorremos el arreglo
	{
		// Asignamos el valor actual a
		// una variable temporal
		int temp = array[ix];
		// Nos ubicamos en la posici�n anterior a 
		// la actual para ir revisando los valores
		int j = ix - 1;
		while((array[j] > temp) && (j >= 0))
		{
			// Nos vamos moviendo hacia atr�s
			// hasta que encontremos la nueva
			// ubicaci�n de nuestro valor
			array[j + 1] = array[j];
			j--;
		}
		// Lo asignamos
		array[j + 1] = temp;
	}
}

/*
 * Funci�n del algoritmo de inserci�n
 * Recibe:
 *	array, el arreglo a ordenar
 *  n, el tama�o del arreglo
 * */
void Arbol(int * array, int n)
{
	// Variable que nos ayudar� a recorrer
	// el arreglo en su totalidad
	int ix = 0;
	// Variable para "almacenar" el �rbol
	arbol t;
	// Creamos nuestro �rbol
	Iniciar(&t);
	for(;ix < n; ++ix)
	{
		// Para cada elemento en nuestro arreglo
		// creaamos un nodo en el �rbol
		NuevoNodo(&t,array[ix]);
	}
	// Reemplazamos los valores iniciales de
	// nuestro arreglo por los le�dos
	// inorden del �rbol
	RellenaInorden(&t, array);
}

/*
*Función para el algoritmo de ordenamiento de Burbuja Simple
*
*/
void Burbuja(int * array, int n) /*Aquí se colocan los argumentos que recibira nuestra función, en este caso el arreglo de números en desorde y el tamaño de problema n*/
{
	int temp=0,i,j; /*Inicializamos las variables que utilizaremos, los contadores i y j, además de temp la que nos ayuda a almacenar el contenido de una posición del arreglo*/
	for(i=1;i<n;i++) /*Aqui tenemos los bucles que recorren el arreglo en su totalidad*/
  {
                  for(j=0;j<n-1;j++)
                  {
                     if(array[j]>array[j+1])/*Esta decisión nos ayuda a saber si el contenido de la posición actual es mayor que la siguiente y si es así intercambiarlas*/
                       {
                                                temp=array[j];
                                                array[j]=array[j+1];/*En esta parte se realiza la asignación y el cambio de posición del contenido del arreglo*/
                                                array[j+1]=temp;
                       }
                  }
  } 

}

/*Función para el algoritmo de ordenamiento Selección*/
void Seleccion(int * array, int n)/*Aquí se colocan los argumentos que recibira nuestra función, en este caso el arreglo de números en desorde y el tamaño de problema n*/
{
	int i,g,temp=0,p=0; /*Inicializamos las variables que utilizaremos, los contadores i,g y p otro contador auxiliar, además de temp la que nos ayuda a almacenar el contenido de una posición del arreglo*/
	for(g=0;g<n-1;g++)
		p=g;
	for(i=g+1;i<n-1;i++)/*Aqui tenemos los bucles que recorren el arreglo en su totalidad*/
	{
		if(array[i]<array[p])/*En esta parte comparamos el contenido de la posición del arreglo donde encontramos el menor con las siguientes posiciones y así sucesivamente hasta encontrar el menor de todo el arreglo y colocarlo al inicio*/
			p=i;
		if(p!=g)
		{
			temp=array[p];
			array[p]=array[g];/*De igual manera aquí intercambiamos las posiciones de acuerdo a como vamos 		encontrando al menor del arreglo*/
			array[g]=temp;
		}
	}

}

/*Funci�n para el ordenamiento de burbuja mejorada*/
void BurbujaMejorada(int * array,int n){  /*La funci�n recibe el arreglo de n�meros a ordenar asi como el tama�o del problema(cantidad de numeros a ordenar)*/
   	int i;               /*Indice que nos permitira hacer un recorrido al arreglo de n�meros*/
	int j;               /*Indice que nos permitira hacer un recorrido al arreglo de n�meros */
	int temp;            /*Permite el almacenamiento temporal de un n�mero del arreglo el cual auxiliar� el cambio de posici�n de un n�mero a ordenar*/

	for(i=0;i<n;i++){                /*Se realiza un recorrido general del  arreglo num�rico*/
		for(j=0;j<i;j++){            /*Se realiza un recorrido general del  arreglo num�rico */   
			if(array[i]<array[j]){   /*Compara si el elemento en posici�n i es menor al elemeto en posici�n actual(indice j)*/
				temp = array[j];     /*En caso que el elemento mayor se encuentre en la posici�n j, el numero contendo se asigna a la variable temporal*/
				array[j] = array[i];  /*Se realiza el cambio de psici�n de los n�meros comparados auxili�ndose de la variable temp*/
				array[i] = temp;     
			}
		}
	}
	

}
/*Funci�n de ordenamiento Shell*/
void Shell(int * array, int n){ /*La funci�n recibe el arreglo de n�meros a ordenar asi como el tama�o del problema(cantidad de numeros a ordenar)*/
	int k; /*Almacena el tama�o de subarreglos,el cual siempre es menor al tama�o del problema n*/
	int i; /*Indice que nos permite realizar el recorrido de los sub-arreglos a partir de la posici�n k*/
	int j;  /*Indice que permite realizar el recorrido del subarreglo desde la posici�n 0 hasta la posici�n k*/
	int v;  /*Variable temporal que nos permite almacenar un n�mero del arreglo a comparar*/
	
	k=n/2;  /*Divide en 2 el tama�o del problema*/
	while(k>=1){    /*Bucle que se realiza hasta que cada subarreglo no pueda dividirse mas */
		for(i=k;i<n;i++){  /*Ciclo que permite realizar el recorrido del arreglo a partir de la posici�n k*/
			v = array[i];  /* Se almacena el numero en la posici�n i del arreglo*/
			j = i - k;     
			while(j>=0 && array[j]>v){ /*Ciclo que permite comparar  un numero en posici�n j respecto a la variable temporal v*/
				array[j + k] = array[j]; /*En caso que el numero en posici�n j sea mayor se realiza una copia del n�mero a la psici�n j+k del arreglo original*/
				j=j-k;
			}
			array[j + k] = v;  /*Se realiza la asignaci�n del n�mero almacenado en v a su nueva posici�n j+k en el arreglo*/
		}
		k=k/2;	/*Vuelve a efectuarse una subdivision del arreglo*/
	}

}

