base = read.table("TAREA2.txt", dec=",", header=TRUE)
#base2 = read.table("TAREA2.txt", dec = ",", header = FALSE)
#variables = base2[1,]
setwd("/home/felipe/Escritorio/UC/Quinto_semestre/Proba/T2/")
head(base)
desempleo = base$DESEMPLEO
pib = base$PIB
año = base$AÑO
mes = base$MES
tiempo = base$TIEMPO
tasa = base$TASA_HIP
imacec = base$IMACEC
bcu = base$BCU1
ba.normal = function(Y, breaks = NULL){
  ## Requiere cargar libreria MASS
  aux1 = as.vector(fitdistr(Y, "normal")$estimate)
  aux2 = hist(Y, plot = F)
  if(is.null(breaks) == 0){
    aux2 = hist(Y, plot = F, breaks = breaks)
  }
  O = aux2$count
  k = length(O)
  q = c(-Inf, aux2$breaks[2:k], Inf)
  p = diff(pnorm(q, mean = aux1[1], sd = aux1[2]))
  n = length(Y)
  E = n * p
  X.1 = sum((O-E)^2/E)
  valor.p = 1 - pchisq(X.1, df = k - 1 - 2)
  list("Estadistico" = X.1, "valor.p" = valor.p)
}

Skewness=function(x){
  n=length(x)
  sum((x-mean(x))^3/n)/sd(x)^(3)
}
Kurtosis=function(x){
  n=length(x)
  sum((x-mean(x))^4/n)/sd(x)^(4)-3
}
recta=function(x,modelo="normal"){
  y=sort(x)
  N=length(y)
  p=(1:N)/(N+1)
  if (modelo=="exp"){
    x1=-log(1-p)
    plot(y~x1,main = "Comparaci?n con Exponencial")
    linea=lm(y~x1)$coef
    abline(linea,col="red",lwd=2)
    alpha=linea[1]
    lambda=1/linea[2]
    a=c(alpha,lambda)
    a
  }
  else{
    if(modelo=="normal"){
      x1=qnorm(p)
      plot(y~x1,main = "Comparaci?n con Normal")
      linea=lm(y~x1)$coef
      abline(linea,col="red",lwd=2)
      mu=linea[1]
      sigma=linea[2]
      a=c(mu,sigma)
      a
    }
    else{
      if(modelo=="log-normal"){
        x1=qnorm(p)
        plot(log(y)~x1,main = "Comparaci?n con Log-Normal")
        linea=lm(log(y)~x1)$coef
        abline(linea,col="red",lwd=2)
        lambda=linea[1]
        zeta=linea[2]
        a=c(lambda,zeta)
        a
      }
      else{
        if(modelo=="logistica"){
          x1=log(1/(1-p))
          plot(y~x1,main = "Comparaci?n con Log?stica")
          linea=lm(y~x1)$coef
          abline(linea,col="red",lwd=2)
        }
        else{
          if(modelo=="log-logistica"){
            x1=log(1/(1-p))
            plot(log(y)~x1,main = "Comparaci?n con log-Log?stica")
            linea=lm(log(y)~x1)$coef
            abline(linea,col="red",lwd=2)
            mu=linea[1]
            sigma=linea[2]
            a=c(mu,sigma)
            a
          }
          else{
            if(modelo=="weibull"){
              x1=log(-log(1-p))
              plot(y~x1,main = "Comparaci?n con Weibull")
              linea=lm(y~x1)$coef
              abline(linea,col="red",lwd=2)
              nu=exp(linea[1])
              beta=1/linea[2]
              a=c(nu,beta)
              a
            }
          }
        }
      }
    }
  }
  
}
histplot=function(x,outline = TRUE){
  par(mfrow=c(2,1))
  hist(x,freq = FALSE)
  lines(density(x),col="red",lwd=2)
  boxplot(x,outline = outline,horizontal = TRUE,col = "grey")
}
descriptiva=function(x){
  a1=min(x)
  a2=quantile(x,0.25)
  a3=median(x)
  a4=mean(x)
  a5=quantile(x,0.75)
  a6=max(x)
  b=sd(x)
  c=Skewness(x)
  d=Kurtosis(x)
  Tabla=cbind(a1,a2,a3,a4,a5,a6,b,c,d)
  colnames(Tabla)=c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","SD","Skewness","Kurtosis")
  rownames(Tabla)=c("")
  Tabla
}
ajustar_modelo=function(x){
  par(mfrow=c(2,3))
  param_exp=recta(x,"exp")
  param_norm=recta(x,"normal")
  param_lognorm=recta(x,"log-normal")
  param_logist=recta(x,"logistica")
  param_loglogist=recta(x,"log-logistica")
  param_weibull=recta(x,"weibull")
  a=cbind(param_exp,param_norm,param_lognorm,param_logist,param_loglogist,param_weibull)
  colnames(a)=c("exp","normal","log-normal","logist","log-logist","weibull")
  a
}
base_respaldo = base
vector = c()
nombres = c("año", "mes", "tiempo", "tasa", "desempleo", "imacec", "bcu", "pib")
n = length(nombres)
tablas = c()
#for (i in 1:n){
 # jpeg(paste("./plots/histplot_",nombres[i], ".jpg", sep = ""))
#  histplot(base[i])
#  dev.off()
#  tablas[i] = ajustar_modelo(base[i])
#  vector[i] = descriptiva(base[i])
#}

año=base$AÑO
jpeg(paste("./plots/histplot_",nombres[1], ".jpg", sep = ""))
histplot(año)
dev.off()
Tabla_año=ajustar_modelo(año)
f1=descriptiva(año)

mes=base$MES
jpeg(paste("./plots/histplot_",nombres[2], ".jpg", sep = ""))
histplot(mes)
dev.off()
Tabla_mes=ajustar_modelo(mes)
f2=descriptiva(mes)

tiempo=base$TIEMPO
jpeg(paste("./plots/histplot_",nombres[3], ".jpg", sep = ""))
histplot(tiempo)
dev.off()
Tabla_tiempo=ajustar_modelo(tiempo)
f3=descriptiva(tiempo)

tasa=base$TASA_HIP
jpeg(paste("./plots/histplot_",nombres[4], ".jpg", sep = ""))
histplot(tasa)
dev.off()
Tabla_tasa=ajustar_modelo(tasa)
f4=descriptiva(tasa)

desempleo=base$DESEMPLEO
jpeg(paste("./plots/histplot_",nombres[5], ".jpg", sep = ""))
histplot(desempleo)
dev.off()
Tabla_desempleo=ajustar_modelo(desempleo)
f5=descriptiva(desempleo)

imacec=base$IMACEC
jpeg(paste("./plots/histplot_",nombres[6], ".jpg", sep = ""))
histplot(imacec)
dev.off()
Tabla_imacec=ajustar_modelo(imacec)
f6=descriptiva(imacec)

bcu=base$BCU10
jpeg(paste("./plots/histplot_",nombres[7], ".jpg", sep = ""))
histplot(bcu)
dev.off()
Tabla_bcu=ajustar_modelo(bcu)
f7=descriptiva(bcu)

pib=base$PIB
jpeg(paste("./plots/histplot_",nombres[8], ".jpg", sep = ""))
histplot(pib)
dev.off()
Tabla_pib=ajustar_modelo(pib)
f8=descriptiva(pib)

Tabla = rbind(f1, f2, f3, f4, f5, f6, f7, f8)
rownames(Tabla) = nombres
Tabla

## Termino de parte descriptiva de variables

pairs(base)
modelo1 = lm(imacec~tasa)
modelo2 = lm(imacec~bcu)
modelo3 = lm(imacec~desempleo)
modelo4 = lm(imacec~pib)
summary(modelo1)$adj.r.squared
summary(modelo2)$adj.r.squared
summary(modelo3)$adj.r.squared
summary(modelo4)$adj.r.squared

aux = as.factor(mes)
modelo5 = lm(imacec~pib + aux)
summary(modelo5)
modelo6 = lm(imacec~pib + aux + bcu)
summary(modelo6)
