from os import listdir, system, chdir, mkdir, getcwd
import sys
#path = sys.argv[1]
#print(path)
#exit()
#print(getcwd())
path = "/home/felipe/Escritorio/UC/Quinto Semestre/ALN/Tareas/"
chdir("./Tareas/")
n = len(listdir(getcwd())) + 1
n = str(n)
s = "T{}".format(n)
mkdir(s)
chdir("./T1/")
system("cp -r figures/ ../" + s)
chdir("../" + s)
tex = """\\documentclass{article}
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
\\def\\R{\mbox{\(\mathbb{R}\)}}
\\def\\E{\mbox{\(\mathbb{E}\)}}
\\def\\P{\mbox{\(\mathbb{P}\)}}
\\def\\I{\mbox{\(\mathbb{I}\)}}
\\def\\L{\\mbox{\\(\\mathbb{L}\\)}}
\\def\\dx{\\mbox{\\(\\,\\mathrm{d}x\\)}}
\\makeatletter
\\def\\BState{\\State\\hskip-\\ALG@thistlm}
\\makeatother
\\usepackage{geometry}
\\geometry{left=2.5cm, right=2.5cm, top=2cm, bottom=3cm}
\\title{Tarea <num>\\\\}
\\author{Luis Felipe Silva De Vidts}
\\begin{document}
\\begin{figure}
\\begin{minipage}{2.5cm}
\\includegraphics[width=0.8\\textwidth]{./figures/LogoUC-BN}
\\end{minipage}
\\begin{minipage}{14.5cm}
\\vspace{4mm}
{\\sc PONTIFICIA UNIVERSIDAD CAT\\'OLICA DE CHILE}\\\\
Departamento de Matemáticas y Programa de Ingeniería Matemática y Computacional \\
{\\bf <sigla> <nombre>}\\\\
\\vspace{0mm}
\\hrulefill
\\end{minipage}
\\end{figure}
\\phantom{""}
\\vspace{-5mm}
\\normalsize
\\begin{center}
\\Huge Tarea <num>\\\\
\\normalsize Luis Felipe Silva De Vidts
\\end{center}
\\end{document}
"""
nombre = input("nombre curso: ")
sigla = input("sigla ramo: ")
tex = tex.replace("<num>", n).replace("<nombre>", nombre).replace("<sigla>", sigla)
with open(s + ".tex", "w") as file:
    file.write(tex+"\n")

system("pdflatex " + s + ".tex")





