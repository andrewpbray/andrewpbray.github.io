## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)

## ----tdist, echo = FALSE, fig.height=4.5---------------------------------
ggplot(NULL, aes(x=x, colour = distribution)) +
  stat_function(data = data.frame(x = -4:4, distribution= factor(1)), fun = dt, args = c(df = 1)) +
  stat_function(data = data.frame(x = -4:4, distribution = factor(2)), fun = dt, args = c(df = 2)) +
  stat_function(data = data.frame(x = -4:4, distribution = factor(3)), fun = dt, args = c(df = 5)) +
  stat_function(data = data.frame(x = -4:4, distribution = factor(4)), fun = dnorm) +
  scale_colour_manual(values = c("orangered4", "orangered2", "orangered", "goldenrod"),
                      labels = c("df = 1", "df = 2", "df = 5", "normal"))

## ------------------------------------------------------------------------
pt(-2.2, df = 18)
qt(.025, df = 18)

