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
  labs(x='X', y='Y', title=paste('Parejas (X,Y) de una distribución normal con', 
                                 n, ' puntos')) + 
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
  labs(x='Z = X - Y', y = 'W = X + Y', title=paste('Parejas (Z,W) de una distribución 
                                                   normal con', n, ' puntos')) +
  theme_bw()


#Ejercicio 2: Multinomial
generate_X <- function(n, verbose=FALSE) {
  X1 <- 0
  X2 <- 0
  X3 <- 0
  B <- runif(n, min=1, max=300)
  for (x in B) {
    if (x <= 100) {
      X1 <- X1 + 1 
    } else if (x > 100 && x <= 200) {
      X2 <- X2 + 1
    } else {
      X3 <- X3 + 1
    }
  }
  X <- c(X1, X2, X3)
  if (verbose) {
    print(X1)
    print(X2)
    print(X3)
  }
  return (X)
}

graph_X <- function(n) {
  X <- generate_X(n)
  X1 <- X[1]
  X2 <- X[2]
  X3 <- X[3]
  df <- data.frame(x=X1, y=X2, z=X3)
  ggplot(data = df) + 
    geom_raster(mapping = aes(fill = X3), x=X1, y=X2)
}

graph_X(100)
