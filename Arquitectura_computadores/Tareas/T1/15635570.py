# Tarea 1 Arquitecura de Computadores
import os

def convertir_float(decimal, l_exp=8, l_sig=23):
    if float(decimal) < 0:
        signo = "1"
    else:
        signo = "0"
    punto = decimal.find(".")
    pe = float(decimal[0:punto])
    pd = float("0."+decimal[punto+1:])
    restos_enteros = []
    while pe != 0:
        restos_enteros.append(pe%2)
        pe = pe//2
    restos_enteros.reverse()
    for i in range(len(restos_enteros)):
        restos_enteros[i] = str(int(restos_enteros[i]))
    binario = "".join(restos_enteros)
    restos_decimales = []
    while pd != 0 and (len(restos_enteros) + len(restos_decimales)) <= l_sig:
        pd = pd*2
        s = str(pd)+"c"
        restos_decimales.append(s[0])
        s = s.strip("1")
        s = s.strip("c")
        s = "0" + s
        pd = float(s)
    for i in range(len(restos_decimales)):
        restos_decimales[i] = str(int(restos_decimales[i]))
    otro_binario = "".join(restos_decimales)
    significante = binario + otro_binario
    if binario != "0":
        largo_binario = len(binario) - 1
        signo_exp = True  # Signo es positivo
    else:
        largo_binario = len(significante) + 1
        signo_exp = False  # Signo es negativo
    exp = bin(largo_binario)+"c"
    exp = exp.strip("0")
    exp = exp.strip("b")
    exp = exp.strip("c")
    while len(exp) < l_exp:
        exp = "0" + exp
    if signo_exp:
        exp = "1" + exp
    else:
        exp = "0" + exp
    return signo + significante + exp

def mostrar(path):
    f = open(os.getcwd()+"\\15635570.txt", "w")
    f.close()
    with open(path, "r") as archivo:
        file = archivo.readlines()
        for i in range(len(file)):
            file[i] = file[i].split(" ")
            file[i][1] = file[i][1].split(",")
            file[i][1][0], file[i][1][1] = int(file[i][1][0]), int(file[i][1][1])
            aux = file[i].pop()
            for elem in aux:
                file[i].append(elem)
            arch = open(os.getcwd()+"\\15635570.txt", "a")
            arch.write(str(elem)+" " for elem in file)
            arch.write(str(convertir_float(*file[i]))+"\n")
            arch.close()

if __name__ == "__main__":
    while True:  # No entendi a que se referia con $ python {n° alumno}.py archivo.txt pero aqui solo basta
        # con poner el nombre de archivo que se quiere leer y se creara un archivo con mi numero de alumno
        # y los resultados
        path = input("¿Que archivo quiere leer?[recuerde poner la extension]: ")
        try:
            mostrar(path)
            break
        except OSError:
            print("Archivo no existe")
