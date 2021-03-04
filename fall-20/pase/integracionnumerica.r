#----------------------------------
# Ejercicio 2: Integración numérica
#-----------------------------------
# Nestor Martinez Ostoa
# Juan Pablo Hernández
# Artemio Santiago Padilla Robles
#Benito Vicente Franco López

simpson <- function(f, a, b, n) {
  h <- (b-a)/n
  fx0 <- f(a)
  fpar <- 2 * sum(f(a + ((seq(2,n-2,2)) * h)))
  fimpar <- 4 * sum(f(a + (h * seq(1, n-1, 2))))
  fxn <- f(b)
  return ((h/3) * (fx0 + fpar + fimpar + fxn))
}

f <- function(x) { x^2 }
res <- simpson(f, 0, 1, 10)
print(res)
