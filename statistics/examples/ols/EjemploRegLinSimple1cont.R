rm(list = ls(all.names = TRUE))
gc()

### Continuación de ejemplo. Compañía Toluca
### Herramientas de diagnóstico sobre homocedasticidad

library(ALSM)
library(latex2exp)
Datos=TolucaCompany
head(Datos)
str(Datos)

par(mfrow=c(1,1)) 
par(mar=c(4, 5, 1, 1))
plot(Datos$x, Datos$y, xlab = TeX("$x$"), ylab=TeX("$y$") )



fit=lm(y~x, data=Datos)
summary(fit)


#R tiene una función para obtener los errores de forma automatizada
# esto servirá para analizar los supuestos del modelo
library(broom)
Datosfit=augment(fit)
head(Datosfit) #.fitted - y_gorrito
               #.resid  - errores observados, e.
               #.hat    - valores h
               #.std.resid  - errores estandarizados
X11()
par(mar=c(4, 5, 1, 1))
par(mfrow=c(1,2)) 
plot(Datosfit$.fitted, Datosfit$.std.resid, xlab = TeX("$\\widehat{y}$"), ylab=TeX("$e_{s}$")   )
plot(Datosfit$x, Datosfit$.std.resid, xlab = TeX("$\\widehat{x}$"), ylab=TeX("$e_{s}$")   )




### Pruebas de hipótesis
### H0: varianza no depende de forma lineal de x vs  Ha: varianza depende de forma lineal de x
### Se busca no rechazar, es decir,
### que sea plausible asumir que la varianza no depende de forma lineal de x
### i.e. p-value mayor a significancia.
#Usa residuales studentilizados
library(lmtest)
lmtest::bptest(fit)

#Usa residuales estandarizados
library(car)
car::ncvTest(fit)  #global
car::ncvTest(fit,~x) #por variable (útil en reg. lineal múltiple)


#R tiene una gráfica propia para verificar homocedasticidad
par(mfrow=c(1,2)) 
par(mar=c(4, 5, 1, 1))
plot(fit, 3)
plot(Datosfit$.fitted, sqrt(abs(Datosfit$.std.resid)), xlab = TeX("$\\widehat{y}$"), ylab=TeX("$e_{s}$")   )







###### Cálculo de los erorres estandarizados a mano, así como las gráficas.

(xbar=mean(Datos$x))
(SSx=sum((Datos$x-xbar)^2))
(ybar=mean(Datos$y))
(SSy=sum((Datos$y-ybar)^2))
(SSxy=sum((Datos$y-ybar)*(Datos$x-xbar)))
(beta1=SSxy/SSx)
(beta0=ybar-beta1*xbar)
n=length(Datos$x)
Datos$yhat=beta0+beta1*Datos$x
Datos$error=Datos$y-Datos$yhat
MSE=sum((Datos$error)^2)/(n-2)

#Se calculan los valores hi y los residales (errores) estandarizados
Datos$hi=(1/n+ (Datos$x-xbar)^2/SSx)
Datos$errorSt=Datos$error/sqrt(MSE*(1-Datos$hi))

X11()
par(mfrow=c(1,3)) 
par(mar=c(4, 5, 1, 1))
plot(Datos$yhat, Datos$errorSt, xlab = TeX("$\\widehat{y}$"), ylab=TeX("$e_{s}$") )
plot(Datos$x, Datos$errorSt , xlab = TeX("$x$"), ylab=TeX("$e_{s}$"))
plot(Datos$x, sqrt(abs(Datos$errorSt)), xlab = TeX("$x$"), ylab=TeX("$\\sqrt{|e_{s}|}$") )
