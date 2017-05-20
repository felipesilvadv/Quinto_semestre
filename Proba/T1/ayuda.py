lista = ["Latitud", "Longitud", "Magnitud", "Profundidad", "Radiacion",
         "Presion", "Humedad", "Temperatura","Velocidad"]
with open("texto.txt", "w") as f:
    for elemento in lista:
        f.write("""\\begin{figure}[h!]
\\centering
\\includegraphics[scale=0.5]{./figures/histplot_"""+elemento+""".png}
\\caption{Histograma y Boxplot de """+elemento+"""}
\\end{figure}

\\begin{figure}[h!]
\\centering
\\includegraphics[scale=0.5]{./figures/cm_"""+elemento+""".png}
\\caption{Comparación con modelos de """+elemento+"""}
\\end{figure}

""")

