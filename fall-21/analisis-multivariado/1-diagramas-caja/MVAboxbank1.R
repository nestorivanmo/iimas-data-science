# -------------------------------------------------------------------------
# Book:         MVA
# -------------------------------------------------------------------------
# Quantlet:     MVAboxbank1
# -------------------------------------------------------------------------
# Description:  MVAboxbank1 computes Boxplots for the length (Variable 1)
#               of the genuine and forged banknotes from bank2.dat,
#               respectively.
# -------------------------------------------------------------------------
# Usage:        -
# ---------------------------------------------------------------------
# Keywords:     boxplot
# -------------------------------------------------------------------------
# Inputs:       none
# -------------------------------------------------------------------------
# Output:       Boxplots for the length (Variable 1) of the genuine and
#               forged banknotes from bank2.dat, respectively.
# -------------------------------------------------------------------------
# Example:
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------

# clear variables and close windows

rm(list = ls(all = TRUE))
graphics.off()

# Load data
# The data file should be located in the same folder as this Qlet
# Set the R working directory to this directory using setwd()
# Example: setwd("C:/...")
#x = read.table('bank2.dat');
setwd("/Users/nestorivanmo/Desktop/iimas-data-science/fall-21/analisis-multivariado/1-diagramas-caja")
x = read.table('SwissBank 1.txt')
m1 = mean(x[1:100, 1])
m2 = mean(x[101:200, 1])


boxplot(x[1:100, 1], x[101:200, 1], axes = FALSE, frame = TRUE)
axis(side = 1, at = seq(1, 2), label = c('GENUINE', 'COUNTERFEIT'))
axis(side = 2, at = seq(200, 250, .5), label = seq(200, 250, .5))
title('Swiss Bank Notes for var 1')
lines(c(0.6, 1.4), c(m1, m1),lty = "dotted",lwd = 1.2)
lines(c(1.6, 2.4), c(m2, m2),lty = "dotted",lwd = 1.2)