# #Barajas Alfonso
# #Figueroa Soriano Rodolfo
# #Martinez Nestor
# #Vazquez Jose David

#----------------------
#1: Código del generador lineal congruencial
#----------------------
#X0: semilla
#A: multiplicador
#c: constante aditiva
#m: mod
#n: tamaño del vector de números aleatorios generados
glc <- function(X0, A, c, m, n) {
  v <- c()
  v[1] <- X0
  for (i in 2:n){
    v[i] <- (A*v[i-1]+c)%%m
  }
  return(v)
}
#----------------------
#2: Conjunto de números para c = 0
#----------------------
glc(15, 2, 0, 7, 5)

#Resultado:
#glc(15, 2, 0, 7, 5) -> 15  2  4  1  2
#glc(15, 2, 1, 7, 5) -> 15  3  0  1  3
#glc(15, 2, 2, 7, 5) -> 15  4  3  1  4

#----------------------
#3: Generar números uniformemente distribuidos en [0,1]
#----------------------
glc_uniform <- function(X0, A, c, m, n) {
  v <- c()
  v[1] <- X0
  for (i in 2:n){
    v[i] <- (A*v[i-1]+c)%%m
  }
  v <- v / max(v) #uniformemente distribuidos
  return(v)
}
multiplier = 1103515245
increment = 12345
mod = (2^31) - 1
glc_uniform(1, multiplier, increment, mod, 5)
#7.321510e-10 8.079489e-01 6.914911e-01 1.000000e+00 7.039470e-01

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
glc_uniform(seed(), multiplier, increment, mod, 5)
#4.391177e-06 7.248305e-01 7.832377e-01 3.294699e-01 1.000000e+00

#----------------------
#5: Discusión del histograma
#----------------------
a <- glc_uniform(seed(), multiplier, increment, mod, 500000)
hist(a, probability = TRUE)

#----------------------
#6: Gráficas con valores variados de m y a
#----------------------
glc_simple<- function(a, m, n) {
v <- c()
  v[1] <- seed()
for (i in 2:n){
  v[i] <- (a*v[i-1])%%m
}

v <- v / max(v)
return(v)
}

# Parametros
a_list <- c(5^5, 7^5, 9^5)
m_list <- c(51330, 28434, 6652)

rand_list <- list()
limit <- 1000
count <- 1
for (i in a_list){
  for (j in m_list){
    rand_list[[count]] <- glc_simple(i, j, limit)
    count <- count+1
  }
}

x_list <- list()
y_list <- list()
z_list <- list()
count <- 1
for (r in rand_list){
  x <- c()
  y <- c()
  z <- c()
  for (i in 1:limit-2){
    x[i] = r[i]
    y[i] = r[i+1]
    z[i] = r[i+2]
  }
  x_list[[count]] <- x
  y_list[[count]] <- y
  z_list[[count]] <- z
  count <- count+1
}

## Para graficar
library(plotly)

plot_list <- list()
for (i in 1:length(x_list)){
  plot_list[[i]] <- plotly_build(plot_ly(x=~unlist(x_list[i]), y=~unlist(y_list[i]), z=~unlist(z_list[i]), type='scatter3d', mode='markers'))
}

# Grafica con todas las graficas en una
fig <- subplot(plot_list, nrows=3)
show(fig)

# Para graficar una sola grafica ejecutar:
# show(plot_list[i]) # con i del 1 al 9


#----------------------
#7: Repetir lo anterior con a = 7^5 , m = (2^31) − 1 y comparar las graficas
#----------------------
comp<-glc_simple(7^5,(2^31)-1 , limit)
x <- c()
y <- c()
z <- c()
for(i in 1:length(comp)-2){
  x[i] <- comp[i]
  y[i] <- comp[i+1]
  z[i] <- comp[i+2]
}
fig <- plot_ly(x=~x, y=~y, z=~z, type='scatter3d', mode= 'markers',size = ~2))
fig

#----------------------
#8: Estimación de pi con GLC
#----------------------

#--------------------
# Monte Carlo
#--------------------
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
    s = s + G(a + (b - a) * glc_uniform(seed(), multiplier, increment, mod, 50)[2])
  }
  return ((4/M) * s)
}
pi_mc = monte_carlo(circle, -1, 1, 10)
pi_glc = monte_carlo_glc(circle, -1, 1, 10)

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
