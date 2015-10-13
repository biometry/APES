set.seed(123)
replicates = 1000
N= 4000
slope = 2 # slope (linear scale)
intercept = - 10 # intercept (linear scale)

bias <- matrix(NA, nrow = replicates, ncol = 3)
incidencePredBias <- rep(NA, replicates)

for (i in 1:replicates){
  pred = runif(N,min=-1,max=1) 
  linearResponse = intercept + slope*pred
  data = rbinom(N, 1, plogis(linearResponse))  
  fit <- glm(data ~ pred, family = 'binomial', control = list(maxit = 300))
  bias[i,1:2] = fit$coefficients - c(intercept, slope)
  bias[i,3] = mean(predict(fit,type = "response")) - mean(plogis(linearResponse))
}

par(mfrow = c(1,3))
text = c("Bias intercept", "Bias slope", "Bias prediction")

for (i in 1:3){
  hist(bias[,i], breaks = 100, main = text[i])
  abline(v=mean(bias[,i]), col = "red", lwd = 3)  
}

apply(bias, 2, mean)
apply(bias, 2, sd) / sqrt(replicates)

# Filtering weird values 

apply(bias[bias[,1] > -20,], 2, mean)
apply(bias[bias[,1] > -20,], 2, sd) / sqrt(length(bias[,1] > -10))


for (i in 1:3){
  hist(bias[bias[,1] > -20,i], breaks = 100, main = text[i])
  abline(v=mean(bias[bias[,1] > -20,i]), col = "red", lwd = 3)  
}


