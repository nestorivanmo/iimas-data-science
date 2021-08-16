library(aplpack)

setwd("/Users/nestorivanmo/Desktop/iimas-data-science/fall-21/analisis-multivariado/1-diagramas-caja")
x = read.table('SwissBank 1.txt')
xx = x[91:110]

ncolors = 15

faces(xx, nrow=4, face.type=1, scale=TRUE, col.nose=rainbow(ncolors),
      col.eyes=rainbow(ncolors, start=0.6, end=0.85), col.hair=terrain.colors(ncolors),
      col.face=heat.colors(ncolors), col.lips=rainbow(ncolors, start=0, end=1),
      col.ears=rainbow(ncolors, start=0, end=0.8), plot.faces=TRUE)