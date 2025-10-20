rm(list = ls(all.names = TRUE))
gc()

### Ejemplo, continuación. Verificación sobre aleatoriedad

setwd("~/GitHub/Notas 2026-1/MNPyR")
Datos = read.csv("ejemplo4.csv")
library(latex2exp)
head(Datos)
str(Datos)

par(mfrow=c(1,1)) 
par(mar=c(4, 5, 1, 1))
plot(Datos$x, Datos$y, xlab = TeX("$x$"), ylab=TeX("$y$") )



fit=lm(y~x, data=Datos)
summary(fit)

#Se transforma X a X^2 para lograr linealidad
Datos$Xprima=Datos$x^2
fit2=lm(y~Xprima, data=Datos)
summary(fit2)

X11()
#gráficas para linealidad-homocedasticidad-normalidad
par(mar=c(4, 5, 2, 1))
par(mfrow=c(1,3))
plot(fit2, 1)
plot(fit2, 3)
plot(fit2, 2)


X11()
#gráfica sobre el índice de los datos vs los residuales estandarizados
library(broom)
Datosfit2=augment(fit2)
head(Datosfit2)
par(mar=c(4, 5, 3, 1))
par(mfrow=c(1,3))
plot(1:length(Datosfit2$.std.resid), Datosfit2$.std.resid, xlab = TeX("$i$"), ylab=TeX("$e_s$")   )


#Prueba de rachas
library(lawstat)
lawstat::runs.test(Datosfit2$.std.resid, plot.it = TRUE)
library(randtests)
randtests::runs.test(Datosfit2$.std.resid)


#autocorrelograma de los errores
acf(Datosfit2$.std.resid)





#Prueba para autocorrelación de orden 1
lmtest::dwtest(fit2, alternative = c("two.sided"))
library(car)  #tiene una función para revisar más ordenes
durbinWatsonTest(fit2, max.lag=5)



####Extras, what if.....



## Si se hubiera hecho la revisión con el modelo sin transformar
## Observar orden en los datos con respecto a x de 10 en 10
Datosfit=augment(fit)
head(Datosfit)
par(mar=c(4, 5, 3, 1))
par(mfrow=c(1,1))
plot(Datos$x, Datos$y, xlab = TeX("$x$"), ylab=TeX("$y$") )

par(mar=c(4, 5, 3, 1))
par(mfrow=c(1,3))
plot(1:length(Datosfit$.std.resid), Datosfit$.std.resid, xlab = TeX("$i$"), ylab=TeX("$e_s$")   )
acf(Datosfit$.std.resid)
lawstat::runs.test(Datosfit$.std.resid, plot.it = TRUE)
durbinWatsonTest(fit, max.lag=5)


# Es decir,
# Si la base de datos es manipulada en la captura o procesamiento
# o si el modelo aún no corrige problemas de homocedasticidad o linealidad
# las herramientas podrían fallar, pero eso no indica el
# no cumplimiento del supuesto
# Es más importante revisar el proceso de generación de los datos


############ Ejemplo donde aplicando un ordenamiento a la base de datos
############ podríamos tener duda
############ sobre aleatoriedad al usar las herramientas
# Si se ordenan los datos con respecto a "y"
# y usamos el modelo que parece cumplir
# homocedasticidad y linealidad:
Datos.or=Datos[order(Datos$y), ]
fit.or=lm(y~Xprima, data=Datos.or)
summary(fit.or)
Datosfit.or=augment(fit.or)

X11()
#gráfica sobre el índice de los datos
par(mar=c(4, 5, 3, 1))
par(mfrow=c(1,2))
plot(1:length(Datosfit.or$.std.resid), Datosfit.or$.std.resid, xlab = TeX("$i$"), ylab=TeX("$e_s$")   )
#autocorrelograma de los errores
acf(Datosfit.or$.std.resid)
library(car)  
durbinWatsonTest(fit.or, max.lag=5)


#No parece existir problema con linealidad-homocedasticidad-normalidad
#pero sí con aleatoriedad, dado ese ordenamiento de la base de datos.
X11()
par(mar=c(4, 5, 2, 1))
par(mfrow=c(1,3))
plot(fit.or, 1)
plot(fit.or, 3)
plot(fit.or, 2)

