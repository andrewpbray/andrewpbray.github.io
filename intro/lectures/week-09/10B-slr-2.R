## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)
library(openintro)

## ----find-b1, echo = FALSE-----------------------------------------------
poverty <- read.delim("../../other/poverty.txt", header = TRUE)
library(ggplot2)
(p1 <- ggplot(poverty, aes(Poverty, Graduates)) + 
  xlim(0, 20) +
  ylim(75, 96) +
  geom_point())

## ----find-b1-2, echo = FALSE---------------------------------------------
m1 <- lm(Graduates ~ Poverty, data = poverty)
(p2 <- p1 + 
   geom_abline(intercept = 93, slope = m1$coef[2], col = "goldenrod") +
   annotate("text", x = 3, y = 87, label = paste("slope = ", round(m1$coef[2], 2))))

## ----find-b02, echo = FALSE----------------------------------------------
x_bar <- mean(poverty$Poverty)
y_bar <- mean(poverty$Graduates)
p1 + 
  geom_vline(xintercept = mean(poverty$Poverty), 
                col = "steelblue",
                lty = 2) +
  geom_hline(yintercept = mean(poverty$Graduates), 
                col = "steelblue",
                lty = 2) + 
  geom_abline(intercept = m1$coef[1], slope = m1$coef[2], col = "goldenrod") +
  annotate("text", x = 3, y = 91, label = paste("slope = ", round(m1$coef[2], 2))) +
  annotate("text", x = 14, y = 96, label = paste("x-bar = ", round(x_bar, 2))) +
  annotate("text", x = 19, y = 85, label = paste("y-bar = ", round(y_bar, 2)))

## ----fitlm---------------------------------------------------------------
m1 <- lm(Graduates ~ Poverty, data = poverty)
summary(m1)

## ----showlm--------------------------------------------------------------
attributes(m1)
m1$coef
m1$fit

## ------------------------------------------------------------------------
m1$coef[2]

## ------------------------------------------------------------------------
m1$coef[1]

## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
# this chunk sets the chunk options for the whole document
require(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)

## ---- echo=FALSE---------------------------------------------------------
library(openintro)
COL <- c('#55000088','#225588')
set.seed(238)
n <- c(50, 25, 78, 55, 70, 150)
m <- c(12, -4, 7, -19, 0, 40)
xr <- list(0.3, c(2), 1.42, runif(4,1.45,1.55), 5.78, -0.6)
yr <- list(-4, c(-8), 19, c(-17,-20,-21,-19), 12, -23.2)
i <- 1
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)

## ---- echo=FALSE---------------------------------------------------------
i <- 2
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)

## ---- echo=FALSE---------------------------------------------------------
i <- 3
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)

## ---- echo=FALSE---------------------------------------------------------
i <- 5
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)

## ---- echo=FALSE---------------------------------------------------------
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x[1:70], y[1:70], col = COL[2], lCol = COL[1], lwd = 3, xlim = range(x), ylim = range(y))

## ---- echo=FALSE---------------------------------------------------------
library(faraway)
data(star)
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")

## ---- echo=FALSE---------------------------------------------------------
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")
abline(lm(light~temp, data = star), col = "darkgreen", lwd = 3, lty = 2)
legend("top", inset = 0.05, "w/ outliers", lty = 2, lwd = 2, col = "darkgreen")

## ---- echo=FALSE---------------------------------------------------------
par(mar=c(4,4,2,1), las=1, mgp=c(2.5,0.7,0), cex.lab = 1.25, cex.axis = 1.25)
plot(light ~ temp, data = star, pch=19, col=COL[2], xlab = "log(temp)", ylab = "log(light intensity)")
abline(lm(light~temp, data = star), col = "darkgreen", lwd = 3, lty = 2)
abline(lm(light[temp>4]~temp[temp>4], data = star), col = COL[1], lwd = 3)
legend("top", inset = 0.05, c("w/ outliers","w/o outliers"), lty = c(2,1), lwd = c(2,3), col = c("darkgreen",COL[1]))

## ---- echo=FALSE---------------------------------------------------------
set.seed(12)
i <- 2
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
y <- y - mean(y)
par(mar=c(4,4,1,1), las=1, mgp=c(2.5,0.5,0), cex.lab = 1.25, cex.axis = 1.25, mfrow = c(2,1))
lmPlot(x, y, col = COL[2], lCol = COL[1], lwd = 3)

## ---- echo=FALSE, fig.height=4-------------------------------------------
i <- 5
x <- runif(n[i])
y <- m[i]*x + rnorm(n[i])
x <- c(x,xr[[i]])
y <- c(y,yr[[i]])
par(mfrow = c(1, 2))
plot(x, y, col = COL[2], pch = 16)
abline(lm(y ~ x), col = COL[1], lwd = 3)
x2 <- x[1:70]
y2 <- y[1:70]
plot(x2, y2, col = COL[2], pch = 16, xlim = range(x), ylim = range(y))
abline(lm(y2 ~ x2), col = COL[1], lwd = 3)

