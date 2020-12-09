library(ggplot2)
theme_set(theme_minimal())
head(economics)
help('economics')

ggplot(data=economics, aes(x=date, y=pop)) +
  geom_line(color='#00AFBB', size=2)

sub <- subset(economics, date > as.Date('2006-1-1'))
ggplot(data=sub, aes(x=date, y=pop)) +
  geom_line(color='#00AFBB', size=1)

ggplot(data=economics, aes(x=date, y=pop)) +
  geom_line(aes(size=unemploy/pop), color='#FC4E07')

# Autocorrelación
acf(economics$pop, 50)
acf(economics$uempmed, 50)
acf(economics$psavert, 50)

library(tidyr)
library(dplyr)

df <- economics %>%
  select(date, psavert, uempmed) %>%
  gather(key='variable', value='value', -date)
head(df)
tail(df)

ggplot(df, aes(x=date, y=value)) + 
  geom_line(aes(color=variable), size=1) + 
  scale_color_manual(values=c('#00AFBB', '#FC4E07')) +
  theme_minimal()

ggplot(df, aes(x=date, y=value)) + 
  geom_area(aes(color=variable, fill=variable), alpha=0.5, 
            position=position_dodge(0.8)) + 
  scale_color_manual(values=c('#00AFBB', '#FC4E07')) +
  scale_fill_manual(values=c('#00AFBB', '#FC4E07')) +
  theme_minimal()

p <- ggplot(data=economics, aes(x=date, y=psavert)) + 
  geom_line(color='#00AFBB', size=1)
p
min <- as.Date("2002-1-1")
max <- NA
p + scale_x_date(limits=c(min,max))

p + scale_x_date(date_labels='%b/%Y')

p + stat_smooth(
  color='#FC4E07', fill='#FC4E07', method='loess'
)

library(TTR)
p <- ggplot(data=economics, aes(x=date, y=psavert)) + 
  geom_line(color='#00AFBB', size=1)
mm <- SMA(economics$psavert, n=8)
p + geom_line(aes(x=date, y=mm))






  
  
  