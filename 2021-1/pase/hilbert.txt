#-------------------------------
# Ejercicio 1: Matriz de Hilbert
#-------------------------------
# Patricio Barrero
# Nestor Martinez Ostoa
# Pamela Ruiz
# Luis Fernando Tiburcio

hilbert <- function(n){
  H <- diag(n)
  for(i in 1:n){
    for(j in 1:n){
      H[i, j] = 1 / (i + j - 1)
    }
  }
  return(H)
}

hil_5 = hilbert(5)
print(hil_5)

n <- 20
for(i in 1:n){
  cat("Probando para ", i, "\n")
  solve(hilbert(i))
}

# La inversa de la matriz de Hilbert falla para 12
