library(ggplot2)
library(ggrepel)
library(tidyverse)

ggplot(mpg) +
  geom_bar(aes(x=class), fill='blue') +
  xlab('Tipo de auto') +
  ylab('Total')

ggplot(mpg, aes(x=displ)) + 
  geom_histogram(aes(y=..density..), binwidth = 1, fill = 'blue') + 
  geom_line(stat='density', col='gray50', size=1.5, bw='SJ') +
  xlab('Desplazamiento de motor') + 
  ylab('Densidad')

ggplot(mpg, aes(x=displ)) +
  geom_line(stat='density', col='gray50', size=1.5, bw='SJ') +
  xlab('Desplazamiento de motor') + 
  ylab('Densidad')

ggplot(data=mpg, aes(class, cty)) +
  geom_boxplot(fill='aliceblue') +
  labs(title='Box plot', 
       x = 'Tipo de auto', 
       y = 'Rendimiento')

ggplot(data=mpg, aes(class, cty)) +
  geom_violin(fill='aliceblue') +
  labs(title='Violin plot', 
       x = 'Tipo de auto', 
       y = 'Rendimiento')

#------------------------------------------------
mpg_summary <- mpg %>%
  group_by(class) %>%
  summarize(mean_cty=mean(cty),
            sd_cty = sd(cty),
            N_cty = n(),
            se = sd_cty / sqrt(N_cty),
            x_max = mean_cty + se,
            x_min = mean_cty - se
  )

mpg_summary$class  <- reorder(mpg_summary$class, mpg_summary$mean_cty)
mpg_summary

ggplot(mpg_summary, aes(mean_cty, y=class)) +
  geom_errorbar(aes(mean_cty, xmax=x_max, x_min=x_min, y=class),
                height=0, color='gray70') +
  geom_point(col='black') +
  labs(title='Barras de error',
       y='Tipo de auto', x ='Rendimiento')
  











,