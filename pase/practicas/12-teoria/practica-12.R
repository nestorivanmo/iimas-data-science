n <- 100
U <- runif(n)
W <- rexp(n, 1/2)
X <- sqrt(W)*cos(2*pi*U)
Y <- sqrt(W)*sin(2*pi*U)

f <- function(X,Y){
  densidad <- c()
  for (i in 1:length(X)) {
    x <- X[i]
    y <- Y[i]
    densidad <- append(densidad, (exp(-x/y)*exp(-y)) / y)
  }
  return (densidad)
}

graph <- function(densidad, n) {
  hist(densidad, breaks=10)
  par(new=TRUE)
  lines(seq(0, 2, length.out = n), densidad, col='purple')
  #plot(seq(n), densidad,lty=2,col='purple')
}

graph(f(runif(n), runif(n)), n)
graph(f(rexp(n), rexp(n)), n)
