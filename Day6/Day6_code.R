# Visualizing fish encounter histories guided project, Cramer Fish Sciences 2018
# Data and tutorial: https://fishsciences.github.io/post/visualizing-fish-encounter-histories/

library(tidyverse)
library(extrafont)
library(extrafontdb)
library(RColorBrewer)

# Import the data 
if (!file.exists("fishdata.csv")) {
  download.file(
    url = 'https://github.com/Myfanwy/ReproducibleExamples/raw/master/encounterhistories/fishdata.csv',
    destfile = "fishdata.csv"
  )
}

(d <- read_csv("fishdata.csv"))

# Convert Station and TagID to factors
encounters <- mutate(d, 
                     TagID = factor(TagID),
                     Station = factor(Station, levels = unique(d$Station)))

# Look at a rough plot
ggplot(encounters) +
  geom_path(
    aes(x = Station, y = factor(value), group = TagID, color = TagID),
    show.legend = FALSE) +
  facet_wrap(~TagID, scales = "free_x")

# Custom function that takes a single fish's encounter history rows and applies 
# a unique, identifying character string
# Original function author: Bob Rudis

make_groups <- function(tag, val) {
  
  r <- rle(val)  # where 'val' is the 0/1 column
  
# for each contiguous group:
#apply flatten_chr() to the letter corresponding to the ith value of the lenghts column in r

  purrr::flatten_chr(purrr::map(1:length(r$lengths), function(i) {
    rep(LETTERS[i], r$lengths[i])
  })) -> grps  # save as new object
  
  sprintf("%s.%s", tag, grps)  # concatenate the tag and letter values into a single string.
  
  }
  
# Apply the function to all fish:
encounters <- encounters %>%
  group_by(TagID) %>%
  mutate(grp = make_groups(TagID, value)) %>%
  ungroup()

# Look at the new tag structure
filter(encounters, TagID == 4850)

# Filter out zeros to view the absence of those points on the plot
group_by(encounters, TagID) %>%
  filter(value != 0) %>%
  ungroup() -> encounters2 # Save as a new data frame

# Choose colorspace color palette, call with pal(n)
pal <- choose_palette()

# Plot 
ggplot(encounters2, aes(x = Station, y = TagID, color = Station)) +
  geom_path(aes(group = grp), size = 0.25) +
  geom_text(label = "X", size = 9, vjust = 0.6, family = "LE FISH") +
  scale_color_manual(values = pal(11)) +
  labs(title = "Encounter histories of tagged Chinook salmon smolts",
      subtitle = "Upstream to downstream",
      caption = "Data and tutorial: https://fishsciences.github.io/post/visualizing-fish-encounter-histories/") +
  theme(panel.background = element_rect(fill = "white"),
        panel.grid = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_text(hjust = 1, vjust = 1),
        legend.position = "none")
