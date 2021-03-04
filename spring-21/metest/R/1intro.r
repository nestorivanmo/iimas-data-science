# Definimos un directorio de trabajo
setwd("/Volumes/GoogleDrive/Mi unidad/MET_ESTAD/7DATOS")
# librerias necesarias
library("data.table")
# Los datos se descargan de 
# https://datos.cdmx.gob.mx/dataset/base-covid-sinave
# aquí también se descarga el diccionario de variables

####################
# Leemos los datos #
####################
# Dirección de descarga directa
my_dir_http <- "https://archivo.datos.cdmx.gob.mx/sisver_public.csv"
# Leemos las variables de la base que nos interesan y definimos valores perdidos
my_local <- c("entresi", "cventine", "mpioresi", 
              "cvemuni", "locresi",  "cvelocal",           
              "latloca", "longloca")
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
tt <- system.time(BD <- as.data.frame(fread(my_dir_http, 
                                            showProgress = TRUE, 
                                            select = my_var, 
                                            na.strings= "")))[3]
tt/60
# Tamaño
print(object.size(BD),units="Gb")

# Vistazo
dim(BD)
names(BD)       # variables de la base
head(BD, n = 3) # primeros 3 renglones

# Frecuencias básicas
table(BD$entresi) 
table(BD$resdefin)
table(BD$seringre)


# Tabla de contingencia
table(BD$entresi, BD$resdefin)

# Problema! queremos sólo personas que vivan en la CDMX


# Filtramos la base
BD1 <- BD[BD$entresi == "CIUDAD DE MEXICO" & BD$resdefin == "SARS-CoV-2", ]
names(BD1)
# Borro la base original
#rm(BD)

# Variables categóricas -> frecuencias, porcentajes
tb1 <- table(BD1$mpioresi)
tb1
round(100*tb1/sum(tb1), 1)

tb2 <- table(BD1$sector)
tb2
round(100*tb2/sum(tb2), 1)


# Creando nuevas variables
BD1$DEF <- 1*(!is.na(BD1$fecdef))
id <- BD1$DEF == 1

tbs1 <- table(BD1$seringre, BD1$DEF)
round(100*prop.table(tbs1, margin = 1), 1)


tbs2 <- table(BD1$sector, BD1$DEF)
prop.table(tbs2, margin = 1)

####################
# Gráficas básicas #
####################

# Histograma
par(mfrow = c(1, 2))
hist(BD1$edad[!id],
     main = "", border = "white",
     xlim = c(0, 120), 
     xlab = "edad", ylab = "frecuencia")
text(80, 40000, "Vivos", cex = 1.5)
box(lwd = 2)
abline(v = mean(BD1$edad[!id], na.rm = TRUE), 
       col = "red", lwd = 2)
hist(BD1$edad[id], 
     main = "", border = "white", 
     xlim = c(0, 120), xlab = "edad", ylab = "frecuencia")
abline(v = mean(BD1$edad[id]), 
       col = "red", lwd = 2)
text(80, 2500, "Fallecimientos", cex = 1.5)
box(lwd = 2)

# Diagrama de caja
par(mfrow = c(1, 1))
boxplot(edad ~ DEF, data = BD1, col = "lightgray")

##########
# Fechas #
##########
BD1$fecinisi <- as.Date(BD1$fecinisi, "%Y-%m-%d")
BD1$fecdef <- as.Date(BD1$fecdef, "%Y-%m-%d")

tb3 <- table(BD1$fecinisi)
epi_casos <- data.frame(fecha = as.Date(names(tb3)), casos = as.numeric(tb3))
tb4 <- table(BD1$fecdef)
epi_muertes <- data.frame(fecha = as.Date(names(tb4)), muertes = as.numeric(tb4))

# Curva epidémica de la CDMX
par(mfrow = c(1, 2))
plot(epi_casos, type = "l", lwd = 2, col = "red")
plot(epi_muertes, type = "l", lwd = 2, col = "red")



