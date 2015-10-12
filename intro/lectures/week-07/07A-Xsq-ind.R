## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)

## ----sim3, echo = FALSE--------------------------------------------------
n <- 412
p <- c(.043, .02, .125, .042, .77)
chisqs <- rep(0, 1000)
set.seed(405)

for(i in 1:1000) {
  samp <- sample(c("asian", "black", "hispanic", "other", "white"), 
       size = n, replace = TRUE, prob = p)
  obs <- c(table(samp))
  chisqs[i] <- chisq.test(obs, correct = FALSE, p = p)$statistic
}

## ---- echo=FALSE, fig.height=3-------------------------------------------
library(ggplot2)
qplot(chisqs, geom = "density") +
  stat_function(fun = dchisq, args = c(df = 4), col = "tomato")

## ------------------------------------------------------------------------
1 - pchisq(139.64, df = 4)

## ------------------------------------------------------------------------
treatment <- rep(c("acu", "sham", "trad"), c(387, 387, 388))
pain <- c(rep(c("reduc", "noreduc"), c(184, 203)),
          rep(c("reduc", "noreduc"), c(171, 216)),
          rep(c("reduc", "noreduc"), c(106, 282)))
table(pain, treatment)

## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = treatment, fill = pain, geom = "bar")

## ------------------------------------------------------------------------
chisqs <- rep(0, 1000)
set.seed(405)
for(i in 1:1000) {
  shuffled_pain <- sample(pain)
  new_tab <- table(shuffled_pain, treatment)
  chisqs[i] <- chisq.test(new_tab)$statistic
}

## ---- echo = FALSE, fig.height = 3.7-------------------------------------
qplot(chisqs, geom = "density", xlim = c(0, 40))

## ---- echo = FALSE, fig.height = 3.7-------------------------------------
tab <- table(pain, treatment)
chi_obs <- chisq.test(tab)$statistic
qplot(chisqs, geom = "density", xlim = c(0, 40)) +
  geom_vline(xintercept = chi_obs, col = "goldenrod")

## ---- echo = FALSE, fig.height = 3.7-------------------------------------
qplot(chisqs, geom = "density", xlim = c(0, 40)) +
  geom_vline(xintercept = chi_obs, col = "goldenrod") +
  stat_function(fun = dchisq, args = c(df = 2), col = "tomato")
library(oilabs)

## ------------------------------------------------------------------------
1 - pchisq(38.05, df = 2)

## ---- fig.height = 3, warning=FALSE--------------------------------------
inference(x = treatment, y = pain, est = "proportion", type = "ht", 
          method = "theoretical")

