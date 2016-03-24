# EXERCISE 1

myData <- women
#This dataset includes the average heights and weights of American women aged 30-39. 
#A data frame with 15 observations on 2 variables.
?women
attach(myData)

#1)  Weight and Height. Correlation or causation? 

#2) run the correlation coefficient (which one?) (correlation)

#3) fit a linear regression (causation) 

#4) prepare a scatterplot, plot predictions of the linear regression along with 95% CI

#5) inspect the summary of the model and make sure you understand each single bit of it

#6) check model assumptions (2x2 plot), what's wrong?

#7) run a normality test to further inspect normality of residuals

#8) plot your indipendent variable (x-axis) against residuals (y-axis). 
#include a horizontal line h = 0. what's wrong?
#what is the major issue with this model, if any?

#9) include a quadratic term in the model structure. plot predictions with 95% CIs 

#10) Is this model meeting the assumptions of  
#regression better than the previous linear regression? compare the two models diagnostics. 
#does the non-linear model fix all the problems?



#SOLUTIONS

#1)  Weight and Height. Correlation or causation? 
causation! Height affects weigth, not vice versa!
  
#2) run the correlation coefficient (which one?) (correlation)
shapiro.test(weight)
shapiro.test(height)
par(mfrow = c(1, 2))
qqnorm(weight); qqline(weight)
qqnorm(height); qqline(height)
cor.test(weight, height, method = "pearson") 
par(mfrow = c(1, 1))

#3) fit a linear regression (causation) 
fit <- lm(weight ~ height)

#4) prepare a scatterplot, plot predictions of the linear regression along with 95% CI
plot(myData, xlab = "Height (in)", ylab = "Weight (lb)",
     main = "women data: American women aged 30-39")
newdata = data.frame(height = seq(58, 72, 1))
predictions = predict(fit, newdata, se = T)
lines(newdata$height, predictions$fit, col = "red")
lines(newdata$height, predictions$fit + (1.96 * predictions$se.fit), col = "grey")
lines(newdata$height, predictions$fit - (1.96 * predictions$se.fit), col = "grey")

#5) inspect the summary of the model and make sure you understand each single bit of it
summary(fit) 

#6) check model assumptions (2x2 plot), what's wrong?
par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))


#7) run a normality test to further inspect normality of residuals
shapiro.test(fit$residuals)

#8) plot your indipendent variable (x-axis) against residuals (y-axis). 
#include a horizontal line h = 0. what's wrong?
#what is the major issue with this model, if any?
plot(height,fit$residuals)
abline(h=0)

#9) include a quadratic term in the model structure. plot predictions with 95% CIs 
fit1 <- lm(weight ~ height+I(height^2))
plot(myData, xlab = "Height (in)", ylab = "Weight (lb)",
     main = "women data: American women aged 30-39")
predictions = predict(fit1, newdata, se = T)
lines(newdata$height, predictions$fit, col = "red")
lines(newdata$height, predictions$fit + (1.96 * predictions$se.fit), col = "grey")
lines(newdata$height, predictions$fit - (1.96 * predictions$se.fit), col = "grey")


#10) Is this model meeting the assumptions of  
#regression better than the previous linear regression? compare the two models diagnostics. 
#does the non-linear model fix all the problems?

par(mfrow = c(2, 2))
plot(fit); plot(fit1)
par(mfrow = c(1, 1))
# much better, still with problemsthough



