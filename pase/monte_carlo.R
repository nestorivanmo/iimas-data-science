circle = function(x) {
  return (sqrt(1 - (x * x)))
}

monte_carlo = function(G, a, b, M) {
  s = 0
  for (i in 1:M) {
    s = s + G(a + (b - a) * runif(1, 0, 1))
  }
  return ((2/M) * s)
}

graph = function(G, M) {
  x = 1:M
  v = c()
  for (i in 1:M) {
    v = c(v, 2 * monte_carlo(G, -1, 1, i))
  }
  plot(x, v, type="l")
  abline(h=pi, col = "red")
}