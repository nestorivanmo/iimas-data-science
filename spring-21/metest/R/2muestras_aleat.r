#######################
# Muestras aleatorias #
#######################
# 1 Poblaci?n finita
library(mlbench)
data(PimaIndiansDiabetes2)
BD <- PimaIndiansDiabetes2

dim(BD)

head(BD)
N <- nrow(BD) # tamaño de la población
n <- 20 # tamaño de la muestra
id <- sample.int(N, n, replace = TRUE) #población finita: muestreo aleatorio simple con reemplazo

BD[id, ]

# 2 Poblaci?n infinita
# Bernoulli: es una distribución Binomial de 1 ensayo con probabilidad p
rbinom(10, 1, 0.2) # Bernoulli == Bin(1, p)
# Binomial: en este caso, estamos haciendo 20 ensayos
rbinom(10, 20, 0.3)
# Normal: (tamaño muestra, media, desviación estándar)
rnorm(10, 5, 3)
# Poisson: (pob, lambda=2)
rpois(20, 2)
# Gamma
rgamma(5, 2, 0.3)


##################
# Media muestral #
##################
x <- as.numeric(na.omit(BD$mass))
length(x)
k <- 10000
X_bar <- rep(NA, k)
n <- 300
for (i in 1:k) {
  X_bar[i] <- mean(sample(x, n, replace = TRUE))
}

# mu
mean(x)
# E(X_bar)
mean(X_bar)

diff <- abs(mean(x) - mean(X_bar))
diff

# sigma^2/n
var(x)/n
# Var(X_bar)
var(X_bar)


#        Pero adem?s tambi?n tenemos la      #
# Aprox - Distribuci?n de muestreo de X_bar  #
summary(X_bar)
a <- 24
b <- 42
d <- 2000
hist(X_bar, border = "white", xlim = c(a, b), 
     axes = FALSE)
axis(1, seq(a, b, by = 2))
axis(2, seq(0, d, by = d/10), las = 2)
abline(v = quantile(X_bar, probs = c(0.025, 0.975)), col = "red", lwd = 2)


