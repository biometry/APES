---
layout: page
title: Generalized linear models
category: subregression
---

Generalized linear models (GLM)
===


# The general idea

General ideas of linear regression is that 

* Response is continous, theoretically from -infinity to + infinity
* Residuals are normally distributed around the model predictions

Idea of the GLM framework is take the linear regression framework, but allow relaxing both assumptions. To do this, we have to do two things

* We wrap the linear model in a transformation function that forces the response on the right interval (typical intervals are positive, or between 0 and 1). This transformation is called the link function
* We use other distributions as the Gaussian for the fit.

Those two ideas are explained in more detail below


## Other distributions

## Link function


# Important GLM types

## Logistic Regression



```r
## binomial data
require(effects) # holds the data
```

```
## Loading required package: effects
## Loading required package: lattice
## Loading required package: grid
## Loading required package: colorspace
```

```r
head(TitanicSurvival)
```

```
##                                 survived    sex     age passengerClass
## Allen, Miss. Elisabeth Walton        yes female 29.0000            1st
## Allison, Master. Hudson Trevor       yes   male  0.9167            1st
## Allison, Miss. Helen Loraine          no female  2.0000            1st
## Allison, Mr. Hudson Joshua Crei       no   male 30.0000            1st
## Allison, Mrs. Hudson J C (Bessi       no female 25.0000            1st
## Anderson, Mr. Harry                  yes   male 48.0000            1st
```

```r
attach(TitanicSurvival)
 
plot(survived ~ age)
```

![plot of chunk unnamed-chunk-1](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-11.png) 

```r
surv <- as.numeric(survived)-1
 
plot(surv ~ age)
 
fmt <- glm(surv ~ age + I(age^2) + I(age^3), family=binomial)
summary(fmt)
```

```
## 
## Call:
## glm(formula = surv ~ age + I(age^2) + I(age^3), family = binomial)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.506  -0.998  -0.970   1.348   2.014  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  7.85e-01   3.03e-01    2.59   0.0095 ** 
## age         -1.19e-01   3.29e-02   -3.61   0.0003 ***
## I(age^2)     3.41e-03   1.11e-03    3.07   0.0022 ** 
## I(age^3)    -2.93e-05   1.11e-05   -2.65   0.0081 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1414.6  on 1045  degrees of freedom
## Residual deviance: 1398.5  on 1042  degrees of freedom
##   (263 observations deleted due to missingness)
## AIC: 1406
## 
## Number of Fisher Scoring iterations: 4
```

```r
# showing that residuals are not normal at all
#hist(fmt$residuals, breaks = 100)
#abline(v = 0, col = "red", lwd = 6, lty = 2)
# residual plots can also be created with plot(fmt)
 
 
newage <- seq(min(age, na.rm=T), max(age, na.rm=T), len=100)
preds <- predict(fmt, newdata=data.frame("age"=newage), se.fit=T)
lines(newage, plogis(preds$fit), col="purple", lwd=3)
lines(newage, plogis(preds$fit-2*preds$se.fit), col="purple", lwd=3, lty=2)
lines(newage, plogis(preds$fit+2*preds$se.fit), col="purple", lwd=3, lty=2)
```

![plot of chunk unnamed-chunk-1](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-12.png) 

```r
fmt <- glm(surv ~ age + sex + passengerClass, family=binomial)
summary(fmt)
```

```
## 
## Call:
## glm(formula = surv ~ age + sex + passengerClass, family = binomial)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -2.640  -0.698  -0.434   0.669   2.396  
## 
## Coefficients:
##                   Estimate Std. Error z value Pr(>|z|)    
## (Intercept)        3.52207    0.32670   10.78  < 2e-16 ***
## age               -0.03439    0.00633   -5.43  5.6e-08 ***
## sexmale           -2.49784    0.16604  -15.04  < 2e-16 ***
## passengerClass2nd -1.28057    0.22554   -5.68  1.4e-08 ***
## passengerClass3rd -2.28966    0.22580  -10.14  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1414.62  on 1045  degrees of freedom
## Residual deviance:  982.45  on 1041  degrees of freedom
##   (263 observations deleted due to missingness)
## AIC: 992.5
## 
## Number of Fisher Scoring iterations: 4
```

```r
detach(TitanicSurvival)
```



## Poisson Regression



```r
## Poisson:
 
# data
cfc <- data.frame(
  stuecke = c(3,6,8,4,2,7,6,8,10,3,5,7,6,7,5,6,7,11,8,11,13,11,7,7,6),
  attrakt = c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5) 
)
attach(cfc)
plot(stuecke ~ attrakt)
 
fm <- glm(stuecke ~ attrakt, family=poisson)
summary(fm)
```

```
## 
## Call:
## glm(formula = stuecke ~ attrakt, family = poisson)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.554  -0.728   0.037   0.591   1.546  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept)   1.4746     0.1944    7.58  3.3e-14 ***
## attrakt       0.1479     0.0544    2.72   0.0065 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for poisson family taken to be 1)
## 
##     Null deviance: 25.829  on 24  degrees of freedom
## Residual deviance: 18.320  on 23  degrees of freedom
## AIC: 115.4
## 
## Number of Fisher Scoring iterations: 4
```

```r
newattrakt <- c(1,1.5,2,2.5,3,3.5,4,4.5,5)
preds <- predict(fm, newdata=data.frame("attrakt"=newattrakt))
lines(newattrakt, exp(preds), lwd=2, col="green")
 
# same with 95% confidence interval:
preds <- predict(fm, newdata=data.frame("attrakt"=newattrakt), se.fit=T)
str(preds)
```

```
## List of 3
##  $ fit           : Named num [1:9] 1.62 1.7 1.77 1.84 1.92 ...
##   ..- attr(*, "names")= chr [1:9] "1" "2" "3" "4" ...
##  $ se.fit        : Named num [1:9] 0.1459 0.1235 0.1034 0.0872 0.0775 ...
##   ..- attr(*, "names")= chr [1:9] "1" "2" "3" "4" ...
##  $ residual.scale: num 1
```

```r
lines(newattrakt, exp(preds$fit), lwd=2, col="green")
lines(newattrakt, exp(preds$fit+2*preds$se.fit), lwd=2, col="green", lty=2)
lines(newattrakt, exp(preds$fit-2*preds$se.fit), lwd=2, col="green", lty=2)
```

![plot of chunk unnamed-chunk-2](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-2.png) 

```r
detach(cfc)
```


# Technical details 



```r
## Poisson with optimization by hand
 
# data
cfc <- data.frame(
  stuecke = c(3,6,8,4,2,7,6,8,10,3,5,7,6,7,5,6,7,11,8,11,13,11,7,7,6),
  attrakt = c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5) 
)
attach(cfc)
plot(stuecke ~ attrakt)
```

![plot of chunk unnamed-chunk-3](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-31.png) 

```r
# defining the likelihood of a Poisson regression
 
loglikelihood <- function(par, independent = attrakt, observed = stuecke){
  linear = par[1]*independent + par[2]  # linear predictor
  predict = exp(linear)                 # link function
  logprobabilities = dpois(observed, predict, log=T)  # distribution
  return(-sum(logprobabilities))
}
 
# plotting the likelihood for different slopes, fixed intercept
 
slope=seq(0.05,0.25,length.out = 100)
intercept = rep(1.4,100)
pars = cbind(slope, intercept)
plot(slope, apply(pars,1, loglikelihood), main = "Likelihood profile", ylab = "Neg Log Likelihood")
```

![plot of chunk unnamed-chunk-3](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-32.png) 

```r
# plotting the likelihood surface (= likelihood as a function of slope, intercept)
 
intercept = seq(1.2,1.7,length.out = 100)
parametervalues = expand.grid(slope,intercept)
parametervalues$response = apply(parametervalues,1, loglikelihood)
contour(slope, intercept, matrix(parametervalues$response, nrow = 100), nlevels = 20, main = "Likelihood response surface", xlab = "slope parameter", ylab = "intercept parameter")
 
 
# optimization with the optim function
 
bestfit = optim(c(0.12,1.3), loglikelihood, method = "BFGS")
points(bestfit$par[1], bestfit$par[2], col = "red", lwd = 4)
```

![plot of chunk unnamed-chunk-3](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-33.png) 

```r
# calculating the "Hessian" matrix (Funktionaldeterminante)
 
bestfit = optim(c(0.12,1.3), loglikelihood, method = "BFGS", hessian = T)
bestfit$hessian
```

```
##      [,1] [,2]
## [1,] 2225  573
## [2,]  573  174
```

```r
persp(slope, intercept, matrix(parametervalues$response, nrow = 100), theta = 40, phi = 30, expand = 0.7, col = c("grey","red"),  ticktype = "detailed")
```

![plot of chunk unnamed-chunk-3](./stats23-generalizedLinearModels-GLM_files/figure-html/unnamed-chunk-34.png) 

```r
# bonus plot
library(rgl)
persp3d(slope, intercept, matrix(parametervalues$response, nrow = 100), col = c("grey","red"), box = FALSE)
 
 
detach(cfc)
```





## Links

http://blog.revolutionanalytics.com/2014/04/some-r-resources-for-glms.html

