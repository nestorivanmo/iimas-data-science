# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------




#read data
xdat = read.table("cars.dat")

#delete first column
x1 = xdat[, -1]
brand = xdat[,1]
x2 = x1

#define variable names
colnames(x2) = c("economy", "service", "value", "price", "design", "sporty",
  "safety", "easy")

#calculates eigenvalues and eigenvectors and sorts them by size
e<-eigen(cov(x1))
e1<-e$values

vecs <- e$vectors[,1:2] 
print(vecs)

#data multiplied by eigenvectors
x<-as.matrix(x1)%*%e$vectors 

#par(mfrow=c(2,2))
#plot of the first vs. second PC
plot(x[,1],x[,2],type="n",xlab="PC1",ylab="PC2",main="First vs. Second PC",cex.lab=1.2,cex.axis=1.2,cex.main=1.8)


#plot(q, type = "n", xlab = "First Factor", ylab = "Second Factor",
#  main = "Car Marks Data", xlim = c(-1.8, 1), ylim = c(-0.7, 0.7),
 #    cex.lab = 1.4, cex.axis = 1.4, cex.main = 1.8)
text(x[,1],x[,2], brand, cex = 1.2, xpd = NA)
#abline(v = 0)
#abline(h = 0)