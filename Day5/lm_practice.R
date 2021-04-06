install.packages("gapminder")
library(gapminder)
library(tidyverse)
library(broom)

options(scipen = 999, digits = 3)

# Gapminder data explore
str(gapminder)
summary(gapminder)
head(gapminder)

# Look at the density of variables to be plotted. Do they need to be scaled?
ggplot(gapminder, aes(x = gdpPercap)) +
  geom_density()
gapLog <- gapminder %>%
  mutate(log_pop = log(pop),
         log_gdp = log(gdpPercap))

# Plot log_pop and then switch to log_gdp to see the shapes of the density plots
ggplot(gapLog, aes(x = log_pop)) +
  geom_density()
head(gapLog)

# Calculate the correlation between life expectancy and GDP per capita
gapminder %>% 
  summarize(N = n(), r = cor(lifeExp, gdpPercap, use = "pairwise.complete.obs"))

# Create separate df's for Europe and Africa
gapEurope <- gapminder %>%
  filter(continent == "Europe") 

gapAfrica <- gapminder %>%
  filter(continent == "Africa")

# Create a linear regression model of life expectancy described by GDP per capita
model1 <- lm(formula = lifeExp ~ gdpPercap, gapEurope)
model2 <- lm(formula = lifeExp ~ gdpPercap, gapAfrica)

# Tidy the models into a data frame
tidy_model1 <- tidy(model1)
tidy_model2 <- tidy(model2)

tidy_combined <- bind_rows(tidy_model1, tidy_model2)

