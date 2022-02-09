library(R2jags) # will also install JAGS, but not on Apple Silicon (change to Intel R using Rswitch.app)  ...
fly <- read.table("flycatcher.txt", header=T)
summary(fly)

par(mar=c(5,5,1,1))
plot(items ~ attract, data=fly, las=1, cex=1.5, pch=16)

# 1. Data into JAGS format: X, Y, and N
jagsData <- list(X=fly$attract, Y=fly$items, N=nrow(fly))

# 2. Modell formulieren:
# (abstract on purpose!) (can also use the actual names, of course)

flyModel <- function(){
  # likelihood function
  for (i in 1:N){
    Y[i] ~ dpois(lambdaHat[i])
    log(lambdaHat[i]) <- beta0 + beta1 * X[i]
    # because this is an assignment, the model may also be non-linear!
  }
  # priors
  beta0 ~ dnorm(0, 0.01) # !!!! mean and PRECISION (= 1/variance = 1/sd^2)
  beta1 ~ dnorm(0, 0.01)
}

# 3. set parameter:
parameter <- c("beta0", "beta1")
initfun <- function(N) replicate(N, as.list(c("beta0"=rnorm(1, 0, 4), "beta1"=rnorm(1, 0, 4))), simplify=F)
n.chains <- 4; n.iter <- 5000; n.thin <- 1

# 4. run JAGS:
fjags <- jags(data = jagsData, inits = initfun(n.chains), parameters.to.save = parameter, model.file = flyModel, n.chains = n.chains, n.iter = n.iter, n.thin = n.thin)

# 5. summmarise model:
fjags

# 6. adapt JAGS-parameters:
# Are MCMC-samples autocorrelated?
plot(pacf(as.mcmc(fjags)[[2]][,2]), xlim=c(0, 25), las=1) # e.g. beta1 in 2. chain
# only lag-1, which is compatible with Markov-chain properties

# diagnostic "Rhat" (should be <= 1.02)
fjags

plot(fjags)
par(mfrow=c(3,1))
traceplot(fjagsWindow <- window(as.mcmc(fjags), start=0.51*n.iter), las=1, lty=1)




# Comparison with GLM:
fjags
summary(fglm <- glm(items ~ attract, data=fly, family=poisson))



# comparing prior, likelihood and posterior for beta1:
# prior:
curve(dnorm(x, 0, 1/sqrt(0.01)), from=-40, to=40, ylab="probability density", las=1, lwd=2, n=501, ylim=c(0, .05), col="orange", xlab=expression(beta[1]))
curve(dnorm(x, mean=0.14794, sd=0.05437), add=T, col="blue", lwd=2, n=501) 

# ah, so scale is completely wrong: zoom out of y:
curve(dnorm(x, 0, 1/sqrt(0.01)), from=-40, to=40, ylab="probability density", las=1, lwd=2, n=501, ylim=c(0, 8), col="orange", xlab=expression(beta[1]))
abline(v=0, col="orange", lwd=2)
# likelihood (from GLM):
curve(dnorm(x, mean=0.14794, sd=0.05437), add=T, col="blue", lwd=2, n=501) 
# posterior (from fjags output):
curve(dnorm(x, mean=0.144, sd=0.178), add=T, col="green", lwd=2, n=501) 
legend("topleft", legend=c("prior", "likelihood", "posterior"), col=c("yellow", "blue", "green"), lwd=2, bty="n", cex=1.5)

# ah, so scale is wrong also for x: zoom out:
curve(dnorm(x, 0, 1/sqrt(0.01)), from=-1, to=1, ylab="probability density", las=1, lwd=2, n=501, ylim=c(0, 4), col="orange", xlab=expression(beta[1]))
abline(v=0, col="orange", lwd=2, lty=2)
# likelihood (from GLM):
curve(dnorm(x, mean=0.14794, sd=0.05437), add=T, col="blue", lwd=2, n=501) 
# posterior (from fjags output):
curve(dnorm(x, mean=0.144, sd=0.178), add=T, col="green", lwd=2, n=501) 
legend("topleft", legend=c("prior", "likelihood", "posterior"), col=c("yellow", "blue", "green"), lwd=2, bty="n", cex=1.5)
abline(v=0.148, lty=2, col="blue")
abline(v=0.144, lty=2, col="green")



# too long already, so why not fit another model:

data(Puromycin)
plot(Puromycin[, c(1,2)])
summary(nls(rate ~ (vmax * conc) / (Km + conc) + B, start=list("vmax"=200, "Km"=0.4, "B"=20), data=Puromycin))

jagsData <- list(conc=Puromycin$conc, treat=ifelse(Puromycin$state=="treated", 1, 0), rate=Puromycin$rate, N=nrow(Puromycin))

# 2. Modell formulieren:
# (abstract on purpose!) (can also use the actual names, of course)

MMmodel <- # "function(){
"model{
  # likelihood function
  for (i in 1:N){
    rate[i] ~ dnorm(muHat[i], tauHat)
    muHat[i] <- (vmax * conc[i]) / (Km + conc[i]) + B
    #muHat[i] <- (vmax * conc[i] + beta1*treat[i]) / (Km + conc[i]) + B
  }
  # priors
  vmax ~ dnorm(200, 0.001) T(0, )
  Km   ~ dnorm(0, 0.001) T(0, )
  B    ~ dnorm(0, 0.001) T(0, )
  beta1 ~ dnorm(0, 0.001)
  tauHat ~ dgamma(0.01, 0.01)
  # transformed:
  sigma <- pow(tauHat, -1/2)
}"

# 3. set parameter:
parameter <- c("vmax", "Km", "B", "sigma")#, "beta1")
initfun <- function(N) replicate(N, as.list(c("vmax"=max(Puromycin$rate), "Km"=sample(Puromycin$conc, 1)/2, "B"=rnorm(1, 0, 4)^2, "beta1"=rnorm(1, 0, 4), "tauHat"=rexp(1, 0.1))), simplify=F)
n.chains <- 4; n.iter <- 1000; n.thin <- 1

# 4. run JAGS:
fjags <- jags(data = jagsData, inits = initfun(n.chains), parameters.to.save = parameter, model.file = textConnection(MMmodel), n.chains = n.chains, n.iter = n.iter, n.thin = n.thin)
#closeAllConnections()

fjags
plot(fjags)
traceplot(fjags) # show how poor traces look better mixing with 5000 iterations

hist(fjags$BUGSoutput$sims.matrix[, "sigma"])

plot(Puromycin[, c(1,2)])
curve(166*x /(0.12+x)+38, 0, 1.1, ylim=c(0, 200), add=T)
curve(164*x /(0.07+x)+21, 0, 1.1, col="red", add=T)
curve(138*x /(0.137+x)+53, 0, 1.1, col="red", add=T)
curve(149*x /(0.17+x)+48, 0, 1.1, col="red", add=T)

round(cor(fjags$BUGSoutput$sims.matrix), 2)

library(lattice)
densityplot(window(as.mcmc(fjags))[,-5]) # drop deviance


