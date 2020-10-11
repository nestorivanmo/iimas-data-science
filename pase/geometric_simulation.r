f <- function(p, n = 1) {
    vec <- c()
    for(i in 1:n) {
        num_exp <- 0
        while(T){
            if(runif(1, 0, 1) < p){
                vec <- c(vec, num_exp)
                break
            }
            num_exp <- num_exp + 1
        }
    }   
    return(vec)
}
f(0.8)
f(0.8, 100)

graph <- function(n, p) {
  valores_aleatorios <- f(p, n)
  cuenta <- table(valores_aleatorios)
  plot(cuenta)  
}
graph(100, 0.4)