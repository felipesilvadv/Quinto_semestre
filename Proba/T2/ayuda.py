lista = ["año", "bcu", "desempeño", "imacec", "mes", "pib", "tasa", "tiempo"]
with open("texto.txt", "w") as f:
    for elemento in lista:
        f.write("""\\begin{figure}[h!]
\\centering
\\includegraphics[scale=0.5]{./figures/histplot_"""+elemento+""".jpg}
\\caption{Histograma y Boxplot de """+elemento+"""}
\\end{figure}

\\begin{figure}[h!]
\\centering
\\includegraphics[scale=0.5]{./figures/cm_"""+elemento+""".jpg}
\\caption{Comparación con modelos de """+elemento+"""}
\\end{figure}

""")

