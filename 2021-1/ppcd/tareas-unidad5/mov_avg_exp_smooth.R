#**Integrantes**:
#* Adolfo Patricio Barrero Olguín - 418046100
#* Néstor Iván Martínez Ostoa - 315618648
#* Jorge Alejandro Ramírez Bondi - 314634825

#---------------------------------------------
#---------------MOVING AVERAGE----------------
#---------------------------------------------
data_ads <- read.csv('https://bit.ly/2l9BdhA')
moving_average <- function(serie, n){
  max <- length(serie) - n;
  m <- mean(serie[-(1:max)]);
  return(m);    
}
moving_average(data_ads$Ads, 24)

#---------------------------------------------
#-------------EXPONENTIAL SMOOTHING-----------
#---------------------------------------------
exponential_smoothing <- function(serie, alpha){
    result <- c(serie[1]);
    for(n in 2:length(serie)){
        op <- alpha * serie[n] + (1 - alpha) * result[n-1];
        result <- c(result, op);
    }
    return(result);
}

plot_exponential_smoothing <- function(serie, alphas) {
    x <- 1:length(serie);
    plot(x, serie, type="l", main="Suavizado Exponencial", 
            xlab="Tiempo", ylab="Anuncios por hora", col = "red");
    grid();
    colores <- c("blue", "green")
    for (i in 1:2) {
        y <- exponential_smoothing(serie, alphas[i]);
        lines(x, y, type="l", col = colores[i]);
    }
}
serie <- data_ads$Ads;
alphas <- c(.3, .5);
plot_exponential_smoothing(serie, alphas);

#---------------------------------------------
#-------Mean Absolute Percentage Error--------
#---------------------------------------------
mean_absolute_percentage_error <- function(y_true, y_pred) {
    mean_abs_percentage_error <- mean(abs((y_true - y_pred) / y_true)) * 100
    return(mean_abs_percentage_error)
}
