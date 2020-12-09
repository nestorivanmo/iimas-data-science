funcion_dist_conjunta <- function(x,y){
  #exp(-x/y)/(y*(1-(1/exp(1))))
  exp(-x/y)/y
}

graf_dist <- function(n){
  X <- c()
  Y <- c()
  Y <- runif(1000,0,1)
  X <- runif(1000,0,1)
  X <- funcion_dist_conjunta(X,Y)
  plot(X,Y)
  hist(X)
  plot(X, Y)
}

n = 100
graf_dist(100)


#Ejercicio 2
multival <- function(mu,sigma){
  n <- length(mu)
  x <- c()
  for (i in 1:n){
    x<-append(x,rnom(0,mu[n]))
  }
  y<- x%*%sigma + mu
}
mu <- c(0,0)
sigma <-matrix(c(1,0,0,1),nrow=2,ncol=2,byrow=TRUE)
sigma

library(plot3D)
hist3D(z=table(sigma[1], sigma[2]))



