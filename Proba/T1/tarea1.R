base = read.table(file.choose(), dec = ".", header = FALSE) # Base de Datos01.txt
base2 = read.table(file.choose(), dec = ",", header = TRUE) # Base de Datos02.txt
base3 = read.table(file.choose(), dec = ",", header = TRUE) # Base de Datos03.txt
# Tenemos las 3 bases cargadas y listas para usarse
## Funciones
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
  #colnames(a)=c("exp","normal","log-normal","logist","log-logist","weibull")
  a
}
####

# Copiamos las funciones dadas
######################
## Distribución SEV ##
######################

## Función de Densidad ##
dsev = function(x, location = 0, scale = 1){
  mu = location
  sigma = scale
  z = (x - mu)/sigma
  aux = exp(z-exp(z))/sigma
  aux
}

## Función de Distribución de Probabilidad Acumulada ##
psev = function(q, location = 0, scale = 1){
  mu = location
  sigma = scale
  z = (q - mu)/sigma
  aux = 1-exp(-exp(z))
  aux
}

## Función de Distribución de Probabilidad Acumulada Inversa ##
qsev = function(p, location = 0, scale = 1){
  mu = location
  sigma = scale
  aux = mu + sigma * log(-log(1-p))
  aux
}
X = base$V1
hist(X, freq = FALSE)
x = seq(0, 60, 0.01)
chi = 0.5772
sigma = sqrt(var(X)*6)/pi
mu = mean(X) + sigma*chi
lines(dsev(x, mu, sigma)~x, col = "red")
# 2*a*gamma(2/a)/(gamma (1/a))^2-1  = 0.02581972= sd(X)^2/mean(X)^2
# esto era lo que habia que resolver
a = 7.344445 # No se resolverlo analiticamente, se lo pase a wolfram
b = mean(X)*a/gamma(1/a)
lines(dweibull(x, a, b)~x, col = "blue")
lines(dnorm(x, mean = mean(X), sd = sd(X))~x, col = "green")
g = sort(X)
N = length(X)
p = 1:N/(N+1)
y = log(-log(1-p))
par(mfrow=c(1,1))
plot(g~qnorm(p))
abline(lm(g~qnorm(p)), lwd = 3,col = "red")
plot(g~qsev(p))
abline(lm(g~qsev(p)), lwd=3, col = "green")
plot(g~log(qweibull(p, shape=1)))
abline(lm(g~log(qweibull(p,shape=1)))$coef, lwd = 3, col = "blue")
hist(X, freq = FALSE)
recta = lm(g~qsev(p))$coef
mu = recta[1]
sigma = recta[2]
lines(dsev(x, mu, sigma)~x, col="red", lwd = 2)
recta = lm(g~log(qweibull(p,shape = 1)))$coef
a = recta[2]+3
b = recta[1]
lines(dweibull(x,a,b)~x, col = "blue", lwd =2)
recta = lm(g~qnorm(p))$coef
mu = recta[1]
sigma = recta[2]
lines(dnorm(x, mu, sigma)~x, col="green", lwd = 2)
#qqplot(X,qweibull(p, shape = b))
#qqplot(X,qnorm(p, mean = mean(X), sd = sd(X)))
#qqplot(X,qsev(p, mu, sigma))
#abline(a = 2, b= 0.95, col="red", lwd=3)
#abline(a = -0.69, b= 1, col="red", lwd=3)
head(base2)
#Latitud, Longitud, Magnitud, Profundidad, Radiacion, Presion, Humedad, Temperatura y VelocidadViento
latitud=base2$Latitud
histplot(latitud)
Tabla_Latitud=ajustar_modelo(latitud)
f1=descriptiva(latitud)

Longitud=base2$Longitud
histplot(Longitud)
Tabla_Longitud=ajustar_modelo(Longitud)
f2=descriptiva(Longitud)

Magnitud=base2$Magnitud
histplot(Magnitud)
Tabla_Magnitud=ajustar_modelo(Magnitud)
f3=descriptiva(Magnitud)

Profundidad=base2$Profundidad
histplot(Profundidad)
Tabla_Profundidad=ajustar_modelo(Profundidad)
f4=descriptiva(Profundidad)

Radiacion=base2$Radiacion
histplot(Radiacion)
Tabla_Radiacion=ajustar_modelo(Radiacion)
f5=descriptiva(Radiacion)

Presion=base2$Presion
histplot(Presion)
Tabla_Presion=ajustar_modelo(Presion)
f6=descriptiva(Presion)

Humedad=base2$Humedad
histplot(Humedad)
Tabla_Humedad=ajustar_modelo(Humedad)
f7=descriptiva(Humedad)

Temperatura=base2$Temperatura
histplot(Temperatura)
Tabla_Temperatura=ajustar_modelo(Temperatura)
f8=descriptiva(Temperatura)

VelocidadViento=base2$VelocidadViento
VelocidadViento[!is.finite(VelocidadViento)] <- 0
histplot(VelocidadViento)
Tabla_VelocidadViento=ajustar_modelo(VelocidadViento)
f9=descriptiva(VelocidadViento)

Tabla=rbind(f1,f2,f3,f4,f5,f6,f7,f8,f9)
rownames(Tabla)=c("Latitud", "Longitud", "Magnitud", "Profundidad", "Radiacion", "Presion", "Humedad", "Temperatura","VelocidadViento")
Tabla
