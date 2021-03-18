library(data.table)
library(tidyverse)
library(glue)
library(plotly)

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
filterd_data <- data[data$MUN == 0]
fl <- 
  data %>%
  filter(MUN != 0 & LOC == 0)

# Tamaño de la base de datos
print(object.size(fl), units="Mb")
glue("Número de renglones: {nrow(fl)}")
glue("Número de columnas: {ncol(fl)}")


################################################################################
# 1.2 Porcentaje de población económicamente activa
################################################################################

# PEA: Población de 12 años y más económicamente activa
# P_12YMAS: Población de 12 años y más

entidades_abr <- c(
  'AGU','BJ','BJS', 'CAMP', 'CHIA', 'CHIH', 'CDMX', 'COAH', 'COL', 'DUR','GUAJ',
  'GUE', 'HID', 'JAL', 'MEX', 'MICH', 'MOR', 'NAY', 'NL', 'OAX', 'PUE', 'QUE',
  'QRO', 'SLP', 'SIN', 'SON', 'TAB', 'TAM', 'TLX', 'VER', 'YUC', 'ZAC'
)

# 1.2.1 Por entidad federativa
temp_df <- 
  data %>%
  filter(MUN == 0 & LOC == 0 & ENTIDAD != 0)

df_entidad <- data.frame(
  NOM_ENT = entidades_abr,
  PEA = as.integer(temp_df$PEA), 
  P_12YMAS = as.integer(temp_df$P_12YMAS),
  PTJ = (as.integer(temp_df$PEA)*100)/as.integer(temp_df$P_12YMAS)
)

percentages <- df_entidad[order(df_entidad$PTJ),]$PTJ

fig <- plot_ly(
  y = ~reorder(NOM_ENT, PTJ),
  x = ~PTJ,
  data = df_entidad,
  type = "bar",
  orientation='h',
  marker = list(
    color = 'rgba(50, 171, 96, 0.6)',
    line = list(color = 'rgba(50, 171, 96, 1.0)', width = 1)
  )
)
fig <- fig %>% layout(
  title = list(text='Población económicamente activa'),
  xaxis = list(title=" ", zeroline=FALSE, showline=FALSE),
  yaxis = list(title=" ", showgrid=FALSE, showline=FALSE,
               showticklabels=TRUE),
  paper_bgcolor = 'rgb(248, 248, 255)',
  plot_bgcolor = 'rgb(248, 248, 255)',
  margin = list(l = 70, r = 20, t = 40, b = 40)
)
fig <- fig %>% add_annotations(xref = 'x', yref = 'y', x = percentages*1.1+2, 
                               y = c(0:31), text = paste(round(percentages, 2), '%'), 
                               font = list(family = 'Arial', size = 12, 
                                           color = 'rgb(50, 171, 96)'), 
                               showarrow = FALSE)
fig <- fig %>% add_annotations(xref = 'paper', yref = 'paper', 
                               x = 0.2, y = -0.09,
                               text = paste('Censo de Población y Vivienda 2020 - INEGI (Accesado el 18 de Marzo 2021)'),
                               font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                               showarrow = FALSE)
fig


# 1.2.2 Por alcaldía de la CDMX
temp_df <- 
  data %>%
  filter(NOM_ENT == "Ciudad de México" & MUN != 0 & LOC == 0)
df_alcaldia <- data.frame(
  NOM_ALC = temp_df$NOM_MUN,
  PEA = as.integer(temp_df$PEA), 
  P_12YMAS = as.integer(temp_df$P_12YMAS),
  PTJ = (as.integer(temp_df$PEA)*100)/as.integer(temp_df$P_12YMAS)
)







