Z <- function(n, p, k) {
  bin <- rbinom(n, k, p)
  mu_k <- k*n*p
  sigma_k <- sqrt(k*n*p*(1-p))
  z <- (sum(bin) - mu_k) / sigma_k
  return (z);
}

bin_vs_norm <- function(N, n, p, k) {
  Z_vec <- c()
  for (i in 1:N) {
    Z_vec <- c(Z_vec, Z(n, p, k))
  }
  hist(Z_vec, probability = TRUE, xlab = 'X', ylab = 'Z',
       main = paste('N(0,1) ~ Bin(',n,',',p,')\n k =', k), col='#ffffff', border='black');
  sop <- seq(-6, 6, length.out=1000)
  par(new = TRUE)
  lines(sop, dnorm(sop), col='red', lwd=1.7)
}

N = 10000
bin_vs_norm(N,10, 0.5, 10)
bin_vs_norm(N,10, 0.5, 20)
bin_vs_norm(N,10, 0.5, 100)
bin_vs_norm(N,10, 0.5, 1000)
bin_vs_norm(N,10, 0.99, 10)
bin_vs_norm(N,10, 0.99, 20)
bin_vs_norm(N,10, 0.99, 100)
bin_vs_norm(N,10, 0.99, 1000)

Z(1000, 0.5, 10)
Z(1000, 0.99, 10)

