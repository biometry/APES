# are p-values for the slope affected by centering?


pval = rep(NA, 1000)

for (i in 1:1000){
  trueA = 1
  trueB = 0
  trueSd = 10
  sampleSize = 31
  
  x = (-(sampleSize-1)/2):((sampleSize-1)/2)
  y =  trueA * x + trueB + rnorm(n=sampleSize,mean=0,sd=trueSd)
  
  
  pval[i] = summary(lm(y ~ x))$coefficients[2,4]  
}

hist(log(pval), breaks = 100, col = "#99000050")


pval = rep(NA, 1000)

for (i in 1:1000){
  trueA = 1
  trueB = 0
  trueSd = 10
  sampleSize = 31
  
  x = (-(sampleSize-1)/2):((sampleSize-1)/2) + 100
  y =  trueA * x + trueB + rnorm(n=sampleSize,mean=0,sd=trueSd)
  
  
  pval[i] = summary(lm(y ~ x))$coefficients[2,4]  
}

hist(log(pval), breaks = 100, col = "#00990050", add = T)

