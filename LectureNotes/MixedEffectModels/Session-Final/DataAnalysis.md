# Data Analysis
FlorianHartig  
29 Apr 2015  




## Read in the data 



```r
data <- read.table("data.txt", header=TRUE, quote="\"")
```

## Results of the discussion in the group

The following picture shows the results of the group discussion

![alt text](discussion.jpg)

Summary

* Starting with poisson and glmer, might move to mgcv and negative binomial if heavy overdispersion is found
* Random terms as displayed, fixed, normally no MS on these terms but could use simulated LRT if particular hypotheses are to be contrasted
  * Year is as random, but could also be used as fixed if a contrast is expected
* linear and quadratic terms for all predictors, one interaction that seemed to be biologically sensible
  * MS is probably not neccessary because sample size should be large enough to support this model
 
## Result of the fit



```r
fit <- glmer(beetles ~ precipitation + I(precipitation^2) + altitude + I(altitude^2) + temperature + I(temperature^2) + minTemp + I(minTemp^2) + precipitation:temperature + precipitation:I(temperature^2) + (1|region/plot) + (1|technician) + (1|year), family = poisson, data = data)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl =
## control$checkConv, : Model failed to converge with max|grad| = 0.00204397
## (tol = 0.001, component 9)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, : Model is nearly unidentifiable: very large eigenvalue
##  - Rescale variables?;Model is nearly unidentifiable: large eigenvalue ratio
##  - Rescale variables?
```

```r
summary(fit)
```

```
## Generalized linear mixed model fit by maximum likelihood (Laplace
##   Approximation) [glmerMod]
##  Family: poisson  ( log )
## Formula: 
## beetles ~ precipitation + I(precipitation^2) + altitude + I(altitude^2) +  
##     temperature + I(temperature^2) + minTemp + I(minTemp^2) +  
##     precipitation:temperature + precipitation:I(temperature^2) +  
##     (1 | region/plot) + (1 | technician) + (1 | year)
##    Data: data
## 
##      AIC      BIC   logLik deviance df.resid 
##   1922.2   1995.8   -946.1   1892.2      985 
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.7223 -0.3559 -0.1097 -0.0091  5.8602 
## 
## Random effects:
##  Groups      Name        Variance Std.Dev.
##  plot:region (Intercept) 0.3332   0.5772  
##  year        (Intercept) 0.4752   0.6893  
##  region      (Intercept) 4.7194   2.1724  
##  technician  (Intercept) 3.9280   1.9819  
## Number of obs: 1000, groups:  
## plot:region, 50; year, 20; region, 10; technician, 5
## 
## Fixed effects:
##                                  Estimate Std. Error z value Pr(>|z|)    
## (Intercept)                    -16.145803   2.057237  -7.848 4.22e-15 ***
## precipitation                   -0.176260   1.986634  -0.089 0.929302    
## I(precipitation^2)              -1.216485   0.319122  -3.812 0.000138 ***
## altitude                         2.779933   5.129131   0.542 0.587826    
## I(altitude^2)                    0.900911   4.828599   0.187 0.851991    
## temperature                      2.349350   0.227711  10.317  < 2e-16 ***
## I(temperature^2)                -0.095660   0.010793  -8.863  < 2e-16 ***
## minTemp                         -0.463308   0.041766 -11.093  < 2e-16 ***
## I(minTemp^2)                    -0.043221   0.002334 -18.520  < 2e-16 ***
## precipitation:temperature        0.067613   0.402565   0.168 0.866619    
## precipitation:I(temperature^2)  -0.011221   0.020193  -0.556 0.578424    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##             (Intr) prcptt I(p^2) altitd I(l^2) tmprtr I(t^2) minTmp I(T^2)
## precipitatn -0.493                                                        
## I(prcptt^2)  0.015 -0.125                                                 
## altitude    -0.500 -0.010  0.001                                          
## I(altitd^2)  0.342  0.018 -0.006 -0.925                                   
## temperature -0.567  0.841  0.036 -0.028  0.037                            
## I(tmprtr^2)  0.550 -0.833 -0.057  0.031 -0.037 -0.993                     
## minTemp      0.101 -0.107  0.018  0.018 -0.019 -0.038  0.033              
## I(minTmp^2)  0.092 -0.098  0.037  0.015 -0.017 -0.032  0.033  0.980       
## prcpttn:tmp  0.475 -0.976 -0.056  0.009 -0.016 -0.826  0.831  0.119  0.109
## prcpt:I(^2) -0.452  0.952  0.080 -0.008  0.015  0.791 -0.804 -0.128 -0.119
##             prcpt:
## precipitatn       
## I(prcptt^2)       
## altitude          
## I(altitd^2)       
## temperature       
## I(tmprtr^2)       
## minTemp           
## I(minTmp^2)       
## prcpttn:tmp       
## prcpt:I(^2) -0.994
```

```r
plot(allEffects(fit))
```

![](DataAnalysis_files/figure-html/unnamed-chunk-3-1.png) 

The results of the fit are fine, but it's a lot easier to see what's going if we don't have all this interactions flying around. Well, if you know that there are actually no interactions in there. I added also a  (1|dataID) term to absorb potential overdispersion. Would I have chosen this model if I wouldn't have known what the true model is? Who knows. But it's a good reminder that interactions can screw up your significance and will make results more difficult to interpret


```r
fit <- glmer(beetles ~ precipitation + I(precipitation^2) + altitude + I(altitude^2) + temperature + I(temperature^2) + minTemp + I(minTemp^2)  + (1|region/plot) + (1|technician) + (1|year) + (1|dataID), family = poisson, data = data)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl =
## control$checkConv, : Model failed to converge with max|grad| = 0.0695406
## (tol = 0.001, component 9)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, : Model is nearly unidentifiable: very large eigenvalue
##  - Rescale variables?;Model is nearly unidentifiable: large eigenvalue ratio
##  - Rescale variables?
```

```r
summary(fit)
```

```
## Generalized linear mixed model fit by maximum likelihood (Laplace
##   Approximation) [glmerMod]
##  Family: poisson  ( log )
## Formula: 
## beetles ~ precipitation + I(precipitation^2) + altitude + I(altitude^2) +  
##     temperature + I(temperature^2) + minTemp + I(minTemp^2) +  
##     (1 | region/plot) + (1 | technician) + (1 | year) + (1 |      dataID)
##    Data: data
## 
##      AIC      BIC   logLik deviance df.resid 
##   1874.8   1943.5   -923.4   1846.8      986 
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.2114 -0.3116 -0.0984 -0.0086  6.0426 
## 
## Random effects:
##  Groups      Name        Variance Std.Dev.
##  dataID      (Intercept) 0.09827  0.3135  
##  plot:region (Intercept) 0.30747  0.5545  
##  year        (Intercept) 0.53787  0.7334  
##  region      (Intercept) 4.93934  2.2225  
##  technician  (Intercept) 4.05647  2.0141  
## Number of obs: 1000, groups:  
## dataID, 1000; plot:region, 50; year, 20; region, 10; technician, 5
## 
## Fixed effects:
##                      Estimate Std. Error z value Pr(>|z|)    
## (Intercept)        -15.951246   1.922383  -8.298  < 2e-16 ***
## precipitation       -1.078050   0.482841  -2.233   0.0256 *  
## I(precipitation^2)  -0.923718   0.482167  -1.916   0.0554 .  
## altitude             3.168354   5.189598   0.611   0.5415    
## I(altitude^2)        0.527792   4.885782   0.108   0.9140    
## temperature          2.320171   0.177148  13.097  < 2e-16 ***
## I(temperature^2)    -0.096116   0.008825 -10.892  < 2e-16 ***
## minTemp             -0.494232   0.066659  -7.414 1.22e-13 ***
## I(minTemp^2)        -0.045360   0.003591 -12.630  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##             (Intr) prcptt I(p^2) altitd I(l^2) tmprtr I(t^2) minTmp
## precipitatn -0.029                                                 
## I(prcptt^2)  0.016 -0.965                                          
## altitude    -0.535 -0.001  0.001                                   
## I(altitd^2)  0.360  0.011 -0.009 -0.924                            
## temperature -0.413 -0.048  0.063 -0.060  0.070                     
## I(tmprtr^2)  0.375  0.065 -0.071  0.068 -0.071 -0.985              
## minTemp      0.098 -0.003  0.030  0.016 -0.015  0.123 -0.151       
## I(minTmp^2)  0.091 -0.024  0.055  0.014 -0.014  0.111 -0.129  0.975
```

```r
plot(allEffects(fit))
```

![](DataAnalysis_files/figure-html/unnamed-chunk-4-1.png) 

OK, here we go. Parameter estimates are fine, results are that temp / minTemp are the things that matter. The forests were right!

If you want to compare to the true values, have a look at the Rmd file that creates the data. 


## Still todo

* Check for overdispersion and potentially correct overdispersion (I have corrected already though)
* Check for homogeneity of residuals, and for normality of the random effects

How to do both things are described in my lectures. I don't do them now because I know the true model and know that model assumptions are more or less met and that parameter estimates are fine




