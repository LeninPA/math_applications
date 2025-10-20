rm(list = ls(all.names = TRUE))
gc()

### Compañía Toluca. Continuación de ejemplo. 

### Verificación sobre aleatoriedad
### Lo más importante es la recolección y selección
### de la muestra (Lo que aquí se presenta es extra a lo anterior)

library(ALSM)

Datos=TolucaCompany
head(Datos)
str(Datos)

library(latex2exp)
par(mfrow=c(1,1)) 
par(mar=c(4, 5, 1, 1))
plot(Datos$x, Datos$y, xlab = TeX("$x$"), ylab=TeX("$y$") )



fit=lm(y~x, data=Datos)
summary(fit)

#R tiene una función para obtener errores de forma automatizada
library(broom)
Datosfit=augment(fit)
head(Datosfit)

#gráficas para linealidad-homocedasticidad-normalidad
X11()
par(mar=c(4, 5, 2, 1))
par(mfrow=c(1,3))
plot(fit, 1)
plot(fit, 3)
plot(fit, 2)


X11()
#gráfica sobre el índice de los datos vs los residuales estandarizas
par(mar=c(4, 5, 3, 1))
par(mfrow=c(1,3))
plot(1:length(Datosfit$.std.resid), Datosfit$.std.resid, xlab = TeX("$i$"), ylab=TeX("$e_s$")   )

#Prueba de rachas, incluye una gráfica para entender la idea
#de la definición de las rachas.
library(lawstat)
lawstat::runs.test(Datosfit$.std.resid, plot.it = TRUE)
library(randtests)
randtests::runs.test(Datosfit$.std.resid)


#Autocorrelograma de los errores
acf(Datosfit$.std.resid)



#Prueba para autocorrelación de orden 1
library(lmtest)
lmtest::dwtest(fit, alternative = c("two.sided"))
library(car)  #tiene una función para revisar más ordenes y complementar el autocorrelograma
durbinWatsonTest(fit, max.lag=5)



