## Simple Linear Regression simulation

n <- 60
beta_0 <- 12
beta_1 <- .7
sigma <- 2
x <- rnorm(n, mean = 20, sd = 3)
f_mean <- beta_0 + beta_1 * x

f_data <- f_mean + rnorm(n, mean = 0, sd = sigma) # data generating function
plot(20, 25, xlim = c(12, 28), ylim = c(17, 35), ylab = "y", xlab = "x", type = "n") # set up an empty plot
points(x, f_data, pch = 16, col = "steelblue") # add generated data
abline(a = beta_0, b = beta_1, col = "orange", lwd = 2) # add mean function
m1 <- lm(f_data ~ x)

it <- 5000
coef_mat <- matrix(rep(NA, it * 2), ncol = 2)
for(i in 1:it) {
  f_data <- f_mean + rnorm(n, mean = 0, sd = sigma)
  coef_mat[i, ] <- lm(f_data ~ x)$coef
}

par(mfrow = c(1, 2))
hist(coef_mat[, 1])
hist(coef_mat[, 2])




### from estimation
d <- read.table("http://www.stat.tamu.edu/~sheather/book/docs/datasets/production.txt",
                header = T)
xlims <-  c(50, 350)
ylims <-  c(140, 260)
plot(200, 200, xlim = xlims, ylim = ylims,
     type = "n", xlab = "Run Size", ylab = "Run Time")
points(d$RunSize, d$RunTime)
m1 <- lm(RunTime ~ RunSize, data = d)
abline(m1)

abline(m1, col = "orange", lwd = 2)
x <- seq(xlims[1], xlims[2], length.out = 200)
y <- seq(ylims[1], ylims[2], length.out = 200)
outer(x, y, fun = dnorm)
f_gen <- dnorm(y, mean = m1$coef[1] + m1$coef[2]*x, 
                        sd = sqrt(sum(m1$res^2)/m1$df.res))



y_gen <- m1$fit + rnorm(length(m1$fit), mean = 0, sd = sqrt(sum(m1$res^2)/m1$df.res))
plot(200, 200, xlim = c(50, 350), ylim = c(140, 260),
     type = "n", xlab = "Run Size", ylab = "Run Time")
abline(m1, col = "orange", lwd = 2)
points(d$RunSize, y_gen, pch = 16, col = "steelblue")
