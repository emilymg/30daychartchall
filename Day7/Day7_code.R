install.packages("colorRamps")
library(colorRamps)
library(tidytuesdayR)
library(tidyverse)

remotes::install_github("davidsjoberg/ggstream")
library(ggstream)

# Load tidy tuesday data
tues_15 <- tt_load("2021-04-06")

# Save separate data frames
brazil_loss <- tues_15$brazil_loss
forest <- tues_15$forest
forest_area <- tues_15$forest_area
soybean <- tues_15$soybean_use
veg_oil <- tues_15$vegetable_oil

glimpse(brazil_loss)

# Make a long df
brazil_long <- pivot_longer(brazil_loss, cols = 4:14, names_to = "cause", values_to = "value")

# Remove hyphens in $cause
brazil_long$cause <- str_replace_all(brazil_long$cause, "_", " ")

# Set color palette
pal <- colorRamps::matlab.like(11)

# Plot stream
p_brazil <- ggplot(brazil_long, aes(x = year, y = value, fill = cause)) +
  geom_stream() +
  scale_x_continuous(breaks = c(2002, 2004, 2006, 2008, 2010, 2012)) +
  scale_y_continuous("Forest Loss (hectares)", labels = scales::comma) +
  scale_fill_manual(values = pal)
# Add theme and labels
p_brazil + theme(panel.background = element_rect(fill = "grey26"),
                   panel.grid = element_blank(),
                   legend.title = element_blank()) +
  labs(title = "Causes of Deforestation in Brazil, 2001-2013",
       caption = "Data Source: Our World in Data, https://ourworldindata.org/palm-oil")
