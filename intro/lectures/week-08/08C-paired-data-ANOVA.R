## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(ggplot2)
library(oilabs)
library(openintro)

## ----echo = FALSE--------------------------------------------------------
# tweak data set to increase dependence
gifted[19, "motheriq"] <- 130
gifted[9, "motheriq"] <- 112
gifted[21, "fatheriq"] <- 120
gifted[4, "fatheriq"] <- 123
gifted[15, "fatheriq"] <- 121
d <- data.frame(IQ = c(gifted$fatheriq, gifted$motheriq),
                sex = rep(c("male", "female"), each = nrow(gifted)))
set.seed(184)
d <- d[sample(1:nrow(d)), ]
head(d)

## ------------------------------------------------------------------------
(ds <- d %>%
  group_by(sex) %>%
  summarize(mean = mean(IQ),
            s = sd(IQ),
            n = n()))

## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.height=3-------------
#qplot(x = IQ, data = d, geom = "bar", facets = ~ sex, fill = I("linen"), col = I("darkseagreen"))
qplot(x = sex, y = IQ, data = d, geom = "boxplot")

## ------------------------------------------------------------------------
diff(ds$mean)

## ------------------------------------------------------------------------
sqrt(ds$s[1]^2 / ds$n[1] + ds$s[2]^2 / ds$n[2])

## ------------------------------------------------------------------------
min(ds$n[1] - 1, ds$n[2] - 1)

## ------------------------------------------------------------------------
pt(-2.21, df = 35) * 2

## ----nnormal, echo=FALSE, message =FALSE, warning = FALSE, fig.height = 2----
qplot(x = IQ, data = d, geom = "bar", facets = ~ sex, fill = I("linen"), col = I("darkseagreen"))

## ------------------------------------------------------------------------
head(gifted)

## ----scatterplot, echo = FALSE-------------------------------------------
qplot(x = motheriq, y = fatheriq, data = gifted)

## ------------------------------------------------------------------------
gifted %>%
  mutate(diff = fatheriq - motheriq) %>%
  select(fatheriq, motheriq, diff)

## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.height=3-------------
g <- gifted %>%
  mutate(diff = fatheriq - motheriq)
qplot(x = diff, data = g, geom = "density",fill = I("linen"), col = I("darkseagreen"))

## ------------------------------------------------------------------------
(gs <- gifted %>%
  mutate(diff = fatheriq - motheriq) %>%
  summarize(mean = mean(diff), s = sd(diff), n = n()))
(t_obs <- (gs$mean - 0)/(gs$s/sqrt(gs$n)))
pt(t_obs, df = 35) * 2

## ------------------------------------------------------------------------
gs$s / sqrt(gs$n)
sqrt(ds$s[1]^2 / ds$n[1] + ds$s[2]^2 / ds$n[2])

## ----wolf-data, echo=2:3-------------------------------------------------
wolf <- read.table("../../other/wolfriver.txt", header = TRUE)
str(wolf)
head(wolf)

## ----wolf-boxes, echo = FALSE--------------------------------------------
wolf <- read.table("../../other/wolfriver.txt", header = TRUE)
qplot(x = Depth, y = HCB, data = wolf, geom = "boxplot")

## ----wolf-densities, echo = FALSE----------------------------------------
qplot(x = HCB, color = Depth, data = wolf, geom = "density")

## ----wolf-boxes2, echo = FALSE, fig.height=3-----------------------------
qplot(x = Depth, y = HCB, data = wolf, geom = "boxplot")
f <- anova(aov(HCB ~ Depth, data = wolf))
f[, 1:4]

## ----randoF2, eval = FALSE-----------------------------------------------
## F_stats <- rep(0, 1000)
## wolf2 <- wolf
## 
## for (i in 1:1000) {
##   wolf2$Depth <- sample(wolf2$Depth)
##   F_stats[i] <- anova(aov(HCB ~ Depth, data = wolf2))$F[1]
## }
## 
## qplot(x = F_stats, geom = "density")

## ----randoF, echo = FALSE, fig.height=3.5--------------------------------
F_stats <- rep(0, 1000)
wolf2 <- wolf

for (i in 1:1000) {
  wolf2$Depth <- sample(wolf2$Depth)
  F_stats[i] <- anova(aov(HCB ~ Depth, data = wolf2))$F[1]
}

qplot(x = F_stats, geom = "density")

## ----Fpval---------------------------------------------------------------
mean(F_stats > 3.032)

## ----f-output, echo = FALSE----------------------------------------------
f

## ----Fmethods, echo = FALSE----------------------------------------------
qplot(x = F_stats, geom = "density") +
  stat_function(fun = df, args = c(df1 = 2, df2 = 27), col = "tomato")

## ----conc, fig.height=3, echo = FALSE------------------------------------
qplot(x = Depth, y = HCB, data = wolf, geom = "boxplot")

