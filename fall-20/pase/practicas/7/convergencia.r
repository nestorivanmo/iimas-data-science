#---------------------
#-----Ejercicio 1-----
#---------------------
graph <- function(lambda, n) {
  x <- seq(0,n)
  plot(x, dbinom(x,n,lambda/n), type='s', col='red')
  par(new=TRUE)
  lines(x, dpois(x, lambda), type = 's', col='blue')
  par(new=FALSE)
  legend('topright', legend=c('Binomial', 'Poisson'), col=c('red', 'blue'), 
         lty=1:2)
  title(paste('n=', n, ' lambda=', lambda), )
}

graph(5, 10)
graph(5, 50)
graph(5, 100)

graph(10, 10)
graph(10, 50)
graph(10, 100)

max_error <- function(lambda,n, p) {
  x <- seq(0,n)
  print(max(dbinom(x,n,p)-dpois(x,lambda)))
}

lambda = 10
max_error(lambda, 200, 0.2)
max_error(lambda, 200, 0.4)
max_error(lambda, 200, 0.7)
max_error(lambda, 200, 0.9)

max_error(lambda, 400, 0.2)
max_error(lambda, 400, 0.4)
max_error(lambda, 400, 0.7)
max_error(lambda, 400, 0.9)

max_error(lambda, 2000, 0.4)
graph(10, 2000)
#---------------------
#-----Ejercicio 2-----
#--------------------- 
compare <- function(n, p, top='topright') {
  x <- seq(0, n)
  Xn <- dbinom(x, n, p)
  Yn <- dnorm(x, n*p, sqrt(n*p*(1-p)))
  plot(Yn, type='s', col='blue', xlab='n', ylab='p')
  par(new=TRUE)
  x1 <- seq(0, n, length=1000)
  Y <- dnorm(x1, 0, 1)
  lines(x, Yn, col='red', type='s')
  legend(top, legend=c('Binomial', 'Normal'), col=c('blue', 'red'), lty=1:2, )
  title(paste('n=', n, ' p=', p))
  print(100*mean(sqrt((Xn - Yn)^2)))
}
compare(100, 0.4)
compare(200, 0.4)
compare(400, 0.4)
