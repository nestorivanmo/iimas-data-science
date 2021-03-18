# Máxima verosimilitud por métodos numéricos
library(fitdistrplus)
library(plotly)


# Gamma
n <- 100
x <- rgamma(n, 2, 6)

# Log verosimilutud de la distribución gamma
log_like_gamma <- function(s_logx, s_x, a, bx){
  n*a*log(b) - n*lgamma(a) + (a-1)*s_logx - b*s_x
} 
s_x <- sum(x)
s_logx <- sum(log(x))

k <- 500
ax <- seq(0.01, 8, length.out = k)
by <-  seq(0.01, 8, length.out = k)
log_like <- array(NA, c(k, k))
for(i in 1:k){
  for(j in 1:k){
    log_like[i,j] <- log_like_gamma(s_logx, s_x, ax[i], by[j])
  }
}

f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)
yy <- list(
  title = "a",
  titlefont = f
)
xx <- list(
  title = "b",
  titlefont = f
)
plot_ly(x = ax,
        y = by,
        z = log_like,
        type = "contour") %>% layout(xaxis = xx, yaxis = yy)



est_par <- mledist(x, "gamma", 
                   start = list(shape = 1, rate = 1))
est_par$estimate

# a <- 2
# b <- 6


# Beta
n <- 100
x <- rbeta(n, 2, 2)
est_par <- mledist(x, "beta", 
                   start = list(shape1 = 1, shape2 = 1))
est_par$estimate


# Cauchy
n <- 100
x <- rcauchy(n, 10, 0.5)
est_par <- mledist(x, "cauchy", 
                   start = list(location = 0, scale = 1))
est_par$estimate

