## Ejercicio 1

grafica_bernoulli <- function(N, p) {
  x <- 1:N
  y <- cumsum(rbern(N, p)) / x
  plot(x, y, type='l', xlab='N', ylab='Xn', main = paste('Bernoulli(', p, '); n=', N))
  par(new = T)
  lines(x, rep(p, N), col='red', type='l', lty=2)
}

grafica_bernoulli(100, 0.5)
grafica_bernoulli(1000, 0.5)

grafica_pareto <- function(N, a, b) {
  x <- 1:N
  y <- cumsum(rPareto(N, a, b)) / x
  mu <- (a*b) / (a - 1)
  plot(x, y, type='l', xlab='N', ylab='Xn', main = paste('Pareto(', a, ', ', b, '); n=', N))
  par(new = T)
  lines(x, rep(mu, N), col='red', type='l', lty=2)
}

grafica_pareto(100, 2, 2)
grafica_pareto(1000, 2, 2)

N <- 10000
x <- 1:N
p <- 0.5
y <- sum(rbern(N, p)) / x
y[10000]
abs(y[10000] - 0.5) > 10 ^ (-5)


promedio <-function(n, f, ...){
  args <-as.list(c(...));
  variables_aleatorias <-do.call(f,c(list(n), args));
  suma <-sum(variables_aleatorias)
  return(suma/n);
}

iteraciones_promedio_error <-function(media, error, n_inicial=1, f, ...){
  n <- n_inicial;
  calculado <- promedio(n, f, ...)
  error_actual <-abs(calculado-media);
  while(error_actual>error){
    n <- n+1;
    calculado <- promedio(n, f, ...)
    error_actual <-abs(calculado-media);
  }
  print(paste('n=', n, ' valor calculado=', calculado, 'media=', media, ' error_actual=', error_actual))
  return(n);
}

error <- 10 ^ (-5)
p <- 0.5
media <- p
iteraciones_promedio_error(media, error, n_inicial=100, rbern, p)

error <- 10 ^ (-3)
a <- 1.98
b <- 6
media <- b * a / (b - 1)
iteraciones_promedio_error(media, error, n_inicial=1, rPareto, a, b)
error

## Ejercicio 2

simulacion_suma_caras_dados <- function(num_dados = 7, num_caras = 6){
  simulacion_cada_dado <- floor(runif(num_dados) * num_caras + 1)
  suma <- sum(simulacion_cada_dado);
  return(suma);
}


verificar_cuantos_hay <- function(n, num_dados = 7, num_caras = 6, graficar = F){
  v <- c()
  dimension <- num_dados * num_caras
  t <- rep(0, dimension)
  for(i in 1:n){
    suma <- simulacion_suma_caras_dados(num_dados, num_caras);
    t[suma] = t[suma] + 1
    v <- c(v, suma);
  }
  cuenta <- table(v) / n;
  if(graficar){
    plot(cuenta, xlab='k', ylab='P(X=k)', main=paste('Estimación de X=k para n=', n));
  }
  total <- t[num_dados : dimension] / n
  return(list("cuenta" = cuenta, "total" = total));
}

verificar_cuantos_hay(100, graficar=T)

error <- function(e, n_inicial = 1000, incremento = 100) {
  n1 <- verificar_cuantos_hay(n_inicial)$total
  n2 <- verificar_cuantos_hay(n_inicial + incremento)$total
  m <- max(abs(n1-n2))
  while (m > e) {
    print(paste(m, n_inicial, n_inicial + incremento))
    n1 <- verificar_cuantos_hay(n_inicial)$total
    n2 <- verificar_cuantos_hay(n_inicial + incremento)$total
    m <- max(abs(n1-n2))
    n_inicial = n_inicial + incremento
  }
  return (m);
}
error(e = 0.02, n_inicial = 500, incremento = 100)
