# The difference between univariate and multivariate regression
Florian Hartig  
21 Apr 2015  



## Background

A common question for statistical beginners is 

1. Why and how do results between univariate and multivariate regressions differ?
2. Why do I read in most good textbooks that I shoudln't use univariate regressions for a multivariate problem, especially if there is multicolinearity

The aim of this script to give an answer to these questions

## Test data with colinear predictors 

Assume we have two predictors that are positively correlated, i.e. correlation coefficient > 1


```r
x1 = runif(100, -5,5)
x2 = x1 + 0.2*runif(100, -5,5)
```

We can check that this worked visually as well as by calculating the correlation coefficient. 


```r
plot(x1,x2)
```

![](UnivariateMultivariate_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
cor(x1, x2)
```

```
## [1] 0.9801695
```

## Sign of product of effect sizes the same as correlation --> univariate biased upwards

The first case I want to look at is when effect1 * effect2 > 1, i.e. if the sign of the product of the effect sizes goes in the same direction as the correlation between the predictors. Let's create such a situation:


```r
y = x1 + x2 + rnorm(100)
```

In this case, univariate models have too high effect sizes, because 1) pos correlation 2) same effect direction means that predictors can absorb each other's effect if one is taken out.


```r
coef(lm(y~x1))
```

```
## (Intercept)          x1 
##   0.1021585   2.0114312
```

```r
coef(lm(y~x2))
```

```
## (Intercept)          x2 
##   0.1558947   1.9164463
```

you see this also visually


```r
par(mfrow =c(1,2))
plot(x1, y, main = "x1 effect", ylim = c(-12,12))
abline(lm(y~x1))
abline(0,1, col = "red")
legend("topleft", c("fittet", "true"), lwd=1, col = c("black", "red")) 
plot(x2, y, main = "x2 effect", ylim = c(-12,12))
abline(lm(y~x2))
abline(0,1, col = "red")
legend("topleft", c("fittet", "true"), lwd=1, col = c("black", "red")) 
```

![](UnivariateMultivariate_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

The multivariate model, on the other hand, is fine


```r
coef(lm(y~x1 + x2))
```

```
## (Intercept)          x1          x2 
##   0.1196471   1.0444659   0.9404794
```

```r
plot(allEffects(lm(y~x1 + x2)), ylim = c(-12,12))
```

![](UnivariateMultivariate_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

## Sign of product of effect sizes not the same as correlation --> univariate biased downwards

Let's look at the case that we have positive correlation of the predictors, but they have opposite effects, so 1, -1


```r
y = x1 - x2 + rnorm(100)
```

Now, univariate models have too low effect sizes, because correlation is positve, but effects are opposite, which means univariately we see no effects 


```r
coef(lm(y~x1))
```

```
## (Intercept)          x1 
##  0.06948291 -0.15110587
```

```r
coef(lm(y~x2))
```

```
## (Intercept)          x2 
##  0.08384095 -0.18624536
```

you see this also in the plot


```r
par(mfrow =c(1,2))
plot(x1, y, main = "x1 effect", ylim = c(-12,12))
abline(lm(y~x1))
abline(0,1, col = "red")
legend("topleft", c("fittet", "true"), lwd=1, col = c("black", "red")) 
plot(x2, y, main = "x2 effect", ylim = c(-12,12))
abline(lm(y~x2))
abline(0,-1, col = "red")
legend("topleft", c("fittet", "true"), lwd=1, col = c("black", "red")) 
```

![](UnivariateMultivariate_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Again, the multivariate model is fine


```r
coef(lm(y~x1 + x2))
```

```
## (Intercept)          x1          x2 
##  0.04814945  1.02844305 -1.14724027
```

```r
plot(allEffects(lm(y~x1 + x2)), ylim = c(-12,12))
```

![](UnivariateMultivariate_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

## No correlation between predictors

So, the result so far was that if we have colinearity between predictors, univariate models are generally not reliable. Does that mean that, in turn, if there is no colinearity we're fine?

That is nearly correct, but not completely. Effect sizes are fine, but because the univariate models see more variability (a predictor is missing), p-values for the univariate models are too high.



```r
x1 = runif(50, -1,1)
x2 = runif(50, -1,1)
y = x1 + x2 + rnorm(50)

summary(lm(y~x1))
```

```
## 
## Call:
## lm(formula = y ~ x1)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.72823 -0.80023 -0.03321  0.61554  2.26738 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   0.1845     0.1434   1.286    0.204    
## x1            1.0281     0.2253   4.563 3.51e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.008 on 48 degrees of freedom
## Multiple R-squared:  0.3026,	Adjusted R-squared:  0.288 
## F-statistic: 20.82 on 1 and 48 DF,  p-value: 3.505e-05
```

```r
summary(lm(y~x2))
```

```
## 
## Call:
## lm(formula = y ~ x2)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.0146 -0.6308 -0.2124  0.6840  2.8365 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)   
## (Intercept)  -0.0164     0.1651  -0.099  0.92130   
## x2            0.7141     0.2567   2.781  0.00771 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.12 on 48 degrees of freedom
## Multiple R-squared:  0.1388,	Adjusted R-squared:  0.1209 
## F-statistic: 7.736 on 1 and 48 DF,  p-value: 0.007712
```

```r
summary(lm(y~x1 + x2))
```

```
## 
## Call:
## lm(formula = y ~ x1 + x2)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.92856 -0.54688 -0.05566  0.54176  1.69375 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  0.03957    0.12915   0.306 0.760645    
## x1           1.10909    0.19620   5.653 8.99e-07 ***
## x2           0.82809    0.20119   4.116 0.000154 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.8734 on 47 degrees of freedom
## Multiple R-squared:  0.4873,	Adjusted R-squared:  0.4655 
## F-statistic: 22.34 on 2 and 47 DF,  p-value: 1.517e-07
```

