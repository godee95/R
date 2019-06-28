install.packages("tidyverse")

library(tidyverse)
mtcars
ggplot(mtcars) + geom_point(mapping = aes(x=mpg, y=disp))

ggplot(mtcars) + geom_bar(mapping = aes(x = gear))

ggplot(mtcars) + geom_histogram(mapping = aes(x = qsec), binwidth = 2)

p <- ggplot(mtcars, mapping = aes(x = mpg, y = disp)) + geom_point()
p + geom_line() + geom_smooth(method = "lm", formula = y ~ poly(x,2))

ggplot(mtcars, mapping = aes(x=disp, y=mpg,
                             color = factor(am, levels = c(0,1),
                                            labels = c("Automatic", "Manual"))))+
  scale_color_manual(values = c("blue","yellow")) +
  geom_point() +
  labs(color = "Transmission")

