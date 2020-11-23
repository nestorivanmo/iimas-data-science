library(ggplot2)
library(RColorBrewer)

#Ejercicio 1

n <- 1000
p <- 0.5
x <- rnorm(n, p)
y <- rnorm(n, p)

df <- data.frame(x=x, y=y)
ggplot(data = df) + 
  geom_point(mapping = aes(x = x, y = y)) +
  theme_bw()
