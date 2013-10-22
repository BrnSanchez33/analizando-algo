##
# Problema de la selecci�n de actividades en programaci�n �vida
# Implementaci�n en IronPython por Antonio Feregrino Bola�os
# 21/Octubre/2013
##

# Definimos una clase que nos ayudar� a modelar las actividades
class Actividad:
    """Clase que modela una actividad"""
    nombre = ''
    horaInicio = -1
    horaFinal = -1

    def __init__(self, horaInicio, horaFinal, nombre):
        """Constructor de la clase"""
        self.horaFinal = horaFinal
        self.nombre = nombre
        self.horaInicio = horaInicio
    
    # Sobreescritura del m�todo __str__ para adecuarlo a nuestras necesidades
    def __str__(self):
        return 'Actividad ' + self.nombre

    def duracion(self):
        return self.horaFinal - self.horaInicio

def burbujaMejorada(array,n):
    """M�todo de ordenaci�n por burbuja mejorada"""
    for i in range(n):
        for j in range(i):
            # Aqu� es donde se puede modificar el criterio de ordenaci�n por el que deseemos
            if array[i].horaFinal < array[j].horaFinal:
                temp = array[j] 
                array[j] = array[i]
                array[i] = temp

def seleccionarActividades(lista,tamano):
    """Aplica el algoritmo de la selecci�n de actividades"""
    actividadesSeleccionadas = []
    z = 0
    actividadesSeleccionadas.append(lista[z])
    for i in range(tamano):
        if lista[i].horaInicio >= lista[z].horaFinal:
            actividadesSeleccionadas.append(lista[i])
            z = i        
    return actividadesSeleccionadas
        
# Solicitamos el n�mero de actividades
numeroActividades = int(input('Numero de actividades: '))
# Creamos una lista para almacenar cada una de ellas
actividades = []
for i in range(numeroActividades):
    # Leemos la informaci�n de cada actividad
    horaInicio = int(input('Inicio de la actividad ' + str(i + 1) + ": "))
    horaFinal = int(input('Fin de la actividad ' + str(i + 1) + ": "))
    act = Actividad(horaInicio,horaFinal, 'Actividad ' + str(i + 1))
    actividades.append(act)

# Ordenamos la lista de actividades, dejando al inicio la que queremos realizar primero
burbujaMejorada(actividades,numeroActividades)

# Lanzamos el algoritmo de la selecci�n de actividades
seleccionadas = seleccionarActividades(actividades,numeroActividades)

# Imprimimos el resultado del algoritmo
for x in seleccionadas:
    print(x)
