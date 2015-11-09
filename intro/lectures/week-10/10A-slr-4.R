## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)
library(openintro)

## ----echo = FALSE--------------------------------------------------------
library(openintro)
data(unempl)
data(house)
data(president); pres <- president
year   <- seq(1898, 2010, 4)+1
n      <- length(year)
unemp  <- rep(0, n)
change <- rep(0, n)
presid <- rep("", n)
party  <- rep("", n)
for(i in 1:n){
	urow <- which(unempl$year == year[i]-1)
	if(i < n){
		prow <- which(pres$end > year[i])[1]
	} else {
		prow <- which(pres$potus == "Barack Obama")
	}
	hrow <- which(house$yearEnd >= year[i])[1]
	party[i] <- as.character(pres$party[prow])
	if(substr(house$p1[hrow],1,5) == substr(party[i],1,5)){
		oldHouse <- house$np1[hrow] / house$seats[hrow]
	} else {
		oldHouse <- house$np2[hrow] / house$seats[hrow]
	}
	if(substr(house$p1[hrow+1],1,5) == substr(party[i],1,5)){
		newHouse <- house$np1[hrow+1] / house$seats[hrow+1]
	} else {
		newHouse <- house$np2[hrow+1] / house$seats[hrow+1]
	}
	change[i] <- (newHouse - oldHouse)/oldHouse * 100
	presid[i] <- as.character(pres$potus[prow])
	unemp[i]  <- unempl$unemp[urow]
}

unemployPres <- data.frame(year=year, potus=presid, party=party, unemp=unemp, change=change)
unemployPres[29, 3] <- "Democratic"

## ----echo = FALSE--------------------------------------------------------
library(dplyr)
ump <- filter(unemployPres, unemp < 15)
m0 <- lm(change ~ unemp, data = ump)
qplot(x = unemp, y = change, col = party, data = ump) +
  geom_abline(intercept = m0$coef[1], slope = m0$coef[2])

## ------------------------------------------------------------------------
m0 <- lm(change ~ unemp, data = ump)
summary(m0)

## ------------------------------------------------------------------------
t_stat <- (-1.0010 - 0)/0.8717
pt(t_stat, df = 27 - 2) * 2

## ----ci------------------------------------------------------------------
confint(m0)

## ----resplot, echo = FALSE, fig.height = 3, fig.width = 5, fig.align="center"----
qplot(x = .fitted, y = .stdresid, data = m0)

## ----resplot2, echo = FALSE, fig.height = 3, fig.width = 5, fig.align="center"----
qplot(sample = .stdresid, data = m0, stat = "qq") +
  geom_abline()

## ----lmoutput------------------------------------------------------------
pt(t_stat, df = 27 - 2) * 2

