install.packages("colorRamps")
library(colorRamps)
library(tidytuesdayR)
library(tidyverse)

remotes::install_github("davidsjoberg/ggstream")
library(ggstream)

# Load tidy tuesday data
tues_15 <- tt_load("2021-04-06")

# Save Brazil data
brazil_loss <- tues_15$brazil_loss
glimpse(brazil_loss)

# Make a long df
brazil_long <- pivot_longer(brazil_loss, cols = 4:14, names_to = "cause", values_to = "value")

# Remove hyphens in $cause
brazil_long$cause <- str_replace_all(brazil_long$cause, "_", " ")

# Set color palette
pal <- colorRamps::matlab.like(11)

# Plot stream
p_brazil <- ggplot(brazil_long, aes(x = year, y = value, fill = cause)) +
  geom_stream(extra_span = 0.01, type = "proportional") +
  scale_x_continuous(breaks = c(2002, 2004, 2006, 2008, 2010, 2012)) +
  scale_fill_manual(values = pal)
# Add theme and labels
p_brazil + 
  theme(panel.background = element_rect(fill = "white"),
                   panel.grid = element_blank(),
                   legend.title = element_blank()) +
  labs(title = "Causes of Deforestation in Brazil, 2001-2013",
       caption = "Data Source: #tidytuesday 2021 week 15, Our World in Data, https://ourworldindata.org/palm-oil",
       x = NULL,
       y = "Proportion of total forest loss")

