library(data.table)
library(tidyverse)
library(glue)
library(plotly)
library(fastR2)
library(reshape2)
library(ggpubr)

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

# 1.2.1 Por entidad federativa
temp_df <- 
  data %>%
  filter(MUN == 0 & LOC == 0 & ENTIDAD != 0)

df_entidad <- data.frame(
  NOM_ENT = temp_df$NOM_ENT,
  PEA = as.integer(temp_df$PEA), 
  P_12YMAS = as.integer(temp_df$P_12YMAS),
  PTJ = (as.integer(temp_df$PEA)*100)/as.integer(temp_df$P_12YMAS)
)

percentages <- df_entidad[order(df_entidad$PTJ),]$PTJ

fig <- plot_ly(
  y = ~reorder(NOM_ENT, PTJ), x = ~PTJ, data = df_entidad, type = "bar", 
  orientation='h', 
  marker = list(color = "rgba(254, 53, 58, 0.9)")
)
fig <- fig %>% layout(
  title = list(text='Población económicamente activa por entidad federativa',
               x = -0.2, y = 0.98, xref = 'center', yref = 'top'),
  xaxis = list(title=" ", zeroline=FALSE, showline=FALSE),
  yaxis = list(title=" ", showgrid=FALSE, showline=FALSE,
               showticklabels=TRUE),
  margin = list(l = 70, r = 20, t = 40, b = 40)
)
fig <- fig %>% add_annotations(
    xref = 'x', yref = 'y', x = percentages+3.8,y = c(0:31), 
    text = paste(round(percentages, 2), '%'), 
    font = list(family = "Arial", size = 13, color = "rgba(245, 65, 78, 0.9)"),
    showarrow = FALSE
)
fig <- fig %>% add_annotations(
    xref = 'paper', yref = 'paper', x = 0.23, y = -0.08,
    text = "Censo de Población y Vivienda 2020 - INEGI (Accesado Marzo 2021)",
    font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'), showarrow = FALSE
)
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

percentages_alcaldia <- df_alcaldia[order(df_alcaldia$PTJ), ]$PTJ

fig <- plot_ly(
  df_alcaldia, y = ~reorder(NOM_ALC, PTJ), x = ~PTJ, type="bar", orientation="h",
  marker = list(color = "rgba(44, 179, 198, 0.9)")
)
fig <- fig %>% layout(
  barmode = "stack",
  title = list(text="Población económicamente activa por alcaldía de la CDMX"),
  xaxis = list(title=" ", zeroline=FALSE),
  yaxis = list(title=" ", zeroline=FALSE),
  margin = list(l = 0, r = 10, t = 50, b = 50)
)
fig <- fig %>% add_annotations(
  xref = 'x', yref = 'y', x = percentages_alcaldia+3.8, y=c(1:nrow(df_alcaldia)-1), 
  text=paste(round(percentages_alcaldia,2), "%"), 
  font = list(family = "Arial", size = 13, color = "rgba(44, 179, 198, 0.9)"),
  showarrow=FALSE
)
fig <- fig %>% add_annotations(
  xref = 'paper', yref = 'paper', x = 0.18, y = -0.09, 
  text = "Censo de Población y Vivienda 2020 - INEGI (Accesado Marzo 2021)",
  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
  showarrow = FALSE
)
fig

################################################################################
# 1.3.1 Porcentaje de población de 5 años y más que habla alguna lengua indígena
# 1.3.2 Porcentaje de población de 15 años y más analfabeta
################################################################################

# P5_HLI: Población de 5 años y más que habla alguna lengua indígena
# P_5YMAS: Población de 5 años y más
# P15YM_AN: Población de 15 años y más analfabeta
# P_15YMAS: Población de 15 años y más

temp_data <- data %>% filter(MUN != 0 & LOC == 0)
df_poblacion <- data.frame(
  NOM_ENT = temp_data$NOM_ENT,
  NOM_MUN = temp_data$NOM_MUN,
  P5_HLI = as.numeric(temp_data$P5_HLI),
  P_5YMAS = as.numeric(temp_data$P_5YMAS),
  PTJ_5_HLI = (as.numeric(temp_data$P5_HLI)*100)/as.numeric(temp_data$P_5YMAS),
  P15YM_AN = as.numeric(temp_data$P15YM_AN),
  P_15YMAS = as.numeric(temp_data$P_15YMAS),
  PTJ_15_AN = (as.numeric(temp_data$P15YM_AN)*100)/as.numeric(temp_data$P_15YMAS)
)

temp_data <- data %>% filter(MUN == 0 & LOC == 0 & ENTIDAD != 0)
df_poblacion_entidad <- data.frame(
  NOM_ENT = temp_data$NOM_ENT,
  NOM_MUN = "--",
  P5_HLI = as.numeric(temp_data$P5_HLI),
  P_5YMAS = as.numeric(temp_data$P_5YMAS),
  PTJ_5_HLI = (as.numeric(temp_data$P5_HLI)*100)/as.numeric(temp_data$P_5YMAS),
  P15YM_AN = as.numeric(temp_data$P15YM_AN),
  P_15YMAS = as.numeric(temp_data$P_15YMAS),
  PTJ_15_AN = (as.numeric(temp_data$P15YM_AN)*100)/as.numeric(temp_data$P_15YMAS)
)

font_color <- 'rgba(10,10,10,0.7)'
font_family <- 'verdana'
font_size <- 11

fig <- plot_ly(
  data = df_poblacion, x = ~PTJ_5_HLI, y = ~PTJ_15_AN, type = 'scatter', 
  mode = 'markers', name = 'Municipio',
  marker=list(size=4, color = 'rgba(162, 179, 190, 0.35)'),
  hoverinfo = 'text', 
  text = ~paste('Municipio: ', NOM_MUN, '<br>Entidad federativa: ', NOM_ENT, 
                '<br>Hablan Lengua indígena: ', round(PTJ_5_HLI,2), 
                '%<br>Analfabetismo: ', round(PTJ_15_AN,2), '%')
)
fig <- fig %>% add_trace(
  data = df_poblacion_entidad, x = ~PTJ_5_HLI, y = ~PTJ_15_AN, type = 'scatter',
  hoverinfo = 'text', text = ~paste('Entidad: ', NOM_ENT), name = 'Entidad federativa',
  marker=list(size=14, color = 'rgba(44, 179, 198, 0.6)')
)
fig <- fig %>% layout(
  title = list(text = "Habla de lengua indígena vs. analfabetismo",
               font = list(size=14)),
  yaxis = list(title = "Porcentaje de población de 15 años y más analfabeta"),
  xaxis = list(title = "Porcentaje de población de 5 años y más que habla alguna lengua indígena",
               type = 'log', showgrid = FALSE),
  margin = list(l = 70, r = 10, t = 50, b = 90),
  legend = list(title = list(text = '<b> Nivel federal </b>'))
)
fig <- fig %>% add_annotations(
  xref = 'paper', yref = 'paper', x = 0.5, y = -0.23, 
  text = "Censo de Población y Vivienda 2020 - INEGI (Accesado Marzo 2021)",
  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
  showarrow = FALSE
)
fig <- fig %>% add_annotations(
  xref = 'x', yref = 'y', x = 1.6, y = 17, text = "Chiapas",
  font = list(family = font_family, size = font_size, color = font_color),
  showarrow = FALSE
)
fig <- fig %>% add_annotations(
  xref = 'x', yref = 'y', x = 1.75, y = 12, text = "Oaxaca",
  font = list(family = font_family, size = font_size, color = font_color),
  showarrow = FALSE
)
fig <- fig %>% add_annotations(
  xref = 'x', yref = 'y', x = 1.18, y = 15.2, text = "Guerrero",
  font = list(family = font_family, size = font_size, color = font_color),
  showarrow = FALSE
)
fig <- fig %>% add_annotations(
  xref = 'x', yref = 'y', x = 1.61, y = 6, text = "Yucatán",
  font = list(family = font_family, size = font_size, color = font_color),
  showarrow = FALSE
)
fig

# Gráficas de correlación por entidad federativa
entidades <- unique(df_poblacion$NOM_ENT)
pearson <- c()
num_municipios <- c()
for (entidad in entidades) {
  entidad_df <- df_poblacion %>% filter(NOM_ENT == entidad)
  X <- entidad_df$PTJ_5_HLI
  Y <- entidad_df$PTJ_15_AN
  p <- cor.test(X, Y, nethod='pearson')$estimate
  pearson <- c(pearson, p)
  num_municipios <- c(num_municipios, length(entidad_df$NOM_ENT))
  if (p <= 0) {
    custom_color <- "#fe353a" 
  } else {
    custom_color <- "#2cb3c6"
  }
  print(p)
  f <- ggscatter(data = entidad_df, x="PTJ_5_HLI", y="PTJ_15_AN", add = "reg.line",
                 conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
                 color = "grey", add.params = list(color = custom_color, size = 2),
                 xlab="Porcentaje de población de 5 años y más que habla alguna lengua indígena",
                 ylab="Porcentaje de población de 15 años y más analfabeta",
                 title=paste(entidad, length(entidad_df$NOM_ENT), "municipios - Correlación de Pearson", round(p,4))) + 
    theme(plot.title = element_text(hjust = 0.5),
          plot.margin = margin(2,2,1,2,"cm"))
  show(f)
}

pearson_df <- data.frame(
  NOM_ENT = entidades,
  PEARSON = pearson,
  NUM_MUN = num_municipios
)

positive_corr_df <- pearson_df %>% filter(PEARSON > 0.85)
negative_corr_df <- pearson_df %>% filter(PEARSON < -0.1)

