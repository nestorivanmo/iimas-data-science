library(tidyverse)
library(ggplot2)
library(dplyr)

# 8.1-1 Prueba sobre una media

# a)
# IQ ~ N(mu,100)
# H0: mu=110 vs H1:mu > 110

n <- 16
x_bar <- 113.5
sigma <- sqrt(100)
alpha <- 0.05
  
# Estadistica t = (x_bar - 110) / (sigma/sqrt(n))
t_x <- (x_bar - 110) / (sigma / sqrt(n))
t_x

qnorm(0.95)

# p-value P[X_bar >= 113.5 | mu = 110] => P[Z >= t_x]
p_value <- 1 - pnorm(t_x)
p_value > alpha # Aceptamos H0


# b)
# Área de Rechazo
rech <- qnorm(1-alpha)
x <- seq(-3, 3, by = 0.1)
df <- data.frame(x=x, y=dnorm(x))
ggplot(df, aes(x=x, y=y)) + geom_line(color="steelblue") + 
  geom_vline(aes(xintercept = t_x)) + 
  geom_area(data = df %>% filter(x >= rech), fill = "steelblue", alpha = 0.6) +
  geom_area(data = df %>% filter(x >= t_x), fill = "lightpink", alpha = 0.5)


alpha <- 0.01
rech <- qnorm(1-alpha)
ggplot(df, aes(x=x, y=y)) + geom_line(color="steelblue") + 
  geom_vline(aes(xintercept = t_x)) + 
  geom_area(data = df %>% filter(x >= rech), fill = "steelblue", alpha = 0.6) +
  geom_area(data = df %>% filter(x >= t_x), fill = "lightpink", alpha = 0.8)

# 8.1-2

n <- 25
sigma <- 0.2
alpha <- 0.025 

# t <- (x_bar - 13)/(0.2/sqrt(25))
# Rechazamos cuando t <= qnorm(alpha)
x_bar <- 12.9
t <- (x_bar - 13)/(sigma / sqrt(n))
t
t <= qnorm(alpha)

# P[X_bar <= 12.9 | mu = 13] = P[Z <= t]
p_value <- pnorm(t)
p_value

# Rechazamos H0

rech <- qnorm(alpha)
ggplot(df, aes(x=x, y=y)) + geom_line(color="steelblue") + 
  geom_vline(aes(xintercept = t)) + 
  geom_area(data = df %>% filter(x <= rech), fill = "steelblue", alpha = 0.6) +
  geom_area(data = df %>% filter(x <= t), fill = "lightpink", alpha = 0.8)

# 8.1-4
# X ~ N(mu, sigma^2), grosor chicles hierbabuena
# H0: mu = 7.5 vs H1 mu != 7.5
n <- 10
alpha <- 0.05

# Estadístcia de prueba es t = (X_bar - mu)/(s/sqrt(n)) ~ t(n-1)
rech <- c(qt(alpha/2, df=n-1), qt(1-alpha/2, df=n-1))
x <- seq(-3.5, 2.5, by=0.1)
df <- data.frame(x=x, y=dt(x, df=n-1))
ggplot(df, aes(x,y)) +
  geom_line(color="steelblue") + 
  geom_area(data = df %>% filter(x<=rech[1]), fill="lightpink", alpha=0.8) +
  geom_area(data = df %>% filter(x>=rech[2]), fill="lightpink", alpha=0.8)

# b) 
s <- c(7.65, 7.6, 7.65, 7.7, 7.55, 7.55, 7.4, 7.4, 7.5, 7.5)
t <- (mean(s) - 7.5)/(sd(s) / sqrt(n))

t <= rech[1]
t >= rech[2]

ggplot(df, aes(x,y)) +
  geom_line(color="steelblue") + 
  geom_area(data = df %>% filter(x<=rech[1]), fill="lightpink", alpha=0.8) +
  geom_area(data = df %>% filter(x>=rech[2]), fill="lightpink", alpha=0.8) +
  geom_vline(aes(xintercept = t))

# P[|T| >= t] donde T es la distribución de nuestra estadística de prueba
p_value <- 2*(1-pt(t, df = n-1))
p_value

# Aceptamos H0


# ---------------------------------------
# Creamos nuestra propia prueba : "Pelotas de tenis"
# H0: p1 = p2 = p3 = p4 = 1/4 vs. H1: p's siguen otra distribución

n <- 1000
df <- data.frame(X1 = 278, X2 = 276, X3 = 229, X4 = 217)

R <- diff(range(df[1,]))
df$R <- R
t <- R

# p-value = P[R >= 61]
# Pero sabemos que si H0 la asumimos cierta, las pelotas que caen siguen una
# distribución multinomials

probs <- rep(1/4, 4)
SimMultinom <- rmultinom(100000, size = 1000, prob = probs)
SimMultinom <- SimMultinom %>% t() %>% data.frame()

stat <- function(x) {
  diff(range(x))
}

SimMultinom$R <- apply(SimMultinom, 1, stat)

datos <- rbind(df, SimMultinom)

b <- nclass.Sturges(datos$R)
ggplot(datos, aes(x = R)) +
  geom_histogram(bings = b, fill = "steelblue", alpha = 0.5, col = "steelblue") + 
  geom_vline(aes(xintercept = t))

quantile(datos$R, probs = 0.95)

p <- ecdf(datos$R)
plot(p)

# p-value = P[R>=61] = 1 - P[R < 61] = 1 - P[R <= 60]
1-p(R-1)

# Rechazamos H0

library(mosaic)
df$R <- SimMultinom$R <- NULL
statTally(df, SimMultinom, stat, xlab = "Estadística de prueba (rango)")

# Comportamiento p-value
# p-value cuando H0 es certa 
library(ggformula)
pvals <- do(10000) * {
  t.test(rnorm(25), mu=0) %>% pval()
}

ggplot(pvals, aes(x = p.value)) + 
  geom_histogram(binwidth = 0.02)

gf_qq(~p.value, data = pvals, distribution = qunif, geom = "line")

# p-value cuando H0 es falsa -> p values mucho más chicos
pvals <- do(10000) * {
  t.test(rnorm(25, mean = 0.5, sd = 1), mu=0) %>% pval()
}

ggplot(pvals, aes(x = p.value)) + 
  geom_histogram(binwidth = 0.01)

gf_qq(~p.value, data = pvals, distribution = qunif, geom = "line")



