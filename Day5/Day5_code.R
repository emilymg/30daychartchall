install.packages(c("moderndive", "gapminder"))
library(gapminder)
library(moderndive)

# Find the correlation between life expectancy and GDP per capita
gapminder %>% 
summarize(N = n(), r = cor(lifeExp, gdpPercap, use = "pairwise.complete.obs"))

# Create a linear regression model of life expectancy described by GDP per capita
life_model <- lm(lifeExp ~ gdpPercap, data = gapminder)

# Examine the model
get_regression_table(life_model)
get_regression_points(life_model)
get_regression_summaries(life_model)

# Plot the linear regression model
par(mfrow=c(2,2))
plot(life_model)

# Filter for two continents, plot with parallel slope lines
p_compare2 <- gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_jitter(height = 0.2, width = 0.2) +
  scale_x_log10() +
  geom_parallel_slopes(se = FALSE)

# Add plot labels
p_compare2 + labs(title = "Life Expectancy by GDP per Capita",
                  subtitle = "Africa vs. Europe, 1952-2007", 
                  caption = "Source: gapminder R package for teaching and practice; not definitive socioeconomic data.",
                  x = "GDP per Capita (international dollars)",
                  y = "Life Expectancy", 
                  color = "Continent\n")

