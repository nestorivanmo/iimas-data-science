library(tidyverse)
library(ggplot2)
library(dplyr)

# Sección II: Preguntas prácticas

# ---------------------------------- PREGUNTA ---------------------------------
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
  paste("No se puede rechazar H0 pues el p-value (", pvalue, ") es mayor que alfa (", alfa, ")")
} else {
  paste("Se rechaza H0 pues el p-value (", pvalue, ") es menor que alfa (", alfa, ")")
}

# RESULTADO ---------------------------------
# No se puede rechazar H0 pues p-value > alfa
# pvalue = 0.118464411529015
# alfa = 0.05



# ---------------------------------- PREGUNTA ---------------------------------
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

