library(ggplot2)

H <- function(u, v, theta) {
  if (u < (1-theta)*v^(1-theta)) {
    ans <- (u/(1-theta))*v^theta
    return(ans)
  }
  if ((1-theta)*v^(1-theta) <= u && u < v^(1-theta)){
    return(v)
  }
  if (u >= v^(1-theta)){
    ans <- u^(1/(1-theta))
    return(ans)
  }
}

genGraph <- function(n=10000, theta){
  U <- c()
  V <- c()
  for(i in 1:n){
    w <- runif(1, 0, 1)
    v <- runif(1, 0, 1)
    u <- H(w, v, theta)
    U <- c(c(U), u)
    V <- c(c(V), v)
    dat <- data.frame(U=U,V=V)
  }
  
  hist(U, breaks=15, probability=TRUE, main=paste("Histograma para theta=",theta), col="skyblue")
  par(new = TRUE)
  x <- seq(0,1,length.out = 1000)
  lines(x,dunif(x),col='red')
  legend('bottomright', legend = c('Variable U','Densidad uniforme'), col=c('skyblue','red'),lty=1:2)
  
  hist(V, breaks=15, probability=TRUE, main=paste("Histograma para theta=",theta), col="green")
  par(new = TRUE)
  x <- seq(0,1,length.out = 1000)
  lines(x,dunif(x),col='red')
  legend('bottomright', legend = c('Variable V','Densidad uniforme'), col=c('green','red'),lty=1:2)
  
  P<-ggplot(dat, aes(x=U, y=V, color="red")) + geom_point()+ggtitle(paste("Diagrama de dispersion para theta="),theta)
  P
}

genGraph2 <- function(n=1000, theta){
  U <- c()
  V <- c()
  for(i in 1:n){
    w <- runif(1, 0, 1)
    v <- runif(1, 0, 1)
    u <- H(w, v, theta)
    U <- c(c(U), u)
    V <- c(c(V), v)
    dat <- data.frame(U=U,V=V)
  }
  X = -log(U)
  Y = -log(V)
  dat <- data.frame(U=U, V=V, X=X, Y=Y)
  hist(X, breaks=30, probability=TRUE, main=paste("Histograma de X para theta=",theta), col="skyblue")
  par(new = TRUE)
  x = seq(0,1,length.out = 1000)
  lines(x, dexp(x),col='red')
  legend('bottomright', legend = c('Variable U','Densidad uniforme'), col=c('skyblue','red'),lty=1:2)
  
  hist(Y, breaks=30, probability=TRUE, main=paste("Histograma de Y para theta=",theta), col="skyblue")
  par(new = TRUE)
  x = seq(0,1,length.out = 1000)
  lines(x, dexp(x),col='red')
  legend('bottomright', legend = c('Variable U','Densidad uniforme'), col=c('skyblue','red'),lty=1:2)
  
  P<-ggplot(dat, aes(x=X, y=Y, color="red")) + geom_point()+ggtitle(paste("Diagrama de dispersion para theta="),theta)
  P
}
genGraph2(theta=0)


thetas <- c(0, 0.1, 0.3, 0.85, 0.9)
for (theta in thetas){
  genGraph2(theta=theta)
}
