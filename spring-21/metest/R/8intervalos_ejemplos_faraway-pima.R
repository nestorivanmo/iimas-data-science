library(faraway)

pima

# Ejemplo 1: Datos PIMA
# ¿El IMC de las diabéticas es mayor de las mujeres que no son diabéticas?
#
# X = IMC <- random variable
# mu_x_diabeticas > mu_x_no_diabeticas
#

pima[pima$bmi == 0, ]
pima[pima$bmi > 40, ]
sum(pima$bmi > 40)

table(pima$test) #test: whether the patient shows signs of diabetes (0: negative)
tapply(pima$bmi, pima$test, mean)

mu_x_diabeticas <- mean(pima[pima$test == 1,]$bmi)
mu_x_no_diabeticas <- mean(pima[pima$test == 0,]$bmi)
print(mu_x_diabeticas > mu_x_no_diabeticas) #<- esto no es indicativo

# Los ceros en el IMC deben ser valores faltantes. 
xt <- pima$bmi[pima$test == 0] #no son diabéticas
yt <- pima$bmi[pima$test == 1] #sí son diabéticas

# Limpiando errores
x <- xt[xt > 0]
y <- yt[yt > 0]

summary(x)
summary(y)

par(mfrow = c(1,2))
hist(x, main = "", xlab = "IMC - no diabéticas", ylab = "Cuenta", col = "#EEEEEE", 
     border = "white")
box(lwd = 1)
hist(x, main = "", xlab = "IMC - diabéticas", ylab = "Cuenta", col = "#EEEEEE", 
     border = "white")
box(lwd = 1)

# No podemos tomar una decisión solo basados en estadística descriptiva, por lo 
# que necesitaremos incorporar la incertidumbre de que estamos trabajando con una
# muestra aleatoria

# Hipótesis: mu_x_diabeticas > mu_y_no_diabeticas
#
# mu_y > mu_x
# x1,...,xn
# y1,...,ym
# n != m
#
# mu_y y mu_x son medias a nivel poblacional
#     mu_y > mu_x ==>
#     mu_y - mu_x > 0
# Vamos a hacer inferencia para esta diferencia: 
#     mu_y - mu_x
#
# mu_y - mu_x > 0
#
#   L <= mu_y - mu_x <= U,  (L, U) < 0, mu_x > mu_y
#   L <= mu_y - mu_x <= U,  (L, U) > 0, mu_y > mu_x
#   L <= mu_y - mu_x <= U,  0 \in (L, U), mu_y == mu_x

n <- length(x)
m <- length(y)
x_bar <- mean(x)
y_bar <- mean(y)
s2x <- var(x)
s2y <- var(y)
sxy <- sqrt(s2x/n + s2y/m)

aalfa <- 0.05
z <- qnorm(1-aalfa/2)
y_bar - x_bar + c(-1, 1)*z*sxy #Intervalo de confianza

# ¿Qué quiere decir esto?
#
# 3.56 <= mu_y - mu_x <= 5.53
# Este intervalo cubre a la diferencia con una confianza del 95%
# Si sacáramos muchas muestras y al sacar la diferencia entre mu_x y mu_y
# ese intervalo (3.56, 5.53) cubriría al valor real
#
# mu_y - mu_x > 0 ---> mu_y > mu_x
#
# Por lo tanto, la media de BMI de las diabéticas es mayor a la media de BMI
# de las no diabéticas









