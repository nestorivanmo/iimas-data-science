library(data.table)
library(tidyverse)

################################################################################
# 0. Carga de datos
################################################################################
setwd("~/Desktop/iimas-data-science/spring-21/metest/tareas/1")
getwd()
path <- file.path("./dataset", "conjunto_de_datos", 
                  "conjunto_de_datos_iter_00_cpv2020.csv")
data <- fread(path)

################################################################################
# 1.1 Base de datos a nivel municipio
################################################################################
ncol(data)
nrow(data)
length(unique(data$NOM_MUN))

filterd_data <- data[data$MUN == 0,]
class(filterd_data)

fl <- 
  data %>%
  filter(MUN != 0 & LOC == 0)

length(unique(fl$NOM_MUN))

################################################################################
# 1.2 Porcentaje de población económicamente activa
################################################################################
length(unique(data$NOM_MUN))
















