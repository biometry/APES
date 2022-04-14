# mixed effect with JAGS

library(lme4) # for access to "sleepstudy"
data(sleepstudy)
head(sleepstudy)

# We now make a new variable, which are just number 1:k, representing the different subjects (currently labelled 309, 334, 372 asf.)
subjectNr <- as.numeric(sleepstudy$Subject)

library(lattice)
xyplot(Reaction ~ Days | Subject, sleepstudy, type = c("g","p","r"),
       index = function(x,y) coef(lm(y ~ x))[1],
       xlab = "Days of sleep deprivation",
       ylab = "Average reaction time (ms)", aspect = "xy")

mean(sleepstudy$Reaction) # center random effects on mean of Y (later on)


library(R2jags)

# 1. Data into JAGS format: X, Y, and N
jagsData <- list("Days"=sleepstudy$Days, "Reaction"=sleepstudy$Reaction, "N"=nrow(sleepstudy), "k"=length(unique(sleepstudy$Subject)), "subjectNr"=subjectNr)

# 2. define model:
sleepModel <- function(){
  # likelihood function
  for (i in 1:N){
    Reaction[i] ~ dnorm(muHat[i], tau)
    # random intercept model:
    #muHat[i] <- beta0[subjectNr[i]] + beta1 * Days[i] 
    
    # random slope model:
    muHat[i] <- beta0[subjectNr[i]] + beta1[subjectNr[i]] * Days[i] 
  }
  # priors
  for (j in 1:k){
    beta0[j] ~ dnorm(beta00, tau.random) # random intercept
  }
  for (j in 1:k){
    beta1[j] ~ dnorm(beta11, tau.slope) # random slope
  }
  beta00 ~ dnorm(300, 0.001)        # grand mean
  beta11 ~ dnorm(0, 0.001)          # shrinkage possible here, e.g. using ddexp
  tau ~ dgamma(0.001, 0.001)
  tau.random ~ dgamma(0.001, 0.001)
  tau.slope ~ dgamma(0.001, 0.001)
  
  # computed parameters for easier interpretation:
  sigma <- sqrt(1/tau)
  sigma.random <- sqrt(1/ tau.random)
  sigma.slope <- sqrt(1/ tau.slope)
}

# 3. set parameter:
parameter <- c("beta00", "beta0", "beta11", "beta1", "sigma", "sigma.random", "sigma.slope")
#initfun <- function(N) replicate(N, as.list(c("beta0"=rnorm(1, 0, 4), "beta1"=rnorm(1, 0, 4), "tau"=rgamma(0.01, 0.01))), simplify=F)
n.chains <- 4; n.iter <- 5000; n.thin <- 1

# 4. run JAGS:
fjags <- jags(data = jagsData, inits = NULL, parameters.to.save = parameter, model.file = sleepModel, n.chains = n.chains, n.iter = n.iter, n.thin = n.thin)

# 5. summmarise model:
fjags
plot(fjags)




flme <- lmer(Reaction ~ Days + (Days|Subject), data=sleepstudy)
summary(flme)
ranef(flme)
