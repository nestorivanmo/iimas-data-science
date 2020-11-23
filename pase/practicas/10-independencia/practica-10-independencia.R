library(ggplot2)
library(RColorBrewer)

#Ejercicio 1: Normal

#1000 puntos (X,Y)
n <- 1000
p <- 0.5
x <- rnorm(n, p)
y <- rnorm(n, p)

df <- data.frame(x=x, y=y)
ggplot(data = df) + 
  geom_jitter(mapping = aes(x = x, y = y), color='darkblue', shape=1, size=2.5) +
  labs(x='X', y='Y', title=paste('Parejas (X,Y) de una distribución normal con', n, ' puntos')) + 
  theme_bw()

#1000 puntos (Z,W)
n <- 1000
p <- 0.5
X <- rnorm(n, p)
Y <- rnorm(n, p)
Z <- X-Y
W <- X+Y
df <- data.frame(x = Z, y = W)
ggplot(data = df) + 
  geom_jitter(mapping = aes(x = Z, y = W), color = 'darkred', shape=1, size=2.5) + 
  labs(x='Z = X - Y', y = 'W = X + Y', title=paste('Parejas (Z,W) de una distribución normal con', n, ' puntos')) +
  theme_bw()


#Ejercicio 2: Multinomial

p <- 1/3







