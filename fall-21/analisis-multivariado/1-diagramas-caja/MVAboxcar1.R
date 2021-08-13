# ------------------------------------------------------------------------------
# Book:         MVA
# ------------------------------------------------------------------------------
# Quantlet:     MVAboxcar
# ------------------------------------------------------------------------------
# Description:  MVAboxcar computes Boxplots for the mileage (Variable 14) 
#               of US, Japanese and European cars from carc.txt, 
#               respectively.
# ------------------------------------------------------------------------------
# Usage:        -
# ------------------------------------------------------------------------------
# Keywords:     boxplot, quantile
# ------------------------------------------------------------------------------
# Inputs:       none
# ------------------------------------------------------------------------------
# Output:       Boxplots for the mileage (Variable 14) of US, Japanese 
#               and European cars from carc.dat,respectively.
# ------------------------------------------------------------------------------
# Example:     
# ------------------------------------------------------------------------------
# Author:       Wolfgang Haerdle, Jorge Patron, Vladimir Georgescu, 
#               Song Song
# ------------------------------------------------------------------------------

# close windows, clear variables
rm(list = ls(all = TRUE))
graphics.off()

pdf("cars.pdf")
# Load data
# The data file should be located in the same folder as this Qlet
# Set the R working directory to this directory using setwd()
# setwd("C:/...")        # set working directory if windows
# setwd("/Users/...")    # set working directory if mac
setwd("/Users/nestorivanmo/Desktop/iimas-data-science/fall-21/analisis-multivariado")
x      = read.table("carc B.txt")
k      = 0
l      = 0
m      = 0
us     = NULL
japan  = NULL
europe = NULL
M      = x[, 2]
#C      = x[, 13]
C = x[,1]


for (i in 1:dim(x)[1]){
  if (x[i, 1] == 1){
    k     = k + 1
    us[k] = x[i, 2]
  } else if (x[i, 1] == 3){
    l        = l + 1
    japan[l] = x[i, 2]
  } else if (x[i, 1] == 2){
    m         = m + 1
    europe[m] = x[i, 2]
  }
}

#write(us,file="us.txt",ncol=1)
#write(japan,file="japan.txt",ncol=1)
#write(europe,file="europe.txt",ncol=1)

m1 = mean(us)
m2 = mean(japan)
m3 = mean(europe)

boxplot(us, japan, europe, axes = FALSE, frame = TRUE)
axis(side = 1, at = seq(1, 3), label = c("US", "JAPAN", "EU") )
axis(side = 2, at = seq(0, 50, 5), label = seq(0, 50, 5))
title('Car Data')
lines(c(0.6, 1.4), c(m1, m1), lty = "dotted", lwd = 1.2)
lines(c(1.6, 2.4), c(m2, m2), lty = "dotted", lwd = 1.2)
lines(c(2.6, 3.4), c(m3, m3), lty = "dotted", lwd = 1.2)

five = quantile(x[, 2], c(.025, .25, .50, .75, .975));
#five
dev.off()