library(plotly)

#Parte 1
H <- function(u, v, theta) {
  if (u < (1-theta)*v^(1-theta)) {
    ans <- (u/(1-theta))*v^theta
    return(ans)
  }
  if ((1-theta)*v^(1-theta) <= u && u < v^(1-theta)){
    return(v)
  }
  if (u >= v^(1-theta)){
    ans <- u^(1/(1-theta))
    return(ans)
  }
}

genGraph <- function(n=1000, theta){
  U <- c()
  V <- c()
  for(i in 1:n){
    w <- runif(1, 0, 1)
    v <- runif(1, 0, 1)
    u <- H(w, v, theta)
    U <- c(c(U), u)
    V <- c(c(V), v)
  }
  mx <- matrix(nrow = n, ncol = 2)
  mx[,1] = U
  mx[,2] = V
  fig <- plot_ly(as.data.frame(mx), x = mx[,1], y = mx[,2],
                 marker = list(
                   size = 5,
                   color = 'rgba(255, 182, 193, .9)',
                   line = list(color = 'rgba(152, 0, 0, .8)',
                               width = 2)))
  fig <- fig %>% layout(title = paste('Dispersión para theta=', theta),
                        yaxis = list(zeroline = FALSE),
                        xaxis = list(zeroline = FALSE))
  fig
  
  #plot(U, V, main=paste("Gráfica de dispersión para theta=",theta))
  #hist(U,breaks=20,probability=TRUE)
  #par(new=TRUE)
  #x = seq(0,1,length.out = 1000)
  #lines(x,dunif(x))
}
genGraph(theta=0.5)

thetas <- c(0, 0.1, 0.3, 0.85, 0.9)
for (theta in thetas){
    genGraph(theta=theta)
}



thetas <- c(0, 0.1, 0.3, 0.85, 0.9)
for (theta in thetas){
  genGraph2(theta=theta)
}





