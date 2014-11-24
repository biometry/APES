## Mixed-effect models mini-series. Part I: a GLM refresher and some definitions

terms:
  distribution ("family")
  probability
  (probability) density
  likelihood
  maximum likelihood
  parameters (theta)
  estimate, estimator
  link scale, link function
  fitted values vs predicted values (response vs link scale)
  standard error (vs standard deviation)
  posterior (distribution)
  correlation of parameters (in the estimation process)

  simulation: 
      from distribution
      from fitted model


d...
p...
q...
r...
# Example: normal distribution
curve(dnorm(x, 4, 2), from=-2, to=10, main="probability density function (PDF)", lwd=3, las=1)
curve(pnorm(x, 4, 2), from=-2, to=10, main="cumulative density function (CDF)", lwd=3, las=1)
curve(qnorm(x, 4, 2), from=0, to=1, main="quantile function ('inverse CDF')", lwd=3, las=1)
hist(rnorm(1000, 4, 2), las=1, col="grey", border="white")

# Example: negative binomial distribution
plot(0:15, dnbinom(0:15, mu=2.7, size=2.4), type="h", main="probability density function (PDF)", lwd=3, las=1)
plot(0:15, pnbinom(0:15, mu=2.7, size=2.4), type="s", main="cumulative density function (CDF)", lwd=3, las=1)
plot(seq(0, 1, len=101), qnbinom(seq(0, 1, len=101), mu=2.7, size=2.4), main="quantile function ('inverse CDF')", type="s", lwd=3, las=1)
hist(rnbinom(1000, mu=2.7, size=2.4), las=1, col="grey", border="white")

## likelihood:
obs <- c(4,4,7,3,1,1,3,2,1,1,0,5,1,0,1)
dnbinom(obs, mu=2.7, size=2.4)
dnbinom(obs, mu=2.7, size=2.4, log=T)
sum(dnbinom(obs, mu=2.7, size=2.4, log=T))

library(MASS)
summary(glm.nb(obs ~ 1))
# why different to value above? Because mu and size were estimated from data!:
-2*sum(dnbinom(obs, mu=exp(0.8183), size=3.23, log=T)) # values taken from glm-summary





data(trees)
fm <- glm(Volume ~ Girth + Height, family="gaussian", data=trees)
summary(fm, correlation=T)
# or by foot:
vcov(fm)
cov2cor(vcov(fm))

# Now, let us look at the coefficients in the model, by plotting their distribution:
curve(dnorm(x, summary(fm)$coefficients[1,1], summary(fm)$coefficients[1,2]), n=1001, from=-70, to=6, ylim=c(0, 3), lwd=3, xlab="coefficient value", ylab="probability density", las=1)
curve(dnorm(x, summary(fm)$coefficients[2,1], summary(fm)$coefficients[2,2]), n=1001, add=T, lwd=3, col="orange")
curve(dnorm(x, summary(fm)$coefficients[3,1], summary(fm)$coefficients[3,2]), n=1001, add=T, lwd=3, col="blue")
# Maybe not the ideal range for plotting.

# Now we can simulate from this model:
# 1. WRONG:
# Draw a random value from each parameter distribution and make a prediction from this model, e.g. for the point Girth=20, Height=80 (remember: Y = Xb):
t(c(1, 20, 80)) %*% c(rnorm(1, summary(fm)$coefficients[1,1], summary(fm)$coefficients[1,2]),
rnorm(1, summary(fm)$coefficients[2,1], summary(fm)$coefficients[2,2]),
rnorm(1, summary(fm)$coefficients[3,1], summary(fm)$coefficients[3,2]))
# We can do this, say, 1000 times and plot the distribution of predicted values:
wrong.preds <- replicate(1000, t(c(1, 20, 80)) %*% c(rnorm(1, summary(fm)$coefficients[1,1], summary(fm)$coefficients[1,2]),
                      rnorm(1, summary(fm)$coefficients[2,1], summary(fm)$coefficients[2,2]),
                      rnorm(1, summary(fm)$coefficients[3,1], summary(fm)$coefficients[3,2])))
hist(wrong.preds)
summary(wrong.preds)
# ?? Why is this wrong??
# !! Because the estimates are correlated and hence cannot be drawn independently!!
# 2. Correct:
# We need to draw all estimates simultaneously (or conditionally) from a multivariate normal distribution:
library(mvtnorm)
right.preds <- replicate(1000, t(c(1, 20, 80)) %*% t(rmvnorm(1, mean=summary(fm)$coefficients[1:3,1], sigma=vcov(fm))))
hist(right.preds)
summary(right.preds)

#plot both together:
plot(density(wrong.preds), lwd=3, col="red", ylim=c(0, 0.22), las=1, main="Spot the difference!")  
lines(density(right.preds), lwd=3, col="green")  
# same as histograms:
hist(wrong.preds, freq=F, col=rgb(0.1,0.1,0.9,0.5), xlim=c(0,100), ylim=c(0,0.22), main="Overlapping Histogram", las=1)
hist(right.preds, freq=F, col=rgb(0.9,0.4,0.,0.5), add=T)




library(faraway)
data(gala)
summary(glm.nb(Species ~ log(Area) + I(log(Area)^2) + Elevation + Nearest, data=gala), correlation=T)
anova(glm.nb(Species ~ log(Area) + I(log(Area)^2) + Elevation + Nearest, data=gala))
#Note: correlation is NOT correlation among predictors, but among estimators of their effect:
cor(log(gala[, "Area"])^2, gala[,"Elevation"])
# Also: it changes as the model changes (try by removing, e.g., Nearest)!

plot(Species ~ Area, data=gala, log="x", lwd=3, las=1, cex=2)
# ?? Why is quadratic term of log(Area) not significant? It is clearly a non-linear relationship?
# !! Because the neg.binom. uses a log-link function!! The plot should be more like this:
plot(Species ~ Area, data=gala, log="xy", lwd=3, las=1, cex=2)
# Ah!

cor(trees)

