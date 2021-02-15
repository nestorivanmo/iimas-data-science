#Barajas Alfonso
#Figueroa Soriano Rodolfo
#Martinez Nestor
#Vazquez Jose David

glc <- function(x0, a, k, m, n) {
  v <- c()
  v[1] <- x0
  for (i in 2:n){
    v[i] <- (a*v[i-1]+k)%%m
  }
  v <- v / max(v)
  return(v)
}

# Parte 1: histograma
a <- glc(1, 48271, 0, (2 ^ 31) - 1, 500000)
hist(a, probability = TRUE)

# Parte 2: Grafica en R3
install.packages("plotly")

a1 <- glc(1, 48271, 0, (2 ^ 31) - 1, 1000)
a2 <- glc(1, 48271, 0, (2 ^ 19) - 1, 1000)
a3 <- glc(1, 48271, 0, (2 ^ 17) - 1, 1000)
a4 <- glc(2, 48271, 0, (2 ^ 31) - 1, 1000)
a5 <- glc(2, 48271, 0, (2 ^ 19) - 1, 1000)
a6 <- glc(2, 48271, 0, (2 ^ 17) - 1, 1000)
a7 <- glc(5, 48271, 0, (2 ^ 31) - 1, 1000)
a8 <- glc(5, 48271, 0, (2 ^ 19) - 1, 1000)
a9 <- glc(5, 48271, 0, (2 ^ 17) - 1, 1000)

x <- rep(1, 1000)
y <- rep("a1", 1000)
z <- a1

fig <- plot_ly(x = ~x, y = ~y, z = ~z, type = 'scatter3d')
show(fig)
