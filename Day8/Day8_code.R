# Data:  IUCN 2020. The IUCN Red List of Threatened Species. Version 6.2.
# https://www.iucnredlist.org. Downloaded on 2021-04-09.

library(tidyverse)

# Import downloaded data
tax_by_country <- read_csv("~datasets/RLI_kingdombycountry.csv")

# sum taxonomic group columns, creates a named vector
colSums(tax_by_country[,2:11]) -> tax_by_country2

# Save object as a key-value data frame, rename cols
tax_by_country2 <- data.frame(keyName = names(tax_by_country2), value = tax_by_country2)
colnames(tax_by_country2) <- c("group", "total")

# plot the summary
p_rli <- ggplot(tax_by_country2, aes(x = total, y = group, fill = group)) +
  geom_col() +
  scale_x_continuous(breaks = c(5000, 10000, 15000, 20000, 25000)) +
  annotate("text", x = 22000, y = 2, label = "* group has not yet been
    completely assessed") 
# add theme and labels  
p_rli + 
  theme_test() +
  theme(legend.position = "none") +
    labs(title = "Number of threatened species worldwide by major taxonomic group",
         caption = "Data:  IUCN 2020. The IUCN Red List of Threatened Species. Version 6.2.
         https://www.iucnredlist.org. Downloaded on 2021-04-09.",
         x = NULL,
         y = NULL)
  