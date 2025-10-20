rm(list = ls(all.names = TRUE))
gc()

### Continuación de ejemplo. 
#   Argumentación para normalidad 
#   (no encontrar evidencia en contra)
#

library(ALSM)
library(latex2exp)
Datos=TolucaCompany
head(Datos)
str(Datos)

X11()
par(mfrow=c(1,1)) 
par(mar=c(4, 5, 1, 1))
plot(Datos$x, Datos$y, xlab = TeX("$x$"), ylab=TeX("$y$") )



fit=lm(y~x, data=Datos)
summary(fit)


X11()
#gráficas para linealidad y homocedasticidad
par(mar=c(4, 5, 1, 1))
par(mfrow=c(1,2))
plot(fit, 1)
plot(fit, 3)

#n no es tan grande, veamos qué observamos si aplicamos lo de n grande
#gráfica QQplot directa de R
par(mar=c(4, 5, 1, 1))
par(mfrow=c(1,1))
plot(fit, 2)
#Se usan los residuales estandarizados y los cuantiles de una normal


#R tiene una función para crear errores de forma automatizada
library(broom)
Datosfit=augment(fit)
head(Datosfit)
#Pruebas de normalidad

shapiro.test(Datosfit$.std.resid)

library(nortest)
nortest::lillie.test(Datosfit$.std.resid)

library(tseries)
tseries::jarque.bera.test(Datosfit$.std.resid)


########################
#Aplicamos lo recomendable cuando n es pequeña

#Para obtener errores studentizados:
library(MASS)
(ResStudent=studres(fit))
library(car)
qqPlot(ResStudent, dist="t", df=length(ResStudent)-3,  envelope=FALSE)

#Prueba Kolmogorov-Smirnov 
ks.test(ResStudent, "pt", length(ResStudent)-3)

# Para este modelo no se encontró evidencia en contra de 
# la normalidad
