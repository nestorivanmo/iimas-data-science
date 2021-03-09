a <- 3
b <- 1

xx <- seq(0, 10, length.out = 500)
y <- dgamma(x, a, b)

plot(xx, y, type = "l", lwd = 2, col = "blue")

n <- 100
x <- rgamma(n, a, b)

hist(x, breaks = "FD", probability = T, border = "white")
box(lwd = 1)

x_bar <- mean(x)
sigma2_hat <- 1/n*sum((x - x_bar)^2)

s2 <- var(x)
((n-1)/n)*s2

# Estimadores por el método de momentos
a_tilde <- (x_bar^2)/(sigma2_hat)
b_tilde <- x_bar / sigma2_hat


# Evaluo ajuste "a ojo"
xx <- seq(0, 10, length.out = 500)
y <- dgamma(xx, a_tilde, b_tilde)
hist(x, breaks = "FD", probability = T, border = "white")
box(lwd = 1)



