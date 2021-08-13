BoxStats.R <- function(){
# read data
setwd("/Users/nestorivanmo/Desktop/iimas-data-science/fall-21/analisis-multivariado/1-diagramas-caja")
x = read.table('SwissBank 1.txt')		
# sort both groups
xgenuine <- x[1:100,6]
xfalse <- x[101:200,6]
xgenuinesort <- sort(xgenuine)
xfalsesort <- sort(xfalse)
# compute median for both groups
Mgenuine <- 0.5*(xgenuinesort[50]+xgenuinesort[51])
Mfalse <- 0.5*(xfalsesort[50]+xfalsesort[51])
# define quartiles for both groups
C1g <- xgenuinesort[1:50]
C2g <- xgenuinesort[51:100]
Flg <- 0.5*(C1g[25]+C1g[26])
Fug <- 0.5*(C2g[25]+C2g[26])

C1f <- xfalsesort[1:50]
C2f <- xfalsesort[51:100]
Flf <- 0.5*(C1f[25]+C1f[26])
Fuf <- 0.5*(C2f[25]+C2f[26])
# F-dispersion for both groups
dfg <- Fug-Flg
dff <- Fuf-Flf
# outer bars for both groups
bu.g <- Fug + 1.5*dfg 
bl.g <-   Flg -1.5*dfg

bu.f <- Fuf + 1.5*dff
bl.f <-   Flf -1.5*dff 
# xl ; xu for both groups
xgu <- xgenuinesort[ xgenuinesort <= bu.g ]
xu.g <-xgu[length(xgu)]	

xgl <- xgenuinesort[ xgenuinesort >= bl.g ]
xl.g  <- xgl[1]

xfu <- xfalsesort[ xfalsesort <= bu.f ]
xu.f <-xfu[length(xfu)]

xfl <- xfalsesort[ xfalsesort >= bl.f ]
xl.f  <- xfl[1]

cat("Statistics for genuine notes","\n")
cat("Median is =",Mgenuine,"\n")
cat("Fu is =",Fug," ","Fl is" =Flg,"\n")
cat("bu is=",bu.g," ","bl is =",bl.g,"\n")
cat("x_star is =",xl.g," ","x* is =",xu.g,"\n")
cat("\n")
cat("Statistics for false notes","\n")
cat("Median is =",Mfalse,"\n")
cat("Fu is =",Fuf," ","Fl is" =Flf,"\n")
cat("bu is=",bu.f," ","bl is =",bl.f,"\n")
cat("x_star is =",xl.f," ","x* is =",xu.f,"\n")
}

BoxStats.R()