# Script Tarea 1
import numpy as np
from math import factorial
from matplotlib import pyplot as plt
import os
# Pregunta 3
print("Pregunta 3")
print(1**np.inf)
print(2**np.inf)
print(np.e ** np.inf)
print(np.e ** -np.inf)
# print(np.sign(np.nan))
# print(np.sign(-np.nan))
print(np.nan**0)
print(np.inf**0)
print(1**np.nan)
print(np.log(np.inf))
print(np.log(-np.inf))
# print(np.log(0))
print("--------")
# Pregunta 6
print("Pregunta 6")
def euler(x):
    return 1 + x + (x**2)/2 + (x**3)/6 + (x**4)/24
v = 2.0
w = np.e**v
print(euler(v))
print(np.e**0.1-1.105)
print((np.e**0.1 - 1.105)/np.e**0.1)
print(w-euler(v))
print((w-euler(v))/w)
def nuevo_e(k, negativo=True):
    def calcular_elemento(x, negativo=negativo):
        if negativo:
            return (-1)**x * (5**x)/factorial(x)
        else:
            return (5**x)/factorial(x)
    v = np.zeros(k+1)
    for i in range(k+1):
        v[i] = calcular_elemento(i)
    if negativo:
        return sum(v)
    else:
        return 1/sum(v)

print(nuevo_e(9))
print(nuevo_e(9, negativo=False))
print("e", np.e**-5)

print("-------")

# Pregunta 9
print("Pregunta 9")


def funcion(x):
    return np.sqrt(1 + x) - 1
y = 0.000000001
print(funcion(y))
print(y/2)
print("-----")
# Pregunta 10
def f(x):
    if x == 0:
        return 1
    else:
        return (np.e**x - 1)/x

def fun(x):
    y = np.e**x
    if y == 1:
        return 1
    else:
        return (y - 1)/np.log(y)

x = 0.000000000001
print("Pregunta 10")
print(f(x))
print(fun(x))
largo = 1000
otro_x = np.linspace(-10**-5, 10**-5, largo)
y = np.zeros(largo)
z = np.zeros(largo)
for i in range(len(y)):
    y[i] = fun(otro_x[i])
    z[i] = f(otro_x[i])
plt.plot(otro_x, y)
plt.plot(otro_x, z)
plt.show()

print("--------")


def fact(n):
    return np.sqrt(2 * np.pi * n) * (n/np.e)**n
x = np.arange(0, 13, 1)
y = np.zeros(13)
z = np.zeros(13)
for i in range(13):
    y[i] = factorial(i) - fact(i)
    z[i] = y[i]/factorial(i)
plt.plot(x, y, "rs")
plt.title("Error Absoluto")
plt.xlabel("n")
plt.ylabel("Error")
plt.savefig(os.getcwd() + "\\Error_absoluto.png")
plt.close()
plt.plot(x, z, "go")
plt.title("Error Relativo")
plt.xlabel("n")
plt.ylabel("Error")
plt.savefig(os.getcwd() + "\\Error_relativo.png")
plt.close()


def funcion_2(x):
    d = x + 1
    if d == 1:
        return 1
    else:
        return np.log(d)/(d - 1)


def funcion_1(x):
    return np.log(x + 1)/x


def comparar_funciones(f1, f2, num, inicio=-1, fin=1, guardar=False, nombre="", funcion1="", funcion2=""):
    # num es el número de puntos con los que se forma el gráfico, inicio y fin son los bordes de evaluación de
    # las funciones. nombre es para ponerle un titulo al gráfico
    # Si se quiere ver la foto no se guardara automaticamente
    # funcion1 y funcion2 es para que se sepan que funciones se estan comparando y los agregue como label
    x = np.linspace(inicio, fin, num)
    y = np.zeros(num)
    z = np.zeros(num)
    for i in range(len(y)):
        y[i] = f1(x[i])
        z[i] = f2(x[i])
    plt.plot(x, y, label="función {}".format(funcion1))
    plt.plot(x, z, label="función {}".format(funcion2))
    plt.title("Comparación de funciones {0} y {1}".format(funcion1, funcion2))
    plt.legend()
    if guardar:
        plt.savefig(os.getcwd()+"\\{}.png".format(nombre))
        plt.close()
    else:
        plt.show()
comparar_funciones(funcion_1, funcion_2, num=1000, inicio=-10**-15, fin=10**-15, guardar=True,
                   nombre="Comparacion_funciones", funcion1="log(x+1)/x", funcion2="log(d)/(d-1)")
comparar_funciones(funcion_1, funcion_2, num=2000, inicio=-1, fin=1, guardar=True,
                   nombre="Comparacion_funciones_2", funcion1="log(x+1)/x", funcion2="log(d)/(d-1)")