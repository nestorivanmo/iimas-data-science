# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


#read data
xdat = read.table("cars.dat")

#delete first column
x1 = xdat[, -1]

# non standardized eigen
ee <- eigen(cov(x1))
ee1 <-  ee$values

 # standardizes the data matrix
x  = scale(x1)
n  = nrow(x)
 # calculates eigenvalues and eigenvectors and sorts them by size
e  = eigen(cor(x))
e1 = e$values
vec = e$vectors
ele <- diag(sqrt(e1),ncol(x))
CORR  <- vec%*%ele
q <- CORR[,1:2]

 # plot for the relative proportion of variance explained by PCs
dev.new()
plot(ee1,xlab="Index",ylab="Lambda",main="cars",cex.lab=1.2,cex.axis=1.2,cex.main=1.8)

 # plot for the correlations of the original variables with the PCs
dev.new()
ucircle = cbind(cos((0:360)/180*pi),sin((0:360)/180*pi))
plot(ucircle,type="l",lty="solid",col="blue",xlab="First PC",ylab="Second PC",main="Car marks data",cex.lab=1.2,cex.axis=1.2,cex.main=1.8,lwd=2)
abline(h=0.0,v=0.0)
label   = c("economy", "service", "value", "price", "design", "sporty",
  "safety", "easy")
text(q,label,cex=1.2)