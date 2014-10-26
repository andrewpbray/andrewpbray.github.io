midges <- read.csv("http://andrewpbray.github.io/data/midges.csv")

mapf <- lm(AL ~ WL, data = apf)
maf <- lm(AL ~ WL, data = af)

plot(AL ~ WL, data = midges, type = "n")
points(apf$WL, apf$AL, pch = 16, col = "red")
points(af$WL, af$AL, pch = 16, col = "blue")
abline(mapf)
abline(maf)

xx <- seq(1.6, 2.1, length.out = 500)
lvl <- .85
pi <- predict(mapf, data.frame(WL = xx), interval = "prediction", level = lvl)
lines(xx, pi[, 2], lty = 2, col = "red")
lines(xx, pi[, 3], lty = 2, col = "red")

pi <- predict(maf, data.frame(WL = xx), interval = "prediction", level = lvl)
lines(xx, pi[, 2], lty = 2, col = "blue")
lines(xx, pi[, 3], lty = 2, col = "blue")
