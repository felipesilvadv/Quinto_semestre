base = read.table(file.choose(), dec = ".", header = FALSE) # Base de Datos01.txt
base2 = read.table(file.choose(), dec = ",", header = TRUE) # Base de Datos02.txt
base3 = read.table(file.choose(), dec = ",", header = TRUE) # Base de Datos03.txt
# Tenemos las 3 bases cargadas y listas para usarse

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
par(mfrow=c(1,1))
plot(g~qnorm(p))
linea = mean(X) + sd(X)*qnorm(p)
abline(lm(g~qnorm(p)), lwd = 3,col = "red")
abline(a = a, b = b, lwd = 3, col = "blue")
abline(a = mu, b= sigma, lwd=3, col = "green")
qqplot(X,qweibull(p, shape = b))
qqplot(X,qnorm(p, mean = mean(X), sd = sd(X)))


