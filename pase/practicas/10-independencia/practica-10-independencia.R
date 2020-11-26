library(ggplot2)
library(RColorBrewer)
library(plotly)

#Ejercicio 1: Normal
graph_normal <- function(X, Y, title, xlab, ylab, color) {
  df <- data.frame(x = X, y = Y)
  ggplot(data = df) + 
    geom_jitter(mapping = aes(x = Z, y = W), color = color, shape=1, size=2.5) + 
    labs(x = xlab, y = ylab, title = title) +
    scale_x_continuous(limits=c(-5,5)) +
    scale_y_continuous(limits = c(-5,7)) +
    theme_bw()
}

#1000 puntos (X,Y)
n <- 1000
p <- 0.5
X <- rnorm(n, p)
Y <- rnorm(n, p)
title <- paste('Parejas (X,Y) de una distribución normal con', n, ' puntos')
graph_normal(X, Y, title, 'X', 'Y', 'darkblue')

#1000 puntos (Z,W)
Z <- X-Y
W <- X+Y
title <- paste('Parejas (Z,W) de una distribución normal con', n, ' puntos')
graph_normal(Z, W, title, 'Z=X-Y', 'W=X+Y', 'darkred')


#Ejercicio 2: Multinomial
#Parte 1: representación gráfica de una multinomial con distintas n
generate_X <- function(n) {
  X1 <- 0
  X2 <- 0
  X3 <- 0
  B <- runif(n, min=1, max=300)
  for (x in B) {
    if (x <= 100) {
      X1 <- X1 + 1 
    } else if (x > 100 && x <= 200) {
      X2 <- X2 + 1
    } else {
      X3 <- X3 + 1
    }
  }
  X <- c(X1, X2, X3)
  return (X)
}

multinomial <- function(n, num_rows) {
  mx <- matrix(nrow = num_rows, ncol = 3)
  for (i in 1:num_rows) {
    mx[i, ] <- generate_X(n)
  }
  return (mx);
}

graph_multinomial <- function(matrix) {
  fig <- plot_ly(as.data.frame(matrix), x = matrix[,1], y = matrix[,2], z = matrix[,3],
                 marker=list(color=matrix[,3], colorscale = 'YlGnBu', showscale=TRUE))
  fig <- fig %>% add_markers()
  fig <- fig %>% layout(scene = list(xaxis = list(title = 'X1'),
                                     yaxis = list(title = 'X2'),
                                     zaxis = list(title = 'X3')),
                        annotations = list(
                          x = 1.13,
                          y = 1.05,
                          text='Z',
                          xref = 'paper',
                          yref = 'paper',
                          showarrow = TRUE
                        ))
  fig <- fig %>% layout(title = paste('(X1,X2,X3) con p=1/3 y n= ', matrix[1,1] + matrix[1,2] + matrix[1,3]))
  fig
}
graph_multinomial(multinomial(10, 1000))
graph_multinomial(multinomial(25, 1000))
graph_multinomial(multinomial(50, 1000))

#Parte 2: gráfica de una multinomial simulada 1000 veces

correlation_x1x2 <- function(matrix) {
  fig <- plot_ly(x = matrix[,1], y = matrix[,2],
                 type='scatter', mode='markers', marker=list(color=matrix[,3], colorscale = 'YlGnBu', showscale=TRUE))
  fig <- fig %>% layout(title = paste('(X1,X2,X3) con p=1/3 y n= ', matrix[1,1] + matrix[1,2] + matrix[1,3]))
  fig
}
N <- 1000
correlation_x1x2(multinomial(100, N))
correlation_x1x2(multinomial(1000, N))
correlation_x1x2(multinomial(10000, N))




