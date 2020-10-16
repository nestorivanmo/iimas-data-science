circle = function(x) {
  return (sqrt(1 - (x * x)))
}

monte_carlo = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * runif(1, 0, 1))
  }
  return ((4/M) * s)
}

graph = function(G, M) {
  x = 1:M
  v = c()
  for (i in 1:M) {
    v = c(v, monte_carlo(G, -1, 1, i))
  }
  plot(x, v, type="l")
  abline(h=pi, col = "red")
}

times <- function(M) {
  start <- Sys.time()
  pi_mc = monte_carlo(circle, -1, 1, M)
  end <- Sys.time()
  mc <- c(pi_mc, as.numeric(end-start))
  print("Monte Carlo: ")
  print(mc)
}

circle = function(x) {
  return (sqrt(1 - (x * x)))
}

monte_carlo = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * runif(1, 0, 1))
  }
  return ((4/M) * s)
}
monte_carlo_glc = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * glc_uniform(seed(), 12345, 0, (2 ^ 31) - 1, 1))
  }
  return ((4/M) * s)
}
pi_mc = monte_carlo(circle, -1, 1, 10)
pi_glc = monte_carlo_glc(circle, -1, 1, 10)

times <- function(M) {
  start <- Sys.time()
  pi_mc = monte_carlo(circle, -1, 1, M)
  end <- Sys.time()
  mc <- c(pi_mc, as.numeric(end-start))
  print("Monte Carlo: ")
  print(mc)
  start <- Sys.time()
  pi_mc = monte_carlo_glc(circle, -1, 1, M)
  end <- Sys.time()
  mc <- c(pi_mc, as.numeric(end-start))
  print("Monte Carlo GLC: ")
  print(mc)
}
