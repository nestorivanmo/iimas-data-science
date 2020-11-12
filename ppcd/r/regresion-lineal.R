library(plot3D)
library(car)
library(rgl)

options(rgl.printRglwidget = TRUE)
plot3d(depressoin ~ fatalism + simplicity, Ginzberg, xlim=c(0,3), zlim=c(0,3))
n <- 20
x <- y <- seq(0, 3, length=n)
region <- expand.grid(x=x, y=y)
z <- matrix(0.2027 + 0.4178*region$x + 0.3795*region$y, n, n)
surface3d(x, y, z, back='line', front='line', col='red', lwd=1.5, alpha=0.4)

x <- Ginzberg$fatalism
y <- Ginzberg$simplicity
z <- Ginzberg$depression

# Hace el apilado de todas las muestras, calcula la multiplicación de las matrices
# y nos regresa los estimadores
fit <- lm(z ~ x + y)

grid_lines <- 26
x_pred <- seq(min(x), max(x), length.out=grid_lines)
y_pred <- seq(min(y), max(y), length.out=grid_lines)
xy <- expand.grid(x=x_pred, y=y_pred)
z_pred <- matrix(predict(fit, newdata=xy), nrow=grid_lines, ncol=grid_lines)

fitpoints <- predict(fit)

scatter3D(x, y, z, pch=18, cex=2, theta=20, phi=20, ticktype='detailed',
          xlab='fatalismo', ylab='simplicidad', zlab='depresión', surf=
            list(x=x_pred, y=y_pred, z=z_pred, facets=NA, fit=fitpoints),
          main='Ginzberg')





