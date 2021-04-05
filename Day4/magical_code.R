# Drawing in ggplot2 with mathematics, using the Golden Angle.

# No external dataset needed! Change size, shape, number of points, colors, or the math functions.

library(ggplot2)
options(repr.plot.width = 4, repr.plot.height = 4)

points <- 5000
angle <- pi * (3 - sqrt(5))
t <- (1:points) * angle
x <- sin(t)
y <- cos(t)
df <- data.frame(t, x, y)
p_magic <- ggplot(df, aes(x*t, y*t)) +
  geom_point(size = 5, shape =21, alpha = 0.5, color = "darkblue", fill = "cornsilk", stroke = 1)
p_magic + theme(panel.background = element_rect(fill = "darkslategray3"),
          axis.text = element_blank(),
          axis.title = element_blank(),
          axis.ticks = element_blank(),
          panel.grid = element_blank(),
          legend.position = "none")

