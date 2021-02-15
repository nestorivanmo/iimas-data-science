densidad <- function(X, a, b) {
  ( (X^(a - 1))*( (1-X)^(b-1) ) )  / beta(a,b) 
}

aceptar_rechazo <- function(a, b){
  cota <- calcula_cota(a, b)
  i <- 1
  X <- runif(1,0,1)
  Y <- runif(1,0,cota)
  while ( Y >= densidad(X, a, b) ) {
    X <- runif(1,0,1)
    Y <- runif(1,0,cota)
    i <- i + 1
  }
  t <- list(X, i)
  return (t)
}

calcula_cota <- function(a, b) {
  if (a == 0.5 && b == 0.5) {
    return (4)
  } else {
    s <- seq(0, 1, length.out = 1000)
    v <- densidad(s, a, b)
    return (max(v) + 0.3) 
  }
}

simulate_beta <- function(a, b, n) {
  v <- c()
  for (i in 1:n) {
    v <- append(v, as.double(aceptar_rechazo(a, b)[1]))
  }
  return (v)
}

graph_hist_beta <- function(a, b, title, n=10000, breaks=40) {
  beta <- simulate_beta(a, b, n)
  hist(beta, col = "#efacac", border = "#e59595", breaks=breaks, 
       probability = TRUE, main=paste("Histograma de Beta(", a, ",", b,") n=", n), xlab = "X")
  par(new=TRUE)
  s = seq(0, 1, length.out = n)
  lines(s, densidad(s, a, b), col = 'blue', lw = 2)
}

graph_hist_beta(2, 2)
graph_hist_beta(0.8, 0.8)

average_iterations <- function(n, a, b) {
  iterations <- c()
  for (i in 1:n) {
    num_it <- as.double(aceptar_rechazo(a, b)[2])
    iterations <- append(iterations, num_it)
  }
  return (mean(iterations))
}

graph_avg_iterations <- function(n_vals, a, b) {
  iterations <- c()
  for (n in n_vals) {
    iterations <- append(iterations, average_iterations(n, a, b))
  }
  print(iterations)
  plot(n_vals, iterations, main = paste("Beta (", a, ",", b, ")"), xlab = "número de variables Beta", 
       ylab = "número promedio de iteraciones", col = '#d3d3d3', type = 'p')
  for (n in 1:length(iterations)) {
    text(x=n_vals[n], y=iterations[n], round(iterations[n], 2))
  }
}

n <- c(10, 100, 200, 500, 1000, 2000, 3000)
graph_avg_iterations(n, a=2, b=5)

