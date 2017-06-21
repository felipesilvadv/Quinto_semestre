import os

string = """\\begin{{figure}}[h!]
\\centering
\\begin{{tabular}}{{c|c|c|c|c}}
$\\lambda_{{i}}$&$\\tilde{{\\lambda_{{i}}}}$ &$|\\lambda_{{i}}-\\tilde{{\\lambda_{{i}}}}|$ &Cond(V) &$c_i$\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
{}&{}&{}&{}&{}\\\\
\\hline
\\caption{{{archivo}}}
\\end{{tabular}}
\\end{{figure}}"""
with open("/home/felipe/Escritorio/UC/Quinto_semestre/ALN/Tareas/T6/para_latex.txt", "w") as file:
    file.close()
    
for archivo in os.listdir("/home/felipe/Escritorio/UC/Quinto_semestre/ALN/Tareas/T6/datos/"):
    with open("/home/felipe/Escritorio/UC/Quinto_semestre/ALN/Tareas/T6/datos/"+archivo) as file:
        valor = file.readlines()
        for i in range(len(valor)):
            valor[i] = valor[i].strip()
            valor[i] = valor[i].split(",")
            print(valor[i])
            if valor[i].count(",")!=4:
                print(archivo)
    print(len(valor[0]))
    print(len(valor))
    with open("/home/felipe/Escritorio/UC/Quinto_semestre/ALN/Tareas/T6/para_latex.txt", "a") as file:
        file.write(string.format(*[valor[i][j] for i in range(12) for j in range(5)], archivo=archivo)+"\n")
