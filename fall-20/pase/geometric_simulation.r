# SIMULACIÓN DE LA VARIABLE ALEATORIA GEOMÉTRICA

#--------------------------
# Primer método
#--------------------------
f <- function(p, n = 1) {
    vec <- c()
    for(i in 1:n) {
        num_iter <- 0
        while(T){
            if(runif(1) < p){
                vec <- c(vec, num_iter)
                break
            }
            num_iter <- num_iter + 1
        }
    }   
    return(vec)
}
hist(f(.09, n=10000))

#--------------------------
# Segundo método: Transformanda inversa
#--------------------------
geom <- function(x, p){
  return(p * (1 - p) ^ x);
}

geom_inverse <- function(p, y) {
  numerador <- log(1/p) + log(1-y)
  denominador <- log(1-p)
  return (numerador / denominador)
}
v <- runif(1000)
hist(geom_inverse(0.09, v))



#--------------------------
# Tercer método: Intervalos
#--------------------------
densidad <- function(x, p){
  return(p * (1 - p) ^ x);
}

P <- function(p, n = 1){
  v <- c()
  for(i in 1:n){
    x <- runif(1);
    # Vamos a truncar los intervalos a este numero maximo
    maximo <- 10 %/% p; 
    limite_superior <- 0
    for(i in 0:maximo){
      limite_inferior <- limite_superior;
      limite_superior <- limite_superior + densidad(i, p);       
      if(limite_inferior < x && x < limite_superior){
        v <- c(v, i);
        break;
      }
    } 
    if(x > limite_superior){
      v <- c(v, maximo + 1);
    }
  }
  return(v);
}
hist(P(.07, n=10000))


