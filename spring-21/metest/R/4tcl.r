##############################
# Teorema Central de Límite  #
##############################

# 1- Binomial(n0, p)
#
# - p cerca de 0 o 1, mala idea
# - n menor a 30, mala idea
n0 <- 1    # número de ensayos Bernoulli, n0 = 1 Bernoulli(p)
p <- 0.1   # probabilidad de éxito
n <- 10   # tamaño de muestra
m <- 10000 # simulaciones

ex <- n0*p 
sv <- sqrt(n0*p*(1-p)/n)

x_bar <- rep(NA, m)
for(t in 1:m){
  x_bar[t] <- mean(rbinom(n, n0, p)) 
}

# Si X ~ Bin(n0, p) , E(X) = n0*p y Var(X) = n0*p*(1-p)
a <- -1.1#min(x_bar)*0.99
b <- 1.1#max(x_bar)*1.01
hist(x_bar, main = "", border = "gray", 
     breaks  = seq(a, b, length.out = 40), 
     probability = TRUE, xlim = c(a, b))
xx <- seq(a, b, length.out = 1000)
yy <- dnorm(xx, ex, sv)
lines(xx, yy, col = "red", lwd = 2)
abline(v = c(0,1), lwd = 2, lty = 2, col = "blue")
box(lwd = 2)


# 2- Gamma(a, b)
# -  al menor a dos mala idea
# - n menor a 30, mala idea
al <- 0.1
be <- 2
n <- 100    # tamaño de muestra
m <- 10000 # simulaciones

ex <- al/be 
sv <- sqrt(al/(be*be*n))

xx <- seq(0, 1, length.out = 1000)
yy <- dgamma(xx, al, be)
plot(xx, yy, type = "l", lwd = 2)

x_bar <- rep(NA, m)
for(t in 1:m){
  x_bar[t] <- mean(rgamma(n, al, be)) 
}

# Si X ~ Gamma(a, b) , E(X) = a/b y Var(X) = a/b^2
a <- 0#min(x_bar)*0.99
b <- max(x_bar)*1.01
hist(x_bar, main = "", border = "gray", 
     breaks  = seq(a, b, length.out = 20), 
     probability = TRUE, xlim = c(a, b))
xx <- seq(a, b, length.out = 1000)
yy <- dnorm(xx, ex, sv)
lines(xx, yy, col = "red", lwd = 2)
abline(v = 0, lwd = 2, lty = 2, col = "blue")
box(lwd = 2)



# 3- Beta(a, b)
# -  al menor a dos mala idea
# - n menor a 30, mala idea
al <- 3
be <- 2
n <- 10    # tamaño de muestra
m <- 10000 # simulaciones

ex <- al/(al + be)
sv <- sqrt(al*be/(n*(al + be + 1)*((al + be)^2)))

xx <- seq(0, 1, length.out = 1000)
yy <- dbeta(xx, al, be)
plot(xx, yy, type = "l", lwd = 2)

x_bar <- rep(NA, m)
for(t in 1:m){
  x_bar[t] <- mean(rbeta(n, al, be)) 
}

# Si X ~ Beta(a, b) , 
a <- min(x_bar)*0.99
b <- max(x_bar)*1.01
hist(x_bar, main = "", border = "white", 
     breaks  = seq(a, b, length.out = 20), 
     probability = TRUE, xlim = c(a, b))
xx <- seq(a, b, length.out = 1000)
yy <- dnorm(xx, ex, sv)
lines(xx, yy, col = "red", lwd = 2)
abline(v = 0, lwd = 2, lty = 2, col = "blue")
box(lwd = 2)

# Normal ---- Distribucion exacta! NO NECESITAMOS EL TEOREMA CENTRAL DEL LÍMITE
m <- 10000
n <- 2
mu <- 0
sigma <- 1
ex <- 0
sv <- sqrt(1/n)

x_bar <- rep(NA, m)
for(t in 1:m){
  x_bar[t] <- mean(rnorm(n, mu, sigma)) 
}

a <- min(x_bar) - 0.1
b <- max(x_bar) + 0.1
hist(x_bar, main = "", border = "gray", 
     breaks  = seq(a, b, length.out = 20), 
     probability = TRUE, xlim = c(a, b))
xx <- seq(a, b, length.out = 1000)
yy <- dnorm(xx, ex, sv)
lines(xx, yy, col = "red", lwd = 2)
box(lwd = 2)
