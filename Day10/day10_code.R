install.packages("numbers")
library(numbers)
library(ggplot2)


luca <- function(n) {
  phi <- (sqrt(5) + 1)/2
  luc <- (phi^n + (1-phi)^n)
  round(luc)
}
fibo <- function(n) {
  phi <- (sqrt(5) + 1)/2
  fib <- (phi^n - (1-phi)^n) / (2*phi - 1)
  round(fib)
}

x <- fibo(1:40)
y <- luca(1:40)

df <- data.frame(x, y)

ggplot(df, aes(sin(x)^3, cos(y)^3)) +
  geom_density_2d_filled() +
  scale_fill_viridis_d(option = "inferno") +
  theme(panel.background = element_blank(), 
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        legend.position = "none")
