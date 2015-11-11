## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)
library(openintro)

## ----getdata, echo = FALSE, message=FALSE--------------------------------
library(DAAG)
data(allbacks)
books <- allbacks[, c(3, 1, 4)]

## ----plotallbacks--------------------------------------------------------
qplot(x = volume, y = weight, data = books)

## ----fitm1, echo = FALSE-------------------------------------------------
m1 <- lm(weight ~ volume, data = books)

## ----plotallbackswline---------------------------------------------------
qplot(x = volume, y = weight, data = books) + 
  geom_abline(intercept = m1$coef[1], slope = m1$coef[2], col = "orchid")

## ------------------------------------------------------------------------
m1 <- lm(weight ~ volume, data = books)
summary(m1)

## ----resplot-------------------------------------------------------------
qplot(x = .fitted, y = .stdresid, data = m1)

## ----resplot2------------------------------------------------------------
qplot(sample = .stdresid, data = m1, stat = "qq") +
  geom_abline()

## ----sumtable------------------------------------------------------------
summary(m1)

## ----eval = FALSE--------------------------------------------------------
## lm(Y ~ X1 + X2 + ... + Xp, data = mydata)

## ----plotcolors----------------------------------------------------------
qplot(x = volume, y = weight, color = cover, data = books)

## ------------------------------------------------------------------------
m2 <- lm(weight ~ volume + cover, data = books)
summary(m2)

## ----echo = FALSE--------------------------------------------------------
qplot(x = volume, y = weight, color = cover, data = books) +
  geom_abline(intercept = m2$coef[1], slope = m2$coef[2], col = 2) +
  geom_abline(intercept = m2$coef[1] + m2$coef[3], slope = m2$coef[2], col = 4)

## ------------------------------------------------------------------------
summary(m2)

## ------------------------------------------------------------------------
summary(m2)$coef
qt(.025, df = nrow(books) - 3)

## ----echo = FALSE--------------------------------------------------------
qplot(x = volume, y = weight, color = cover, data = books) +
  geom_abline(intercept = m2$coef[1], slope = m2$coef[2], col = 2) +
  geom_abline(intercept = m2$coef[1] + m2$coef[3], slope = m2$coef[2], col = 4)

## ----echo = FALSE--------------------------------------------------------
qplot(x = volume, y = weight, color = cover, data = books) +
  stat_smooth(method = "lm", se = FALSE)

## ------------------------------------------------------------------------
m3 <- lm(weight ~ volume + cover + volume:cover, data = books)
summary(m3)

