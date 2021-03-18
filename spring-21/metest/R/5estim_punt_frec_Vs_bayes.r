#############################
#    Estimación puntual     #
# Frecuentista Vs Bayesiana #
#     Estimación de  p      #
#############################
# Sea X1,..Xn, una m.a. de una Bernoulli(p)
n <- 10
p <- 0.1
x <- rbinom(n, 1, p)
x

# Visión clásica: EMV de p
x_bar <- mean(x)

# Visión Bayesiana - prior
xp <- seq(0, 1, length.out = 1000)

# 1 Prior
a <- 1
b <- 4
yp <- dbeta(xp, a, b)

# 2 Posterior
s_x <- sum(x)
a_star <- a + s_x
b_star <- n - s_x + b
ypost <- dbeta(xp, a_star, b_star)

# Prior Vs Posterior
ymax <- max(yp, ypost)*1.1
plot(xp, yp, type = "l", lwd = 2, col = "black", 
     xlim = c(-0.05, 1.05), ylim = c(0, ymax))
abline(v = c(0, 1, p), lwd = 2, lty = 2, 
       col = c("lightgray", "lightgray", "red"))

# Posterior
lines(xp, ypost, lwd = 2, col = "blue")

expx <- a_star /(a_star + b_star)
abline(v = c(x_bar, expx), lwd = 2, lty = 2, 
       col = c("black", "green"))

# Ok, esta "bonito" y ¿qué más?
moda_p <- (a_star -1) /(a_star + b_star - 2)
medi_p <- qbeta(0.5, a_star, b_star)

# y, ¿ya? intervalo de credibilidad para - p - del 0.95
ip <- qbeta(c(0.025, 0.975), a_star, b_star)
abline(v = ip, lwd = 2, lty = 2, 
       col = "purple")


