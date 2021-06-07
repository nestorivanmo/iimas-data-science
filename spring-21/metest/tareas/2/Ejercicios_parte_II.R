library(tidyverse)
library(ggplot2)
library(dplyr)

# Sección II: Preguntas prácticas

# --------------------------------- PREGUNTA 1 --------------------------------
# 1. En una cierta ciudad se asume que el número de accidentes automovilísticos 
# en un año determinado siguen una distribución Poisson. En años pasados el número 
# promedio de accidentes por año era de 15, mientras que este año fue de 10.
# ¿Esta justificada la aseveración de que la tasa de accidentes ha disminuido?
# -----------------------------------------------------------------------------

# RESPUESTA ---------------------------------
#
# X: número de accidentes automovilísticos
# X ~ Poisson(l); l <- lambda
# Nivel de significancia alfa = 0.05
#
# Hipótesis nula
# H0: l = 15
# 
# Hipótesis alternativa
# H1: l < 15 pues queremos ver si la tasa de accidentes ha disminuido
#
alfa = 0.05
lambda = 15
nueva_tasa = 10
pvalue = ppois(q=nueva_tasa, lambda=lambda)

if (pvalue > alfa) {
  paste("No se puede rechazar H0 pues el p-value (", pvalue, ") es mayor que alfa 
        (", alfa, ")")
} else {
  paste("Se rechaza H0 pues el p-value (", pvalue, ") es menor que alfa (", 
        alfa, ")")
}

# RESULTADO ---------------------------------
# No se puede rechazar H0 pues p-value > alfa
# pvalue = 0.118464411529015
# alfa = 0.05

# GRÁFICA -----------------------------------
rech <- qpois(1-alpha, lambda=15)
x <- seq(0, 30, by = 1)
df <- data.frame(x=x, y=dpois(x, 15))
ggplot(df, aes(x=x, y=y)) + geom_line(color="steelblue") + 
  geom_vline(aes(xintercept = qpois(1-alpha, lambda=10))) + 
  geom_area(data = df %>% filter(x >= rech), fill = "steelblue", alpha = 0.6) +
  geom_area(data = df %>% filter(x >= qpois(1-alpha, lambda=10)), fill = "lightpink", alpha = 0.5)


# OBSERVACIONES ----------------------------
# De la gráfica podemos observar claramente que la región de rechazo (en azul)
# se encuentra después de la región de la nueva tasa (lambda=10, en rosa) por lo
# que el resultado es consistente con el resultado previamente descrito de
# no rechazar H0


# --------------------------------- PREGUNTA 2 --------------------------------
# 2. En 1,000 volados, aparecen 560 soles y 440 águilas. ¿Es razonable el supuesto 
# de que la moneda es honesta?
# -----------------------------------------------------------------------------

# RESPUESTA ---------------------------------
# Hipótesis nula: 
# H0: p = 0.5
# Hipótesis alternativa:
# H1: p > 0.5 pues así aseguramos que la moneda no es honesta

n = 1000
alfa = 0.05
Z_alfa = qnorm(1-alfa)

p = 0.5
p_hat = 560/1000
Z = (p_hat - p) / sqrt((p*(1-p))/n)

pvalue = 1-pnorm(Z)

if (pvalue > alfa) {
  paste("No se puede rechazar H0 pues el p-value (", pvalue, ") es mayor que alfa (", alfa, ")")
} else {
  paste("Se rechaza H0 pues el p-value (", pvalue, ") es menor que alfa (", alfa, ")")
}

# RESULTADO ---------------------------------
# Se rechaza H0 pues p-value < alfa
# pvalue = 7.39011551672553e-05
# alfa = 0.05


# GRÁFICA -----------------------------------
x <- seq(-4.5, 4.5, by = 0.1)
df <- data.frame(x=x, y=dnorm(x))
rech <- Z_alfa
ggplot(df, aes(x=x, y=y)) + geom_line(color="steelblue") + 
  geom_vline(aes(xintercept = Z)) + 
  geom_area(data = df %>% filter(x >= rech), fill = "steelblue", alpha = 0.6) +
  geom_area(data = df %>% filter(x >= Z), fill = "lightpink", alpha = 0.5)

# OBSERVACIONES ----------------------------
# De la gráfica podemos observar que el valor de Z (3.97) se encuentra después
# del valor de Z_alfa (1.644) por lo que se encuentra dentro del área de rechazo.
# La gráfica es consistente con el resultado previamente obtenido con el p-value
# sobre el rechazo de H0


# --------------------------------- PREGUNTA 3 --------------------------------
# 3.1. Haz un pequeño análisis exploratorio de los datos, ¿qué puedes decir?  
# -----------------------------------------------------------------------------
getwd()
setwd("/Users/nestorivanmo/Desktop/iimas-data-science/spring-21/metest/tareas/2")
data <- read.csv('nfl.csv')
summary(data)
nrow(data)
ncol(data)


# SEABORN PAIRPLOT

# -----------------------------------------------------------------------------
# 3.2. ¿Qué variable es la que se encuentra mayormente correlacionada con y?
# Da una interpretación
# -----------------------------------------------------------------------------

correlations <- c()
y <- data$y
col_idx <- c()
most_corr <- 0
most_corr_col_idx <- -1
for (i in 2:ncol(data)) {
  corr <- cor.test(y, data[, i])$estimate
  if (abs(corr) > abs(most_corr)){
    most_corr <- corr
    most_corr_col_idx <- i
  }
  correlations <- c(correlations, corr)
  col_idx <- c(col_idx, i)
}
corr_df <- data.frame(col_idx, correlations)
corr_df <- corr_df[order(corr_df$correlations, decreasing=TRUE), ]

paste("La columna más correlacionada tiene índice", most_corr_col_idx, "con un valor de", 
      most_corr)

# RESPUESTA ---------------------------------
# La variable más correlacionada es la columna número 9, esta corresponde a
# las yardas por tierra del contrario y tiene un coeficiente de correlación de 
# -0.738 con respecto a la columna 1 (y)
#
# Interpretación: lo que nos indica que la columna más correlacionada sea la de 
# yardas por tierra del contrario es que los equipos más ganadores de la liga
# fueron los que permitieron menores yardas terrestres en contra


# -----------------------------------------------------------------------------
# 3.3. Utiliza un modelo de RLS para describir el número de juegos ganados en 
# función de la variable que encontraste en él inciso anterior (realiza la 
# estimación e inferencia para el modelo).
# -----------------------------------------------------------------------------
set.seed(100)
training_row_idx <- sample(1:nrow(data), 0.8*nrow(data))
training_data <- data[training_row_idx, ]
test_data <- data[-training_row_idx, ]

lmMod <- lm(y ~ x8, data = training_data)
pred <- predict(lmMod, test_data, interval = "prediction")

summary(lmMod)
print(lmMod)

actual_preds <- data.frame(cbind(actuals=test_data$y, predicted=pred))
correlation_acc <- cor(actual_preds)
correlation_acc
actual_preds

min_max_acc <- mean(apply(actual_preds, 1, min) / apply(actual_preds, 1, max))
min_max_acc


plot(data$x8, data$y,
     main = "Scatterplot of x vs. y",
     pch=16,
     xlab='x',
     ylab='y')
abline(lmMod, col='steelblue')


# RESPUESTA ---------------------------------
# y = -0.006779x + 21.591518


# -----------------------------------------------------------------------------
# 3.4. Interpreta “de manera útil” los coeficientes del modelo, en particular el 
# coeficiente β1. Piensa que vas a explicarle al entrenador del equipo que si en 
# un determinado juego, su equipo permite/logra.... entonces, casi seguramente 
# perderán/ganaran el juego.
# -----------------------------------------------------------------------------
coef(lmMod)












