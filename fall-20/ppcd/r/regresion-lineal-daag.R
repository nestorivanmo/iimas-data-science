library(DAAG)
help(ais)
str(ais)

plot(ais$ssf, ais$pcBfat)
abline(lm(ais$pcBfat ~ ais$ssf))

str(lm(ais$pcBfat ~ ais$ssf))

b = lm(ais$pcBfat ~ ais$ssf)$coefficients
b

hombres = which(ais$sex == 'm')
points(ais$ssf[hombres], ais$pcBfat[hombres], col='red', pch=10)
points(ais$ssf[-hombres], ais$pcBfat[-hombres], col='blue', pch=16)

lm.obj = lm(ais$pcBfat ~ ais$ssf)
summary(lm.obj)

mujeres = as.integer(ais$sex == 'f')
print(mujeres)

#E[Y|x] = b0 + b1*x_i_ssf + b2x_i_mujeres

lm(ais$pcBfat ~ ais$ssf + mujeres)

# 4.1151 + 0.1579 xi_ssf si la i-ésima atleta es mujer
# 1.1307 + 0.1579 xi_ssf si la i-ésima atleta no es mujer

abline(a=1.1307, b=0.1579, col='red')
abline(a=4.1151, b=0.1579, col='blue')

boxplot(ais$pcBfat ~ ais$sport, cex.axis=0.8, ylab='Porcentaje de grasa corporal')



