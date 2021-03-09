library(fastR2)
glimpse(iris)
head(iris, n=3)
tail(iris, n=3)
iris[50:51, 3:4]
sample(iris, 6)
iris$Sepal.Length

gf_point(Sepal.Length ~ Sepal.Width, data = iris)
gf_point(Sepal.Length ~ Sepal.Width | Species, data = iris)
gf_point(Sepal.Length ~ Sepal.Width, data = iris) %>%
  gf_facet_wrap(~ Species)
gf_point(Sepal.Length ~ Sepal.Width, data = iris,
         color = ~ Species, shape = ~ Species, alpha = 0.7)

tally(~ Species, data = iris)
table(iris$Species)
table(iris$Sepal.Length)
tally(iris$Sepal.Length > 6.0)
tally(cut(iris$Sepal.Length, breaks = 2:10))

gf_histogram(~ Sepal.Length, data = iris, binwidth = 0.5, boundary = 8)
gf_histogram(~ Sepal.Length, data = iris, bins = 15)
gf_dhistogram( ~ Sepal.Length, data = iris, 
               breaks = c(4, 5, 5.5, 6, 6.5, 7, 8, 10), color = "black", 
               fill = "skyblue")

gf_histogram(~ Sepal.Length, data = iris, bins = 15) %>%
  gf_facet_wrap(~ ntiles(Sepal.Width, 2, format = "interval"))

gf_histogram(~ Sepal.Length | Species, data = iris, bins = 15, binwidth = 1)
gf_histogram(~ Sepal.Length | Species, bins = 15, 
             data = iris %>% filter(Species == "virginica"))

gf_freqpoly(~ Sepal.Length, color = ~ Species, data = iris,
            binwidth = 0.5)

gf_histogram( ~ duration, data = MASS::geyser, bins = 20)

gf_dhistogram(~ Sepal.Length, data = iris, bins = 15)
gf_dhistogram(~ Sepal.Width, data = iris, bins = 15)

# Measures of central tendency
mean(~ Sepal.Length, data = iris)
mean(~ Sepal.Width, data = iris)

mean(Sepal.Length ~ Species, data = iris)
mean(Sepal.Width ~ Species, data = iris)

median(Sepal.Length ~ Species, data = iris)
median(Sepal.Width ~ Species, data = iris)

df_stats(Sepal.Length ~ Species, data = iris, mean, median)

gf_histogram(~ Sepal.Length | Species, data = iris, bins = 15)

stem(MASS::geyser$duration)
stem(iris$Sepal.Length)

mean(~ Sepal.Length | Species, data = iris)
mean(~ Sepal.Length | Species, data = iris, trim = 0.1)

# Measures of dispesion 
quantile((1:10)^2)
gf_boxplot(Sepal.Length ~ Species, data = iris)
gf_boxplot(Sepal.Length ~ Species, data = iris) %>%
  gf_refine(coord_flip())
gf_boxplot(duration ~ "", data = MASS::geyser) %>%
  gf_refine(coord_flip())

var(Sepal.Length ~ Species, data = iris)
sd(Sepal.Length ~ Species, data = iris)

inspect(iris)

# Two way tables

tally(death ~ victim, data = DeathPenalty)
tally(death ~ defendant | victim, data = DeathPenalty)

snippet("death-penalty03")


