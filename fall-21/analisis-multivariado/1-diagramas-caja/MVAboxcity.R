# ---------------------------------------------------------------------
# Book:         MVA
# ---------------------------------------------------------------------
# Quantlet:     MVAboxcity
# ---------------------------------------------------------------------
# Description:  MVAboxcity computes the Five Number Summary and a Boxplot 
#               for the dataset cities.txt. 
# ---------------------------------------------------------------------
# Usage:        -
# ---------------------------------------------------------------------
# Inputs:       none
# ---------------------------------------------------------------------
# Output:       Five Number Summary and a Boxplot for the dataset 
#               cities.txt. 
# ---------------------------------------------------------------------
# Example:     
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------

# close windows and clear variables
rm(list=ls(all=TRUE))
graphics.off()

# Load data
# The data file should be located in the same folder as this Qlet
# Set the R working directory to this directory using setwd()
# setwd("C:/...")        # set working directory if windows
# setwd("/Users/...")    # set working directory if mac
pdf("cities.pdf")
x  = read.table('cities.txt');
m1 = mean(as.matrix(x));

# Plot box plot

boxplot(x,xlab='World Cities', ylab="Values")
lines(c(0.8, 1.2),c(m1, m1),col="black",lty="dotted",lwd=1.2)
title('Boxplot')

# Five Number Summary
# R "quantile" function uses a different algorithm to calculate the sample quantiles than in the MVA book
#Therefore, the values using Matlab could differ from the Book values, but
#the difference is not great, and should not be significant.
#Easiest way to calculate Five Number Summary is
#quantile(population,[.025 .25 .50 .75 .975])
five = quantile(x[,1],c(.025, .25, .50, .75, .975));

#Display results
print('Five number summary, in millions')
print(five/100)
dev.off()