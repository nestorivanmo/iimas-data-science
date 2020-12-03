#Librerías
library(ggplot2)
library(RColorBrewer)

#Cópula Cuadras-Augé
H <- function(W, V, theta) {
  U <- c()
  for (i in 1:length(W)) {
    w <- W[i]
    v <- V[i]
    if (w < (1-theta) * v^(1-theta)) {
      U <- c(U, (w/(1-theta))*v^theta)
    } else if ((1-theta)*v^(1-theta) <= w && w < v^(1-theta)){
      U <- c(U, v)
    } else if (w >= v^(1-theta)){
      U <- c(U, w^(1/(1-theta)))
    }
  }
  return (U);
}

#Generación de U, V
genera_UV <- function(n, theta) {
  W <- runif(n,0,1)
  V <- runif(n,0,1)
  U <- H(W, V, theta)
  return (list(U=U, V=V))
}

scatter_UV <- function(n=1000,theta) {
  UV_vector <- genera_UV(n, theta)
  U <- UV_vector$U
  V <- UV_vector$V
  x <- seq(0,1,length.out = n)
  
  hist(U, breaks=15, probability=TRUE, main=paste("Histograma para theta=",theta), col="gray")
  par(new = TRUE)
  lines(x,dunif(x),col='#c60fba')
  
  hist(V, breaks=15, probability=TRUE, main=paste("Histograma para theta=",theta), col="gray")
  par(new = TRUE)
  lines(x,dunif(x),col='#c60fba')
  
  P <- ggplot(data.frame(U=UV_vector$U, V=UV_vector$V), aes(x=U, y=V)) +
    geom_point(color = '#c60fba') +
    ggtitle(paste("Diagrama de dispersión para theta="),theta) + 
    theme_classic()
  P
}

#Gráficas
scatter_UV(n=1000, theta=0)
scatter_UV(n=1000, theta=0.1)
scatter_UV(n=1000, theta=0.3)
scatter_UV(n=1000, theta=0.)
scatter_UV(n=1000, theta=0.85)
scatter_UV(n=1000, theta=0.9)

#Parte 2
scatter_UV_log <- function(n=1000,theta) {
  UV_vector <- genera_UV(n, theta)
  U <- UV_vector$U
  V <- UV_vector$V
  X = -log(U)
  Y = -log(V)
  x <- seq(0,6,length.out = n)
  
  hist(X, breaks=15, probability=TRUE, main=paste("Histograma de X para theta=",theta), col="gray")
  par(new = TRUE)
  lines(x,dexp(x),col='#c60fba')
  
  hist(Y, breaks=15, probability=TRUE, main=paste("Histograma de Y para theta=",theta), col="gray")
  par(new = TRUE)
  lines(x,dexp(x),col='#c60fba')
  
  P <- ggplot(data.frame(X=X, Y=Y), aes(x=X, y=Y)) +
    geom_point(color = '#c60fba') +
    ggtitle(paste("Diagrama de dispersión para theta="),theta) + 
    theme_classic()
  P
}

scatter_UV_log(n=1000, theta=0)
scatter_UV_log(n=1000, theta=0.1)
scatter_UV_log(n=1000, theta=0.3)
scatter_UV_log(n=1000, theta=0.5)
scatter_UV_log(n=1000, theta=0.85)
scatter_UV_log(n=1000, theta=0.9)
