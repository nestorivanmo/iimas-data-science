# ---------------------------------------------------------------------
# Book:         MVA
# ---------------------------------------------------------------------
# Quantlet:     MVAscabank456
# ---------------------------------------------------------------------
# Description:  MVAscabank456 computes a three dimensional scatterplot
#               for X4 vs. X6 vs. X5 (lower inner frame vs. diagonal
#               vs. upper inner frame) of the of the Swiss bank notes
#               (bank2.dat).
# ---------------------------------------------------------------------
# Usage:        -
# ---------------------------------------------------------------------
# Inputs:       None
# ---------------------------------------------------------------------
# Output:       Three dimensional scatterplot for X4 vs. X6 vs. X5
#               (lower inner frame vs. diagonal vs. upper inner frame)
#               of the of the Swiss bank notes (bank2.dat).
# ---------------------------------------------------------------------
# Example:      -
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------

#rm(list=ls(all=TRUE))
#graphics.off()

# Load data
# The data file should be located in the same folder as this Qlet
# Set the R working directory to this directory using setwd()
# setwd("C:/...")        # set working directory if windows
# setwd("/Users/...")    # set working directory if mac
#x = read.table("bank2.dat")
pdf("3-dim-scatterplot-Banks-notes.pdf")
x = read.table('SwissBank 1.txt')
x456 = x[,4:6]
x1 = rep(1,100)
x2 = rep(2,100)
xx = c(x1,x2)

require(lattice)
#library(lattice)

cloud(x456[,3]~x456[,2]*x456[,1],pch=c(xx), col=c(xx), ticktype="detailed", main=expression(paste("Swiss bank notes")), screen=list(z=-90,x=-90, y=45), scales=list(arrows=FALSE,col="black",distance=1,tick.number=c(4,4,5),cex=.7, z=list(labels=round(seq(138,142,length=6))), x=list(labels=round(seq(7,14,length=6))), y=list(labels=round(seq(7,12,length=6)))	),	xlab=list(expression(paste("Lower inner frame (X4)")),rot=-10,cex=1.2), ylab=list("Upper inner frame (X5)",rot=10,cex=1.2), zlab=list("Diagonal (X6)", rot=90,cex=1.1))
	
dev.off()
	