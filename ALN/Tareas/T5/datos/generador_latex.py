from os import listdir, system
class Metodo:
    def __init__(self, nombre, flag, relres, iter, tipo):
        self.nombre = nombre
        self.relres = relres
        self.iter = iter
        self.flag = flag
        self.tipo = tipo

    def __str__(self):
        return """\\begin{{table}}[H]

    \centering
    {nombre}
    \\begin{{tabular}}{{ | c | | c | | c | c | c | | c | c | c |}}
    \hline
    &  \multirow{{2}}{{*}}{{Sin Prec.}} &
    \multicolumn{{6}}{{ | c |}}{{Con Precondicionamiento}} \\\\ 
    \\cline{{3 - 8}}

    & &  \multicolumn{{3}}{{ | c | |}}{{Sin Prepordenamiento}} &

    \multicolumn{{3}}{{c |}}{{Con Prepordenamiento}} \\\\
     
    \\cline{{3 - 8}}

    & & $ilu standar$ & ilu nofill & ilu ilutp &

    $ilu standar$ & ilu nofill & ilu ilutp \\\\ \\hline \\hline

    Iter & {iter[3]} &{iter[0} &{iter[1]} &{iter[2]} & & & \\ \\
    $\ | b - A\widetilde{{x}}\ | $ &{relres[3]} &{relres[0]} &{relres[1]} &{relres[2} & & &  \\\\
    flag &{flag[3]} &{flag[0]} &{flag[1]} &{flag[2]} & & & \\\\
    CPU Orden & * & * & * & * & & &  \\\\
    CPU IFac & & & & & & & \\\\
    CPU Método & & & & & & & \\\\
    \hline
    \end{{tabular}} \\\\
    \caption{{Resultados para $A$ {tipo} con el método {nombre}}}

    \label{{tab: T1}}

    \end{{table}}""".format(nombre=self.nombre, tipo=self.tipo,
                            iter=self.iter, relres=self.relres,
                            flag=self.flag)
with open("tarea5_felipe_silva.tex", "w") as f:
    f.write("""\documentclass{article}
\\usepackage[utf8]{inputenc}
\\usepackage{amsmath, amsthm, amsfonts,amssymb}
\\usepackage[spanish]{babel}
\\usepackage{multicol}
\\usepackage{multirow}
\\usepackage{listings}
\\lstset{basicstyle=\\footnotesize\\ttfamily,breaklines=true}
\\usepackage{alltt}
\\usepackage{graphicx}
\\usepackage{subfigure}
\\usepackage{subfig}
\\usepackage{float}
\\usepackage{url}
\\usepackage{algorithmicx}
\\usepackage{algorithm}
\\usepackage[noend]{algpseudocode}
\\usepackage{enumerate}
\\usepackage{framed}
\\usepackage{color}
\\usepackage{cancel}
\\usepackage{wrapfig}\\definecolor{shadecolor}{RGB}{250,250,250}
\\usepackage{framed}
\\usepackage{epstopdf}
\\setlength\\parindent{0pt}
\\usepackage{listings}
\\usepackage{color} %red, green, blue, yellow, cyan, magenta, black, white
% Operadores matemáticos y simbolos
\\DeclareMathOperator{\\dive}{div}
\\DeclareMathOperator{\\trace}{trace}
\\DeclareMathOperator{\\tr}{tr}
\\DeclareMathOperator{\\symm}{symm}
\\DeclareMathOperator{\\sk}{skew}
\\DeclareMathOperator{\\grad}{grad}
\\DeclareMathOperator{\\Grad}{Grad}
\\DeclareMathOperator{\\curl}{curl}
\\DeclareMathOperator{\\Curl}{Curl}
\\def\R{\\mbox{\(\\mathbb{R}\\)}}
\\def\E{\\mbox{\(\\mathbb{E}\\)}}
\\def\P{\\mbox{\(\\mathbb{P}\\)}}
\\def\I{\\mbox{\(\\mathbb{I}\\)}}
\\def\L{\\mbox{\\(\\mathbb{L}\\)}}
\\def\dx{\\mbox{\\(\\,\\mathrm{d}x\\)}}
\\makeatletter
\\def\\BState{\\State\\hskip-\\ALG@thistlm}
\\makeatother
\\usepackage{geometry}
\\geometry{left=2.5cm, right=2.5cm, top=2cm, bottom=3cm}
\\title{Tarea 5\\\\}
\\author{Luis Felipe Silva De Vidts}
\\begin{document}
\\begin{figure}
\\begin{minipage}{2.5cm}
\\includegraphics[width=0.8\\textwidth]{./figures/LogoUC-BN}
\\end{minipage}
\\begin{minipage}{14.5cm}
\\vspace{4mm}
{\sc PONTIFICIA UNIVERSIDAD CAT\\'OLICA DE CHILE}\\\\
Departamento de Matemáticas y Programa de Ingeniería Matemática y Computacional \\
{\\bf IMT2111 Algebra Lineal Numérica}\\\\
\\vspace{0mm}
\\hrulefill
\\end{minipage}
\\end{figure}
\\phantom{""}
\\vspace{-5mm}
\\normalsize
\\begin{center}
\\Huge Tarea 5\\\\
\\normalsize Luis Felipe Silva De Vidts
\\end{center}
\\section*{Parte Práctica}
""")
metodos = {"CG.txt": ("Gradientes Conjugados","SPD"),
           "CR.txt": ("Residuales Conjugados","SPD"),
           "BCGSTAB.txt": ("Gradientes Biconjugados Estable","General"),
           "GMRES.txt": ("GMRES","General"),
           "SBCGSTAB.txt": ("Gradientes Biconjugados Estable", "Simetrico indef"),
           "SGMRES.txt": ("GMRES", "Simetrico indef")
           }
for elemento in listdir("./"):
    if ".txt" in elemento:
        with open(elemento, "r") as archivo:
            arch = archivo.readlines()
            for i in range(len(arch)):
                arch[i] = arch[i].strip().split(" ")
        method = Metodo(metodos[elemento][0],arch[0], arch[1],
                        arch[2],
                        metodos[elemento][1])
        with open("tarea5_felipe_silva.tex", "a") as f:
            f.write(str(method)+"\n")
with open("tarea5_felipe_silva.tex", "a") as f:
    f.write("""\\section*{Observaciones generales}
    Escogí para los casos SPD, Gradientes conjugados y residuales conjugados,
    ya que ambos algoritmos están diseñados para resolver sistemas SPD\\\\
    
    Para los casos simétricos use GMRES y BCGSTAB, porque son estables y 
    generales y principalmente porque no encontre implementados MINRES ni SYMMLQ\\\\
    
    Para los casos de matrices generales, elegí GMRES, ya que permite tener una 
    buena aproximación, sin tener que resolver un sistema tan grande como el 
    original y BCGSTAB porque es un método de proposito general que utiliza una
    forma algo distinta de generar el espacio de Krylov a usar Arnoldi, es 
    transpose free y más estable que BCG\\\\
    Por temas de tiempo no logre probar los casos con matrices de permutacion
    ni ha hacer el pdf completo, ya que tratando de generar y guardar graficos 
    se murio mi octave, por lo que no pude poner gráficos.\n""")
    f.write("\\end{document}\n")
system("pdflatex tarea5_felipe_silva.tex")
system("xdg-open tarea5_felipe_silva.tex")




