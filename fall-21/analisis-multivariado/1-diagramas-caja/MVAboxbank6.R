
# ---------------------------------------------------------------------
# Description:  MVAboxbank6 computes Boxplots for the diagonal
#               (Variable 6) of the genuine and forged banknotes
# ---------------------------------------------------------------------
# Usage:        -
# ---------------------------------------------------------------------
# Keywords:     boxplot
# ---------------------------------------------------------------------
# Inputs:       none
# ---------------------------------------------------------------------
# Output:       Boxplots for the diagonal (Variable 6)
#               of the genuine and forged banknotes 
# ---------------------------------------------------------------------
# 
# ---------------------------------------------------------------------

# clear variables and close windows

rm(list=ls(all=TRUE))
graphics.off()

# Load data
# The data file should be located in the same folder as this Qlet
# Set the R working directory to this directory using setwd()
# Example: setwd("C:/...")

#x    = read.table('bank2.dat');
setwd("/Users/nestorivanmo/Desktop/iimas-data-science/fall-21/analisis-multivariado/1-diagramas-caja")
x = read.table('SwissBank 1.txt')
m1 = mean(x[1:100,6])
m2 = mean(x[101:200,6])

boxplot(x[1:100,6], x[101:200,6], axes=FALSE, frame=TRUE)
axis(side=1, at=seq(1,2),label=c('GENUINE','COUNTERFEIT') )
axis(side=2, at=seq(130,150,.5), label=seq(130,150,.5))
title('Swiss Bank Notes for var 6')
lines(c(0.6, 1.4),c(m1, m1),lty="dotted",lwd=1.2)
lines(c(1.6, 2.4),c(m2, m2),lty="dotted",lwd=1.2)


find_x <- function(data, b, sup) {
  x <- 0
  S <- c()
  for (d in data) {
    if (sup) {
      if (d <= b) {
        S <- c(S, d)
      }
    } else {
      if (d >= b) {
        S <- c(S, d)
      }
    }
  }
  if (sup) {
    return(max(S))
  } else {
    return(min(S))
  }
}


find_statistics <- function(label, data) {
  print(paste("-----STATISTICS", label, '--------'))
  data <- sort(data)
  mean_data <- round(mean(data),3)
  median_data <- median(data)
  quantile_data <- quantile(data)
  Fu <- quantile_data[4]
  Fl <- quantile_data[2]
  df <- Fu - Fl
  bu <- Fu + 1.5*df
  bl <- Fl - 1.5*df
  x_sup <- find_x(data, bu, TRUE)
  x_inf <- find_x(data, bl, FALSE)
  
  print(paste("x_hat=", mean_data, "M=", median_data))
  print(paste("Fu=", Fu, "  bu=", bu))
  print(paste("Fl=", Fl, "  bl=", bl))
  print(paste("x^*=",x_sup, "   x_*=",x_inf))
  print('---------------------------')
}


xgenuine <- x[1:100,6]
xfalse <- x[101:200,6]
find_statistics('Genuine', xgenuine)
find_statistics('Counterfeit', xfalse)
