#Ejercicio 1
Normal <- function(k,n,p){
  VA <- c()
  for (i in 1:1000){       # Se crean  mil v.a. normales
    VA[i] <- (sum(rbinom(k,n,p)) -k*n*p)/(sqrt(k*n*p*(1-p)))
  }
  return(VA)
}

x <- Normal(10,10,0.5)
y <- Normal(10,10,0.5)

plot(x,y)

z <- x-y
w <- x+y

plot(z,w)

#Usando rnorm

x <- c()
y <- c()
for( i in 1:100){
x[i] <- rnorm(10,5,2.5)
y[i] <- rnorm(10,5,2.5)
}
plot(x,y)

z <- x-y
w <- x+y

plot(z,w)

#Ejercicio 2
library(Rlab)
p <- 1/3
n <- 100


y <- c()
x1 <- 0
x2 <- 0
x3 <- 0
for (i in 1 : 20){
  a <- runif(1,0,1)
  if (a<0.3){
    x1 <-x1+1
    y[i] <- .3
  }

  if (0.3<=a<0.55){
    x2 <- x2 +1
    y[i] <- .25
  }

  if (0.55<=a<1){
    x3 <- x3+ 1
    y[i] <- .45
  }
}

# Generador de (X1,X2,X3) con p1,p2,p3=1/3
vector_aleatorio <- function(n,k){
  y <- runif(n,0,1)
  Y <- y
  X <- integer(k)

  for (j in 1:n){
    if(y[j]<1/3){
      Y[j] <- 1
    }
    if(y[j]>1/3 && y[j]<2/3){
      Y[j] <- 2
    }
    if(y[j]>2/3 && y[j]<1){
      Y[j] <- 3
    }
  }
  for (i in 1:k){
    for (j in 1:n){
      if(Y[j]==i){
        X[i] <- X[i]+1
      }
    }
  }
  X <- X/n
  X
}

x <- c()
y <- c()
z <- c()
for (i in 1:1000){
  x <- c(x,vector_aleatorio(600,3)[1])
  y <- c(y,vector_aleatorio(600,3)[2])
  z <- c(z,vector_aleatorio(600,3)[3])
}

plot(x,y)
plot(y,z)
plot(x,z)


#Probabilidad multinomial

P(X) <- (factorial(n)/ (factorial(X1)*factorial(X1)*factorial(X3)) )*(1/3)^n
