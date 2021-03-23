library("data.table")
library(RColorBrewer)
library(ggplot2)

# Lectura base de datos
dire <- "/Users/alejandro/Documents/Escuela/Métodos Estadísticos/Tarea 1 - Estadística Descriptiva/sisver_public.csv"
my_local <- c("entresi", "cventine", "mpioresi",
              "cvemuni", "locresi",  "cvelocal")
my_pac <- c("sexo", "edad", "seringre", "tipacien",
            "intubado", "ocupacio", "sector", "resdefin")
my_fechas <- c("fecingre", "fecinisi", "fecdef")
my_sint <- c("fiebre", "tos", "odinogia", "disnea", "irritabi",
             "diarrea", "dotoraci", "calofrios", "cefalea", "mialgias",
             "artral", "ataedoge", "rinorrea", "polipnea", "vomito",
             "dolabdo", "conjun", "cianosis", "inisubis")
my_com <- c("diabetes", "epoc", "asma", "inmusupr", "hiperten",
            "enfcardi", "obesidad", "insrencr", "tabaquis")
my_var <- c(my_local, my_pac, my_fechas, my_sint, my_com)
BD <- as.data.frame(fread(dire,
                          showProgress = F,
                          select = my_var,
                          na.strings= ""))

# 1. Porcentaje hospitalizaciones
fecha_ini = as.Date("2020-06-01")
fecha_fin = as.Date("2021-03-10")
residentes_cdmx = BD$entresi == "CIUDAD DE MEXICO"
contagiados_covid = BD$resdefin == "SARS-CoV-2"
BD1 = BD[contagiados_covid & residentes_cdmx, ]
hospitalizados = BD1[BD1$fecingre >= fecha_ini & BD1$fecingre <= fecha_fin, ]$fecingre
hospitalizados = as.Date(hospitalizados, "%Y-%m-%d")
casos = BD1[BD1$fecinisi >= fecha_ini & BD1$fecinisi <= fecha_fin, ]$fecinisi
casos = as.Date(casos, "%Y-%m-%d")
freq_casos = table(casos);
freq_hosp = table(hospitalizados);
div = freq_hosp / freq_casos;
plot(div, main='Porcentaje de hospitalizaciones por día', xlab='Fecha', 
     ylab='Porcentaje', col='#001e38')

# 2. Serie de tiempo — frollmean
roll_mean = frollmean(as.vector(div), 7)
v = 0:(length(roll_mean) / 7)
semanas = fecha_ini + 7 * v;
plot(roll_mean, type = "l", xaxt="n", yaxt="n", las = 2, col='#471337', 
     xlab = 'Fecha', ylab='Media móvil', main='Media móvil de hospitalizaciones',
     sub='Ventana de 7 días')
axis(x = roll_mean, side = 1, at = 7 * v, labels = semanas)
box()

# 3. Comorbilidades

# Limpieza

defuntos = complete.cases(BD$fecdef)
residentes_cdmx = BD$entresi == "CIUDAD DE MEXICO"
com = BD[defuntos & residentes_cdmx, c(my_com, "resdefin")];
no_nulos = complete.cases(com$resdefin);
com_limpia = com[no_nulos, ];
com_map = data.frame(sapply(com_limpia, gsub, pattern = "SE IGNORA",
                            replacement = NA_character_, fixed = TRUE));
com_map = data.frame(sapply(com_map, gsub, pattern = "SI",
                            replacement = 1, fixed = TRUE));
com_map = data.frame(sapply(com_map, gsub, pattern = "NO",
                            replacement = 0, fixed = TRUE));
com_map[, "resdefin"] = (com_map[, "resdefin"] == "SARS-CoV-2");
com_map[] <- lapply(com_map, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})

com_map[, 1:9] <- lapply(com_map[, 1:9], as.numeric)
# con_covid_y_com = colSums(com_map[com_map$resdefin, ], na.rm = TRUE)
# total_covid = con_covid_y_com["resdefin"]
# cuenta_nulos = colSums(is.na(com_map))
# cond = con_covid_y_com / (total_covid - cuenta_nulos)
# cond = cond[-length(cond)]
# cond <- sort(cond, decreasing = TRUE)

com = colSums(!is.na(com_map))
con_covid_y_com = colSums(com_map[com_map$resdefin, ], na.rm = T)
cond = con_covid_y_com / com
cond = cond[-length(cond)]
cond <- sort(cond, decreasing = TRUE)

colores <- brewer.pal(9, "PRGn")
# colores = c("#730517", "#a8216b", "#f1184c", "#f36943", "#f44560", "#f7dc66", "#44d1df", "#32a4a7", "#1e7069")
nombres = c('Hipertensión', 'Diabetes', 'Obesidad', 'Tabaquismo', 
            'In. renal', 'Enf.\ncardiovascular', 'EPOC',
            'Inmunosupresión', 'Asma')

par(mar=c(7, 4, 4, 4))

barplot(cond, main = "Probabilidad condicional fallecidos por\nCOVID-19 y comorbilidades", 
        ylab = "Probabilidad condicional",
        las = 2, col = colores, ylim=c(0, 0.4), names.arg=nombres, cex.axis=0.7,
        cex.names=0.9)

print(cond * 100)
print(cond * 100000)


BD[defuntos & residentes_cdmx, c(my_com, "resdefin")]

total = colSums(!is.na(com_map))
com = colSums(com_map, na.rm = T)
con_covid_y_com = colSums(com_map[com_map$resdefin, ], na.rm = T)
prob_fallec = sum(defuntos) / length(defuntos)
cantidad = con_covid_y_com / total * prob_fallec * 100000


