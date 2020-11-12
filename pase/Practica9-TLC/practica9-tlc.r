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
  hist(Z_vec, probability = TRUE, xlab = 'Z', ylab = 'Z',
       main = paste('N(0,1) - Bin(',n,',',p,')\n k =', k));
  sop <- seq(-6, 6, length.out=1000)
  par(new = TRUE)
  lines(sop, dnorm(sop))
}

bin_vs_norm(10000, 10, 0.5, 10)
