#---------------------
# Simulación de una VA
#---------------------
f <- function(p, n = 1) {
    vec <- c()
    for(i in 1:n) {
        num_iter <- 0
        while(T){
            if(runif(1, 0, 1) < p){
                vec <- c(vec, num_iter)
                break
            }
            num_iter <- num_iter + 1
        }
    }   
    return(vec)
}

#----------------------
# Simulación geométrica
#----------------------
# P(X=x) = p(1-p)^(x-1)
p <- function(p, x) {
  return (p*((1-p)**(x-1)))
}
r <- p(10/12, seq(1, 12))
r


#---------------------
# Código para graficar
#---------------------
graph <- function(n, p) {
  valores_aleatorios <- f(p, n)
  cuenta <- table(valores_aleatorios)
  plot(cuenta)  
}
graph(100, 0.4)