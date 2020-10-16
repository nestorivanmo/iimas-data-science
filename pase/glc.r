#----------------------
#1: Código del generador lineal congruencial
#----------------------
#X0: semilla
#A: multiplicador
#c: constante aditiva
#m: mod
#n: tamaño del vector de números aleatorios generados
lcg <- function(seed, A, c, m, N) {
  X <- c()
  X[1] <- ((A * seed) + c) %% m
  for (i in 2:N) {
    X[i] <- ((A * X[i-1]) + c) %% m
  }
  return (X)
}
#----------------------
#2: Conjunto de números para c = 0
#----------------------
lgc(15, 2, 0, 7, 10)

#Resultado:
#glc(15, 2, 0, 7, 5) -> 15  2  4  1  2
#glc(15, 2, 1, 7, 5) -> 15  3  0  1  3
#glc(15, 2, 2, 7, 5) -> 15  4  3  1  4

#----------------------
#3: Generar números uniformemente distribuidos en [0,1]
#----------------------
lcg_unif <- function(seed, A, c, m, N) {
  X <- c()
  X[1] <- ((A * seed) + c) %% m
  for (i in 2:N) {
    X[i] <- ((A * X[i-1]) + c) %% m
  }
  X <- X / m
  return (X)
}
multiplier = 1103515245
increment = 12345
mod = (2^31) - 1
lcg_unif(1, multiplier, increment, mod, 5)
#0.5138701 0.4398008 0.6360181 0.4477230 0.4580746

#----------------------
#4: Proponiendo una semilla
#----------------------
seed <- function() {
  time = as.numeric(Sys.time()) * 1000
  timeVector = strsplit(as.character(time), "")[[1]]
  a = length(timeVector) - 6
  b = length(timeVector) - 3
  div = timeVector[a:b]
  s = 0
  counter = 4
  for (i in div) {
    inc = 0
    if (counter == 4) {
      inc = 1000
    } else if (counter == 3) {
      inc = 100
    } else if (counter == 2) {
      inc = 10
    } else {
      inc = 1
    }
    s = s + (as.numeric(i) * inc)
    counter = counter - 1
  }
  return (s)
}
lcg_unif(seed(), multiplier, increment, mod, 5)
#4.391177e-06 7.248305e-01 7.832377e-01 3.294699e-01 1.000000e+00

#----------------------
#5: Discusión del histograma
#----------------------
a <- lcg_unif(seed(), multiplier, increment, mod, 500000)
hist(a, probability = TRUE)

#----------------------
#6: Gráficas con valores variados de m y a
#----------------------
library(plot3D)
a = c(9876, 132456, 3940)
m = c(9087, 3512, 5462)

graph <- function(a, c, m, n=1000) {
  x <- lcg(seed(), a, c, m, n)
  y <- lcg(seed(), a, c, m, n)
  z <- lcg(seed(), a, c, m, n)
  return (plot_ly(x=~x, y=~y, z=~z, type='scatter3d', size=1))
}

show(graph(a[1], 0, m[1]))
show(graph(a[1], 0, m[2]))
show(graph(a[1], 0, m[3]))
show(graph(a[2], 0, m[1]))
show(graph(a[2], 0, m[2]))
show(graph(a[2], 0, m[3]))
show(graph(a[3], 0, m[1]))
show(graph(a[3], 0, m[2]))
show(graph(a[3], 0, m[3]))

show(graph(7 ^ 5, 0, (2^31)-1))


#----------------------
#8: Estimación de PI
#----------------------
circle = function(x) {
  return (sqrt(1 - (x * x)))
}
monte_carlo = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * runif(1, 0, 1))
  }
  return ((4/M) * s)
}
monte_carlo_glc = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * lcg_unif(seed(), multiplier, increment, mod, 50)[2])
  }
  return ((4/M) * s)
}
times <- function(M) {
  start <- Sys.time()
  pi_mc = monte_carlo(circle, -1, 1, M)
  end <- Sys.time()
  mc <- c(pi_mc, as.numeric(end-start))
  print("Monte Carlo: ")
  print(mc)
  start <- Sys.time()
  pi_mc = monte_carlo_glc(circle, -1, 1, M)
  end <- Sys.time()
  mc <- c(pi_mc, as.numeric(end-start))
  print("Monte Carlo GLC: ")
  print(mc)
}

