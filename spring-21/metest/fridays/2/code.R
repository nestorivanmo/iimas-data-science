setwd('/home/nestor/Desktop/iimas-data-science/spring-21/metest/fridays/2')
library(data.table)
library(tidyr)

path <- file.path("~", "/Desktop/iimas-data-science/spring-21/metest/fridays/2", "basketball.csv")
data <- fread(path)

summary(data)

data %>%
  arrange(-REB) %>%
  select(Player, Team, REB) %>%
  head(5)

data %>%
  filter(Team %in% c('LAL', 'GSW', 'HOU')) %>%
  group_by(Team) %>%
  summarise(Media = round(mean(PTS), 1)) %>%
  as.data.frame()

