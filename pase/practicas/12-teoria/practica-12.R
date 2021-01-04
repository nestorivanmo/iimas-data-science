library(plot3D)
library(ggplot2)
library(RColorBrewer)
library(ggExtra)

#Ejercicio 1
funcion_dist_conjunta <- function(x,y){
  exp(-x/y)/y
}

graf_dist <- function(n){
  Y <- runif(n,0,1)
  X <- runif(n,0,1)
  X <- funcion_dist_conjunta(X,Y)
  plot(X, Y, main=paste('Vector aleatorio (X,Y) con n=', n), col='red')
  hist(X, main=paste('Histograma (X,Y) con n=', n), col='red')
}

n <- c(50, 100, 500, 1000)
for (i in n) {
  graf_dist(i)
}

#Ejercicio 2
generate_Y <- function(X, mu, sigma) {
  E <- eigen(sigma)
  M <- E$vectors * sqrt(E$values)
  return (M %*% X + mu)
}

generate_3DHist <- function(data) {
  X <- data[,1]
  Y <- data[,2]
  Z <- table(cut(X, 20), cut(Y, 20))
  hist3D(z=Z, theta=55, phi=20, col = jet.col(100, alpha = 1), contour = TRUE)
}

generate_heatmap <- function(data) {
  X <- data[,1]
  Y <- data[,2]
  hm <- ggplot(as.data.frame(data), aes(x=X, y=Y) ) +
    geom_bin2d(bins=19) + 
    geom_point(color="transparent")
    theme_bw()
  h1 <- ggMarginal(hm, type = "histogram", fill = '#273763')
  h1
}

graph_mult <- function(n, mu, sigma) {
  mult <- matrix(0, nrow = n, ncol = 2)
  for (i in 1:n) {
    X <- rnorm(2)
    Y <- generate_Y(X, mu, sigma)
    mult[i,] = Y
  }
  generate_3DHist(mult)
  generate_heatmap(mult)
}

N <- 3000
mu <- matrix(c(0,0), 2, 1)
sigma <- matrix(c(1,0,0,1), 2, 2)
graph_mult(N, mu, sigma)

mu <- matrix(c(1,0), 2, 1)
sigma <- matrix(c(1,0.7,0.7,1), 2, 2)
graph_mult(N, mu, sigma)

