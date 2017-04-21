import numpy as np

# Pregunta 14
# buscamos e tal que 1 + e, 3 + 2e esten en la maquina pero no 3 + 2e + e^{2}
e = 1.0
i = 0
while 1.0 + e != 1.0:
    e = e / 2.0
    i += 1
e = e * 2.0
aux = e
print(e)
print(i)
i = 1.0
while 3.0 == 3.0 + 2.0*aux:
    aux = aux * i
    i += 1
print(i)
e = aux
print("Este es el valor de  e: {}".format(1 + e))
print("El valor de 3 + 2e es: {}".format(3.0 + 2.0*e))
print("El valor de 3 + 2e + e^2 es: {}".format(3.0 + 2*e + e**2))
print("Notamos que son iguales los dos ultimos valores, por lo que e^2 es menor que el número de máquina")
# con esto obtenemos el valor de e
v1 = np.array([1 + e, 1, 1])
v2 = np.array([1, 1 + e, 1])
v3 = np.array([1, 1, 1 + e])
Matriz = np.array([v1, v2, v3])
print(Matriz[2][1])
print(e)


def sacar_columna(matriz, i):
    col = np.zeros(len(matriz))
    for j in range(len(matriz)):
        col[j] = matriz[j][i]
    return col


def gram_schmidt(A):
    Q = np.zeros([len(A), len(A)])
    R = np.zeros([len(A), len(A)])
    for j in range(len(A)):
        Q[j] = A[j]
        for i in range(j-1):
            R[j][i] = np.dot(sacar_columna(A, i), Q[i])


gram_schmidt(Matriz)

A = np.eye(3)
np.linalg.qr(A)