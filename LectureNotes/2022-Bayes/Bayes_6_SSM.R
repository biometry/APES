#Data are a house martin population data from Magden (?) from 1990 to 2009 (20 years). We immediately add 6 years (2010-2015) to later extrapolate to:

pyears <- 6 # Number of future years with predictions
hm <- c(271, 261, 309, 318, 231, 216, 208, 226, 195, 226, 233, 209, 226, 192, 191, 225, 245, 205, 191, 174, rep(NA, pyears))
year <- 1990:(2009 + pyears)
plot(hm ~ year, las=1, type="o", pch=16, cex=2)

library(R2jags)

# Bundle data
jags.data <- list(y = log(hm), T = length(year))

ssm <- function(){
  # State process
  for (t in 1:(T-1)){
    r[t] ~ dnorm(mean.r, tau.proc)
    logN.est[t+1] <- logN.est[t] + r[t]
  }
  
  # Observation process
  for (t in 1:T){
    y[t] ~ dnorm(logN.est[t], tau.obs)
  }
  
  # Priors and constraints
  logN.est[1] ~ dnorm(5.6, 0.01)       # Prior for initial population size, = log(271)
  mean.r ~ dnorm(1, 0.001)             # Prior for mean growth rate
  tau.proc ~ dgamma(0.01, 0.01)        # Prior for sd of state process
  sigma2.proc <- pow(tau.proc, -1)
  tau.obs ~ dgamma(0.01, 0.01)         # Prior for sd of observation process
  sigma2.obs <- pow(tau.obs, -1)

  }


# Initial values
inits <- function(){list(sigma.proc = runif(1, 0, 1), mean.r = rnorm(1), sigma.obs = runif(1, 0, 1), logN.est = c(rnorm(1, 5.6, 0.1), rep(NA, (length(year)-1))))} # can be omitted; JAGS will then compute the mean of priors for each parameter

# Parameters monitored
parameters <- c("r", "mean.r", "sigma2.obs", "sigma2.proc", "logN.est")

# MCMC settings
ni <- 20000 # number of iterations (overall)
nb <- ni/2
nt <- 1      # thinning rate (keeps only every nt observations)
nc <- 4      # number of chains

# Call JAGS from R (BRT 3 min)
housemartin.ssm <- jags(jags.data, inits=NULL, parameters, model=ssm, n.chains = nc, n.thin = nt, n.iter = ni, n.burnin = nb, working.directory = getwd()) # this ignores the previously defined initial values!!

plot(housemartin.ssm)

housemartin.ssm
# note CI for mean.r extends into the positive!
# note process and observation error are roughly similar in size
# estimate for r:
#             mu.vect sd.vect    2.5%     25%     50%     75%   97.5%  Rhat n.eff
#mean.r        -0.022   0.033  -0.075  -0.038  -0.022  -0.006   0.029 1.004 30000

# Let us fist look at the nicer but misleadingly optimistic model fit (notice that we have to back-transform the `y`-estimates after computing the quantiles):
plot(year, hm, ylim=c(100, 350), las=1, type="o", lwd=2, pch=16, ylab="population size of house martins")
# indicate extrapolated region by greying:
polygon(c(2009.5, 2015.5, 2015.5, 2009.5), c(0,0,400,400), col="grey90", border=NA)
# compute quantiles to be plotted:
quants <- exp(apply(housemartin.ssm$BUGSoutput$sims.list$logN.est, 2, quantile, c(0.975, 0.5, 0.025)))
matlines(year, t(quants), col="blue", lwd=2, lty=c(2,1,2)) # nsamples x nyears

# That looks very nice: a relatively close fit of the confidence envelop around the observations, and the fitted closely following the observed. 

# Final comments: 
This is the fit to the data, i.e.  \hat{y} | y

If we only had the initial value, y_1, and would predict the population dynamics from that value, given our estimates for r and the taus, the error bars would be VERY different!
  

onesim <- function(){
    S.logN <- rep(NA, 20)
    S.y <- S.logN
    S.logN[1] <- log(271)
    S.y[1] <- rnorm(1, S.logN[1], sqrt(housemartin.ssm$BUGSoutput$mean$sigma2.obs)) # observation error 1. obs
    
    for (t in 2:20){
      S.r <- rnorm(1, 
                   mean=housemartin.ssm$BUGSoutput$mean$mean.r, # mean growth rate
                   sd=sqrt(housemartin.ssm$BUGSoutput$mean$sigma2.proc) ) # sd of growth rate
      S.logN[t] <- S.logN[t-1] + S.r
      S.y[t] <- rnorm(1, S.logN[t], sqrt(housemartin.ssm$BUGSoutput$mean$sigma2.obs)) # observation error
    }
    S.y
  }
onesim()
sims <- replicate(1000, exp(onesim()))
quants3 <- apply(sims, 1, quantile, c(0.975, 0.5, 0.025))

plot(year, hm, ylim=c(0, 800), las=1, type="o", lwd=2, pch=16)
matlines(1990:2009, t(quants3), type="l", log="y", lwd=2, col="grey", lty=2)

# This is also the prediction uncertainty cone of the original analysis for the coming 6 years.




#### Reference analysis in a non-SSM ####

hm <- c(271, 261, 309, 318, 231, 216, 208, 226, 195, 226, 233, 209, 226, 192, 191, 225, 245, 205, 191, 174)
time <- (1990:2009)-1990 # years since t0


# differential equation solution (e.g. Case 2001 p.3):
summary(nls(hm ~ 271*exp(r*time), start=list("r"=0)))
#Estimate Std. Error t value Pr(>|t|)    
#r -0.019311   0.002654  -7.276 6.66e-07 ***
  
# difference equation solution:
summary(nls(hm ~ 271*lambda^time, start=list("lambda"=0)))
#Estimate Std. Error t value Pr(>|t|)    
#lambda 0.980875   0.002603   376.8   <2e-16 ***

# lambda = exp(r), except that it isn't ... (lambda = 1 + r)

expGrowthfun <- function(par){
  r <- par["r"]
  sigma <- exp(par["c"])
  yhat <- log(271)
  for (i in seq_along(time)){
    yhat[i+1] <- yhat[i] + r # at log scale
  }
  -sum(dnorm(log(hm), mean=yhat, sd=sigma, log=T))
}
optim(par=c("r"=0, "c"=1), fn=expGrowthfun)
#$par
#          r           c 
#-0.01672054 -2.02074216 # even shallower than the analytical solution at the untransformed scale!


# bottom line:
# The SSM analysis gives us a slightly steeper decline (r=-0.022+/-0.033) than fitting the analytical solution (r=-0.019+/-0.0026). 
# This suggests that the observation error and/or the conditional likelihood as target function affect the model estimation at least a bit.
# A more complex example would be great ...