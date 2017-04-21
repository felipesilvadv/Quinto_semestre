# Tarea 2 IIC2343
import os
a = 0
b = 0
RAM = [None for i in range(255)]
cmp = None

def tarea(path):
    with open(path, "r") as f:
        archivo = list(map(lambda x: x.strip(), f))
    labels = []
    i = 0
    while i < len(archivo):
        global a
        global b
        global RAM
        global cmp
        if ":" in archivo[i]:
            label, pos = archivo[i][0:archivo[i].find(":")], i
            labels.append([label, pos])
            archivo[i] = archivo[i][archivo[i].find(":") + 1:].strip()
        else:
            label = None
            pos = None
        if "MOV" in archivo[i]:
            archivo[i] = archivo[i].strip("MOV ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                try:
                    a = int(instruccion[1])
                except ValueError:
                    a = b
            elif instruccion[0] == "B":
                try:
                    b = int(instruccion[1])
                except ValueError:
                    b = a
            else:
                instruccion[0] = instruccion[0].strip("(").strip(")")
                if instruccion[0] == "A":
                    instruccion[0] = a
                else:
                    instruccion[0] = b
                try:
                    RAM[instruccion[0]] = int(instruccion[1])
                except ValueError:
                    if instruccion[1] == "A":
                        RAM[instruccion[0]] = a
                    else:
                        RAM[instruccion[0]] = b

        elif "ADD" in archivo[i]:
            archivo[i] = archivo[i].strip("ADD ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "B":
                    a = a + b
                elif "(" in instruccion[1]:
                    instruccion[1] = instruccion[1].strip("(").strip(")")
                    try:
                        a = a + RAM[int(instruccion[1])]
                    except TypeError:
                        a = a + RAM[b]
                else:
                    a = a + int(instruccion[1])
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = b + a
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a + b
        elif "SUB" in archivo[i]:
            archivo[i] = archivo[i].strip("SUB ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "B":
                    a = a - b
                elif "(" in instruccion[1]:
                    instruccion[1] = instruccion[1].strip("(").strip(")")
                    try:
                        a = a - RAM[int(instruccion[1])]
                    except TypeError:
                        a = a - RAM[b]
                else:
                    a = a + int(instruccion[1])
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = a - b
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a - b
        elif "AND" in archivo[i]:
            archivo[i] = archivo[i].strip("AND ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "B":
                    a = a & b
                elif "(" in instruccion[1]:
                    instruccion[1] = instruccion[1].strip("(").strip(")")
                    try:
                        a = a & RAM[int(instruccion[1])]
                    except TypeError:
                        a = a & RAM[b]
                else:
                    a = a & int(instruccion[1])
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = b & a
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a & b
        elif "OR" in archivo[i]:
            archivo[i] = archivo[i].strip("OR ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "B":
                    a = a | b
                elif "(" in instruccion[1]:
                    instruccion[1] = instruccion[1].strip("(").strip(")")
                    try:
                        a = a | RAM[int(instruccion[1])]
                    except TypeError:
                        a = a | RAM[b]
                else:
                    a = a | int(instruccion[1])
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = b | a
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a | b
        elif "NOT" in archivo[i]:
            archivo[i] = archivo[i].strip("NOT ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "A":
                    a = ~a
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = ~a
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = ~a
        elif "XOR" in archivo[i]:
            archivo[i] = archivo[i].strip("XOR ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "B":
                    a = a ^ b
                elif "(" in instruccion[1]:
                    instruccion[1] = instruccion[1].strip("(").strip(")")
                    try:
                        a = a ^ RAM[int(instruccion[1])]
                    except TypeError:
                        a = a ^ RAM[b]
                else:
                    a = a ^ int(instruccion[1])
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = b ^ a
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a ^ b
        elif "SHL" in archivo[i]:
            archivo[i] = archivo[i].strip("SHL ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "A":
                    a = a << 1
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = a << 1
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a << 1
        elif "SHR" in archivo[i]:
            archivo[i] = archivo[i].strip("SHR ")
            instruccion = archivo[i].split(",")
            if instruccion[0] == "A":
                if instruccion[1] == "A":
                    a = a >> 1
            elif instruccion[0] == "B":
                if instruccion[1] == "A":
                    b = a >> 1
            else:
                instruccion[1] = instruccion[1].strip("(").strip(")")
                RAM[int(instruccion[1])] = a >> 1
        elif "INC" in archivo[i]:
            b += 1
        elif "CMP" in archivo[i]:
            archivo[i] = archivo[i].strip("CMP ")
            instruccion = archivo[i].split(",")
            if instruccion[1] == "B":
                cmp = a - b
            else:
                cmp = a - int(instruccion[1])
        elif "JMP" in archivo[i]:
            label = archivo[i].strip("JMP ")
            for elemento, pos in labels:
                if label == elemento:
                    i = pos
        elif "JEQ" in archivo[i]:
            if cmp == 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        elif "JNE" in archivo[i]:
            if cmp != 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        elif "JGT" in archivo[i]:
            if cmp > 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        elif "JLT" in archivo[i]:
            if cmp < 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        elif "JGE" in archivo[i]:
            if cmp >= 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        elif "JLE" in archivo[i]:
            if cmp <= 0:
                label = archivo[i].strip("JMP ")
                for elemento, pos in labels:
                    if label == elemento:
                        i = pos
        i += 1
    with open("resultados_15635570.txt", "w") as f:
        f.write("A = {}\n".format(a))
        f.write("B = {}\n".format(b))
        RAM_final = [str(elemento) for elemento in RAM]
        # f.write("Memoria de direcciones = {}".format(str(RAM)))#si quiere ver la memoria de direcciones quitar ese "#"

if __name__ == "__main__":
    while True:
        valor = input()
        try:
            tarea(valor)
            break
        except OSError:
            print("Nombre de archivo inválido")