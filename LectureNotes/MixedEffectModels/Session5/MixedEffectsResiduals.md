Digging deeper with mixed models: Residuals diagnostics
========================================================
author: Florian Hartig
date: 5th mixed model session, Jan 21, 2015

Reminder previous session
===
incremental: true

Mixed models add a random effect to the normal GLM structure

- Random intercept: $y_{obs} \sim ErrorDistr(mean = link (A \cdot X + b + R_i)$ 
- Random slope: $y_{obs} \sim ErrorDistr(mean = link (R_i * A \cdot X + b))$ 

**Random effect $R_i$** assigns a different value to each group $i$, but not independently (as for a fixed effects model), but from a common distribution

- $R_i \sim Norm(0, \sigma)$ 

for which we estimate the $\sigma$ (and the $R_i$ of course)

Example
===



To strengthen our understanding, let's again look at the school exam example from last time 


```r
?Exam
```

We have a data frame with 4059 observations of 9 variables, of which we use 

- normexam - Normalized exam score, **response**
- standLRT - Standardised LR test score, **main predictor**
- school - School ID - a grouping variable that could be a **random effect**


As a reminder
===

I will go through the four basic cases to show you the differences

1. School modifies the intercept (normexam):
  - school as **fixed main effect**
  - school as **random interecept** (mixed model)


2. School modifies the slope (influence of standLRT):
  - school as **fixed interaction**
  - school as **random slope** (mixed model)


Possibility 1: School -> Intercept
===

Assumption: in each school students are higher or lower in their normalized exam score, independently of standLRT

In this case, the options to include school are:

- as a **fixed main effect**, meaning that for each school we estimate an independent value
- as a **random intercept**, meaning that the values for each school are connected by the assumption that they come from a normal distribution



School as fixed main effect
===


<font size="5">

```r
fixedInterceptFit <- lm(normexam ~ standLRT + school)
summary(fixedInterceptFit)
```

```

Call:
lm(formula = normexam ~ standLRT + school)

Residuals:
     Min       1Q   Median       3Q      Max 
-2.83228 -0.47676  0.02203  0.50814  2.44103 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.4082385  0.0880526   4.636 3.66e-06 ***
standLRT     0.5594779  0.0125337  44.638  < 2e-16 ***
school2      0.1537866  0.1343209   1.145 0.252311    
school3      0.1595475  0.1365512   1.168 0.242712    
school4     -0.3859499  0.1221073  -3.161 0.001585 ** 
school5     -0.1224139  0.1546327  -0.792 0.428616    
school6      0.1795870  0.1218800   1.473 0.140702    
school7     -0.0005118  0.1190924  -0.004 0.996571    
school8     -0.4337545  0.1153318  -3.761 0.000172 ***
school9     -0.5673683  0.1563805  -3.628 0.000289 ***
school10    -0.7835226  0.1380668  -5.675 1.49e-08 ***
school11    -0.2063160  0.1300277  -1.587 0.112658    
school12    -0.4758272  0.1406744  -3.382 0.000725 ***
school13    -0.5704352  0.1288533  -4.427 9.81e-06 ***
school14    -0.5753049  0.1030043  -5.585 2.49e-08 ***
school15    -0.6000618  0.1181812  -5.077 4.00e-07 ***
school16    -0.8431824  0.1190835  -7.081 1.69e-12 ***
school17    -0.5875090  0.1106846  -5.308 1.17e-07 ***
school18    -0.4940792  0.1116375  -4.426 9.87e-06 ***
school19    -0.4171453  0.1343181  -3.106 0.001912 ** 
school20    -0.1559005  0.1492152  -1.045 0.296177    
school21    -0.1405215  0.1244911  -1.129 0.259064    
school22    -0.8715530  0.1185005  -7.355 2.31e-13 ***
school23    -1.0033807  0.1672701  -5.999 2.17e-09 ***
school24    -0.1633014  0.1519554  -1.075 0.282589    
school25    -0.6582337  0.1249089  -5.270 1.44e-07 ***
school26    -0.4338686  0.1240851  -3.497 0.000476 ***
school27    -0.3815602  0.1495135  -2.552 0.010747 *  
school28    -1.0829452  0.1330995  -8.136 5.39e-16 ***
school29    -0.1478872  0.1222762  -1.209 0.226561    
school30    -0.2231557  0.1456672  -1.532 0.125613    
school31    -0.3703082  0.1391440  -2.661 0.007814 ** 
school32    -0.4157803  0.1460205  -2.847 0.004430 ** 
school33    -0.3736028  0.1228682  -3.041 0.002376 ** 
school34    -0.5776973  0.1718983  -3.361 0.000785 ***
school35    -0.2568955  0.1504923  -1.707 0.087893 .  
school36    -0.6034717  0.1258602  -4.795 1.69e-06 ***
school37    -0.6506435  0.1832890  -3.550 0.000390 ***
school38    -0.5771481  0.1350807  -4.273 1.98e-05 ***
school39    -0.2596266  0.1398373  -1.857 0.063437 .  
school40    -0.6606137  0.1253841  -5.269 1.45e-07 ***
school41    -0.1737786  0.1311842  -1.325 0.185349    
school42    -0.3037701  0.1323526  -2.295 0.021776 *  
school43    -0.5031396  0.1305122  -3.855 0.000117 ***
school44    -0.7067652  0.1651695  -4.279 1.92e-05 ***
school45    -0.5290194  0.1357998  -3.896 9.96e-05 ***
school46    -0.7852315  0.1207449  -6.503 8.83e-11 ***
school47    -0.4522124  0.1210871  -3.735 0.000191 ***
school48    -0.5908627  0.5391081  -1.096 0.273145    
school49    -0.3606786  0.1129569  -3.193 0.001419 ** 
school50    -0.7336736  0.1245064  -5.893 4.11e-09 ***
school51    -0.4642052  0.1324828  -3.504 0.000464 ***
school52     0.0152930  0.1304698   0.117 0.906696    
school53     0.3824001  0.1258458   3.039 0.002392 ** 
school54    -1.3708767  0.2801532  -4.893 1.03e-06 ***
school55     0.1592890  0.1372666   1.160 0.245941    
school56    -0.3945975  0.1504825  -2.622 0.008769 ** 
school57    -0.3710961  0.1293684  -2.869 0.004146 ** 
school58    -0.2439919  0.1517816  -1.608 0.108019    
school59    -1.1523569  0.1409396  -8.176 3.89e-16 ***
school60    -0.1632161  0.1217786  -1.340 0.180234    
school61    -0.4492723  0.1288138  -3.488 0.000492 ***
school62    -0.4638973  0.1253640  -3.700 0.000218 ***
school63     0.2400429  0.1631093   1.472 0.141189    
school64    -0.3073389  0.1317113  -2.333 0.019675 *  
school65    -0.5852525  0.1218406  -4.803 1.62e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7521 on 3993 degrees of freedom
Multiple R-squared:  0.4422,	Adjusted R-squared:  0.4331 
F-statistic:  48.7 on 65 and 3993 DF,  p-value: < 2.2e-16
```
</font>

Distribution of estimates for school
===

<img src="MixedEffectsResiduals-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


School as random intercept
===

<font size="5">

```r
randomInterceptFit <- lmer(normexam ~ standLRT + (1 | school))
summary(randomInterceptFit)
```

```
Linear mixed model fit by REML t-tests use Satterthwaite approximations
  to degrees of freedom [merModLmerTest]
Formula: normexam ~ standLRT + (1 | school)

REML criterion at convergence: 9368.8

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.7166 -0.6302  0.0294  0.6849  3.2673 

Random effects:
 Groups   Name        Variance Std.Dev.
 school   (Intercept) 0.09384  0.3063  
 Residual             0.56587  0.7522  
Number of obs: 4059, groups:  school, 65

Fixed effects:
             Estimate Std. Error        df t value Pr(>|t|)    
(Intercept) 2.323e-03  4.035e-02 6.100e+01   0.058    0.954    
standLRT    5.633e-01  1.247e-02 4.050e+03  45.180   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr)
standLRT 0.008 
```
Note the comments about "REML t-tests use Satterthwaite approximations" --> this is because I have loaded the lmerTest package
</font>

Distribution of estimates for school
===

<img src="MixedEffectsResiduals-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

Comparison fixed and random intercepts
===

<font size="5">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

```
[1] 0.3341748
```

```

	Shapiro-Wilk normality test

data:  coef[3:66]
W = 0.9806, p-value = 0.4098
```
</font>

***

<font size="5">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

```
[1] 0.2883856
```

```

	Shapiro-Wilk normality test

data:  randcoef
W = 0.9849, p-value = 0.6156
```
</font>


Comparison parameter estimates 
===

<font size="4">

```r
summary(fixedInterceptFit)
```

```

Call:
lm(formula = normexam ~ standLRT + school)

Residuals:
     Min       1Q   Median       3Q      Max 
-2.83228 -0.47676  0.02203  0.50814  2.44103 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.4082385  0.0880526   4.636 3.66e-06 ***
standLRT     0.5594779  0.0125337  44.638  < 2e-16 ***
school2      0.1537866  0.1343209   1.145 0.252311    
school3      0.1595475  0.1365512   1.168 0.242712    
school4     -0.3859499  0.1221073  -3.161 0.001585 ** 
school5     -0.1224139  0.1546327  -0.792 0.428616    
school6      0.1795870  0.1218800   1.473 0.140702    
school7     -0.0005118  0.1190924  -0.004 0.996571    
school8     -0.4337545  0.1153318  -3.761 0.000172 ***
school9     -0.5673683  0.1563805  -3.628 0.000289 ***
school10    -0.7835226  0.1380668  -5.675 1.49e-08 ***
school11    -0.2063160  0.1300277  -1.587 0.112658    
school12    -0.4758272  0.1406744  -3.382 0.000725 ***
school13    -0.5704352  0.1288533  -4.427 9.81e-06 ***
school14    -0.5753049  0.1030043  -5.585 2.49e-08 ***
school15    -0.6000618  0.1181812  -5.077 4.00e-07 ***
school16    -0.8431824  0.1190835  -7.081 1.69e-12 ***
school17    -0.5875090  0.1106846  -5.308 1.17e-07 ***
school18    -0.4940792  0.1116375  -4.426 9.87e-06 ***
school19    -0.4171453  0.1343181  -3.106 0.001912 ** 
school20    -0.1559005  0.1492152  -1.045 0.296177    
school21    -0.1405215  0.1244911  -1.129 0.259064    
school22    -0.8715530  0.1185005  -7.355 2.31e-13 ***
school23    -1.0033807  0.1672701  -5.999 2.17e-09 ***
school24    -0.1633014  0.1519554  -1.075 0.282589    
school25    -0.6582337  0.1249089  -5.270 1.44e-07 ***
school26    -0.4338686  0.1240851  -3.497 0.000476 ***
school27    -0.3815602  0.1495135  -2.552 0.010747 *  
school28    -1.0829452  0.1330995  -8.136 5.39e-16 ***
school29    -0.1478872  0.1222762  -1.209 0.226561    
school30    -0.2231557  0.1456672  -1.532 0.125613    
school31    -0.3703082  0.1391440  -2.661 0.007814 ** 
school32    -0.4157803  0.1460205  -2.847 0.004430 ** 
school33    -0.3736028  0.1228682  -3.041 0.002376 ** 
school34    -0.5776973  0.1718983  -3.361 0.000785 ***
school35    -0.2568955  0.1504923  -1.707 0.087893 .  
school36    -0.6034717  0.1258602  -4.795 1.69e-06 ***
school37    -0.6506435  0.1832890  -3.550 0.000390 ***
school38    -0.5771481  0.1350807  -4.273 1.98e-05 ***
school39    -0.2596266  0.1398373  -1.857 0.063437 .  
school40    -0.6606137  0.1253841  -5.269 1.45e-07 ***
school41    -0.1737786  0.1311842  -1.325 0.185349    
school42    -0.3037701  0.1323526  -2.295 0.021776 *  
school43    -0.5031396  0.1305122  -3.855 0.000117 ***
school44    -0.7067652  0.1651695  -4.279 1.92e-05 ***
school45    -0.5290194  0.1357998  -3.896 9.96e-05 ***
school46    -0.7852315  0.1207449  -6.503 8.83e-11 ***
school47    -0.4522124  0.1210871  -3.735 0.000191 ***
school48    -0.5908627  0.5391081  -1.096 0.273145    
school49    -0.3606786  0.1129569  -3.193 0.001419 ** 
school50    -0.7336736  0.1245064  -5.893 4.11e-09 ***
school51    -0.4642052  0.1324828  -3.504 0.000464 ***
school52     0.0152930  0.1304698   0.117 0.906696    
school53     0.3824001  0.1258458   3.039 0.002392 ** 
school54    -1.3708767  0.2801532  -4.893 1.03e-06 ***
school55     0.1592890  0.1372666   1.160 0.245941    
school56    -0.3945975  0.1504825  -2.622 0.008769 ** 
school57    -0.3710961  0.1293684  -2.869 0.004146 ** 
school58    -0.2439919  0.1517816  -1.608 0.108019    
school59    -1.1523569  0.1409396  -8.176 3.89e-16 ***
school60    -0.1632161  0.1217786  -1.340 0.180234    
school61    -0.4492723  0.1288138  -3.488 0.000492 ***
school62    -0.4638973  0.1253640  -3.700 0.000218 ***
school63     0.2400429  0.1631093   1.472 0.141189    
school64    -0.3073389  0.1317113  -2.333 0.019675 *  
school65    -0.5852525  0.1218406  -4.803 1.62e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7521 on 3993 degrees of freedom
Multiple R-squared:  0.4422,	Adjusted R-squared:  0.4331 
F-statistic:  48.7 on 65 and 3993 DF,  p-value: < 2.2e-16
```
</font>

***

<font size="4">

```r
summary(randomInterceptFit) 
```

```
Linear mixed model fit by REML t-tests use Satterthwaite approximations
  to degrees of freedom [merModLmerTest]
Formula: normexam ~ standLRT + (1 | school)

REML criterion at convergence: 9368.8

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.7166 -0.6302  0.0294  0.6849  3.2673 

Random effects:
 Groups   Name        Variance Std.Dev.
 school   (Intercept) 0.09384  0.3063  
 Residual             0.56587  0.7522  
Number of obs: 4059, groups:  school, 65

Fixed effects:
             Estimate Std. Error        df t value Pr(>|t|)    
(Intercept) 2.323e-03  4.035e-02 6.100e+01   0.058    0.954    
standLRT    5.633e-01  1.247e-02 4.050e+03  45.180   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr)
standLRT 0.008 
```
</font>

Conclusion: variance slightly different, parameter estimates pretty much the same


Possibility 2: School -> Slope
===

Assumption: in each school, the effect of standLRT on normalized exam score is different

In this case, the options are to include school:

- as an **interaction**, meaning that for each school, we estimate an independent different value for the effect of standLRT
- as a **random slope**, meaning that the different standLRT values for each school are connected by the assumption that they come from a normal distribution

School as a (fixed) interaction
===


<font size="5">

```r
fixedInteractionFit <- lm(normexam ~ standLRT + standLRT:school)

summary(fixedInteractionFit)
```

```

Call:
lm(formula = normexam ~ standLRT + standLRT:school)

Residuals:
     Min       1Q   Median       3Q      Max 
-2.57843 -0.51139  0.01953  0.53810  3.13190 

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)       -1.919e-02  1.302e-02  -1.474 0.140609    
standLRT           7.680e-01  8.665e-02   8.863  < 2e-16 ***
standLRT:school2   1.343e-01  1.248e-01   1.075 0.282256    
standLRT:school3   9.859e-02  1.385e-01   0.712 0.476475    
standLRT:school4  -4.514e-03  1.236e-01  -0.037 0.970874    
standLRT:school5   2.061e-02  2.011e-01   0.102 0.918381    
standLRT:school6   1.211e-01  1.204e-01   1.006 0.314548    
standLRT:school7  -5.417e-01  1.297e-01  -4.175 3.04e-05 ***
standLRT:school8  -2.004e-01  1.122e-01  -1.786 0.074240 .  
standLRT:school9  -2.972e-01  1.393e-01  -2.134 0.032872 *  
standLRT:school10 -5.708e-01  1.691e-01  -3.376 0.000744 ***
standLRT:school11 -1.752e-01  1.224e-01  -1.431 0.152511    
standLRT:school12 -2.905e-01  1.632e-01  -1.780 0.075186 .  
standLRT:school13 -1.252e-01  1.283e-01  -0.976 0.329314    
standLRT:school14 -2.183e-01  1.044e-01  -2.092 0.036535 *  
standLRT:school15 -1.161e-01  1.307e-01  -0.888 0.374597    
standLRT:school16 -5.110e-01  1.284e-01  -3.978 7.06e-05 ***
standLRT:school17 -2.527e-01  1.093e-01  -2.312 0.020822 *  
standLRT:school18 -4.209e-01  1.389e-01  -3.031 0.002451 ** 
standLRT:school19 -2.852e-02  1.654e-01  -0.172 0.863098    
standLRT:school20 -1.424e-01  1.446e-01  -0.985 0.324689    
standLRT:school21 -1.447e-01  1.329e-01  -1.089 0.276430    
standLRT:school22 -2.163e-01  1.179e-01  -1.834 0.066750 .  
standLRT:school23 -2.388e-01  1.639e-01  -1.457 0.145150    
standLRT:school24 -4.495e-01  1.545e-01  -2.909 0.003649 ** 
standLRT:school25 -1.300e-01  1.148e-01  -1.132 0.257717    
standLRT:school26 -2.159e-01  1.181e-01  -1.827 0.067730 .  
standLRT:school27 -2.208e-01  1.394e-01  -1.584 0.113337    
standLRT:school28 -1.930e-01  1.399e-01  -1.379 0.168010    
standLRT:school29 -4.496e-01  1.257e-01  -3.577 0.000352 ***
standLRT:school30  6.499e-02  1.355e-01   0.479 0.631629    
standLRT:school31 -3.519e-01  1.601e-01  -2.198 0.027980 *  
standLRT:school32 -1.348e-01  1.287e-01  -1.048 0.294927    
standLRT:school33 -2.568e-01  1.385e-01  -1.853 0.063902 .  
standLRT:school34 -2.024e-02  1.416e-01  -0.143 0.886327    
standLRT:school35 -4.021e-01  1.879e-01  -2.140 0.032408 *  
standLRT:school36 -3.166e-01  1.182e-01  -2.679 0.007412 ** 
standLRT:school37 -3.291e-01  1.540e-01  -2.137 0.032664 *  
standLRT:school38 -1.218e-01  1.314e-01  -0.927 0.354163    
standLRT:school39 -3.381e-01  1.330e-01  -2.541 0.011082 *  
standLRT:school40 -3.899e-02  1.247e-01  -0.313 0.754576    
standLRT:school41 -3.539e-01  1.353e-01  -2.615 0.008958 ** 
standLRT:school42 -3.739e-01  1.501e-01  -2.491 0.012777 *  
standLRT:school43 -1.199e-01  1.436e-01  -0.835 0.403952    
standLRT:school44 -3.304e-01  1.617e-01  -2.044 0.041065 *  
standLRT:school45 -1.821e-01  1.414e-01  -1.287 0.198073    
standLRT:school46 -2.380e-01  1.296e-01  -1.837 0.066315 .  
standLRT:school47 -1.007e-01  1.339e-01  -0.752 0.452109    
standLRT:school48  1.087e-01  1.346e+00   0.081 0.935653    
standLRT:school49 -2.836e-01  1.210e-01  -2.343 0.019165 *  
standLRT:school50 -9.472e-02  1.280e-01  -0.740 0.459353    
standLRT:school51 -3.929e-01  1.238e-01  -3.172 0.001523 ** 
standLRT:school52  4.597e-02  1.302e-01   0.353 0.724011    
standLRT:school53  5.404e-01  1.279e-01   4.224 2.45e-05 ***
standLRT:school54 -1.286e+00  3.514e-01  -3.660 0.000256 ***
standLRT:school55 -6.381e-05  1.377e-01   0.000 0.999630    
standLRT:school56  9.874e-02  1.707e-01   0.578 0.563122    
standLRT:school57 -1.599e-01  1.362e-01  -1.174 0.240268    
standLRT:school58 -3.511e-01  1.709e-01  -2.055 0.039940 *  
standLRT:school59 -2.066e-02  1.373e-01  -0.150 0.880391    
standLRT:school60 -1.599e-01  1.309e-01  -1.221 0.222163    
standLRT:school61 -1.319e-01  1.325e-01  -0.996 0.319551    
standLRT:school62 -2.314e-01  1.455e-01  -1.591 0.111642    
standLRT:school63 -2.478e-01  2.080e-01  -1.191 0.233670    
standLRT:school64 -3.988e-02  1.313e-01  -0.304 0.761371    
standLRT:school65 -1.665e-01  1.207e-01  -1.379 0.167984    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7902 on 3993 degrees of freedom
Multiple R-squared:  0.3843,	Adjusted R-squared:  0.3743 
F-statistic: 38.34 on 65 and 3993 DF,  p-value: < 2.2e-16
```
</font>

Distribution of estimates for school
===

<img src="MixedEffectsResiduals-figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />


School as random slope
===

<font size="5">


```r
randomSlopeFit <- lmer(normexam ~ standLRT + (0 + standLRT | school))
summary(randomSlopeFit)
```

```
Linear mixed model fit by REML t-tests use Satterthwaite approximations
  to degrees of freedom [merModLmerTest]
Formula: normexam ~ standLRT + (0 + standLRT | school)

REML criterion at convergence: 9700.6

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.2793 -0.6501  0.0241  0.6833  3.9119 

Random effects:
 Groups   Name     Variance Std.Dev.
 school   standLRT 0.0259   0.1609  
 Residual          0.6251   0.7906  
Number of obs: 4059, groups:  school, 65

Fixed effects:
              Estimate Std. Error         df t value Pr(>|t|)    
(Intercept)   -0.01463    0.01284 4019.00000  -1.139    0.255    
standLRT       0.58782    0.02423   58.00000  24.256   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr)
standLRT 0.000 
```
</font>

Distribution of estimates for school
===

<img src="MixedEffectsResiduals-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" style="display: block; margin: auto;" />

Comparison interaction and random slope effects for school
===

<font size="5">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />

```
[1] 0.2355594
```

```

	Shapiro-Wilk normality test

data:  coef[3:66]
W = 0.8915, p-value = 3.897e-05
```
</font>

***

<font size="5">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" style="display: block; margin: auto;" />

```
[1] 0.1324982
```

```

	Shapiro-Wilk normality test

data:  randcoef
W = 0.9521, p-value = 0.01344
```
</font>


Comparison parameter estimates 
===

<font size="4">

```r
summary(fixedInteractionFit)
```

```

Call:
lm(formula = normexam ~ standLRT + standLRT:school)

Residuals:
     Min       1Q   Median       3Q      Max 
-2.57843 -0.51139  0.01953  0.53810  3.13190 

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)       -1.919e-02  1.302e-02  -1.474 0.140609    
standLRT           7.680e-01  8.665e-02   8.863  < 2e-16 ***
standLRT:school2   1.343e-01  1.248e-01   1.075 0.282256    
standLRT:school3   9.859e-02  1.385e-01   0.712 0.476475    
standLRT:school4  -4.514e-03  1.236e-01  -0.037 0.970874    
standLRT:school5   2.061e-02  2.011e-01   0.102 0.918381    
standLRT:school6   1.211e-01  1.204e-01   1.006 0.314548    
standLRT:school7  -5.417e-01  1.297e-01  -4.175 3.04e-05 ***
standLRT:school8  -2.004e-01  1.122e-01  -1.786 0.074240 .  
standLRT:school9  -2.972e-01  1.393e-01  -2.134 0.032872 *  
standLRT:school10 -5.708e-01  1.691e-01  -3.376 0.000744 ***
standLRT:school11 -1.752e-01  1.224e-01  -1.431 0.152511    
standLRT:school12 -2.905e-01  1.632e-01  -1.780 0.075186 .  
standLRT:school13 -1.252e-01  1.283e-01  -0.976 0.329314    
standLRT:school14 -2.183e-01  1.044e-01  -2.092 0.036535 *  
standLRT:school15 -1.161e-01  1.307e-01  -0.888 0.374597    
standLRT:school16 -5.110e-01  1.284e-01  -3.978 7.06e-05 ***
standLRT:school17 -2.527e-01  1.093e-01  -2.312 0.020822 *  
standLRT:school18 -4.209e-01  1.389e-01  -3.031 0.002451 ** 
standLRT:school19 -2.852e-02  1.654e-01  -0.172 0.863098    
standLRT:school20 -1.424e-01  1.446e-01  -0.985 0.324689    
standLRT:school21 -1.447e-01  1.329e-01  -1.089 0.276430    
standLRT:school22 -2.163e-01  1.179e-01  -1.834 0.066750 .  
standLRT:school23 -2.388e-01  1.639e-01  -1.457 0.145150    
standLRT:school24 -4.495e-01  1.545e-01  -2.909 0.003649 ** 
standLRT:school25 -1.300e-01  1.148e-01  -1.132 0.257717    
standLRT:school26 -2.159e-01  1.181e-01  -1.827 0.067730 .  
standLRT:school27 -2.208e-01  1.394e-01  -1.584 0.113337    
standLRT:school28 -1.930e-01  1.399e-01  -1.379 0.168010    
standLRT:school29 -4.496e-01  1.257e-01  -3.577 0.000352 ***
standLRT:school30  6.499e-02  1.355e-01   0.479 0.631629    
standLRT:school31 -3.519e-01  1.601e-01  -2.198 0.027980 *  
standLRT:school32 -1.348e-01  1.287e-01  -1.048 0.294927    
standLRT:school33 -2.568e-01  1.385e-01  -1.853 0.063902 .  
standLRT:school34 -2.024e-02  1.416e-01  -0.143 0.886327    
standLRT:school35 -4.021e-01  1.879e-01  -2.140 0.032408 *  
standLRT:school36 -3.166e-01  1.182e-01  -2.679 0.007412 ** 
standLRT:school37 -3.291e-01  1.540e-01  -2.137 0.032664 *  
standLRT:school38 -1.218e-01  1.314e-01  -0.927 0.354163    
standLRT:school39 -3.381e-01  1.330e-01  -2.541 0.011082 *  
standLRT:school40 -3.899e-02  1.247e-01  -0.313 0.754576    
standLRT:school41 -3.539e-01  1.353e-01  -2.615 0.008958 ** 
standLRT:school42 -3.739e-01  1.501e-01  -2.491 0.012777 *  
standLRT:school43 -1.199e-01  1.436e-01  -0.835 0.403952    
standLRT:school44 -3.304e-01  1.617e-01  -2.044 0.041065 *  
standLRT:school45 -1.821e-01  1.414e-01  -1.287 0.198073    
standLRT:school46 -2.380e-01  1.296e-01  -1.837 0.066315 .  
standLRT:school47 -1.007e-01  1.339e-01  -0.752 0.452109    
standLRT:school48  1.087e-01  1.346e+00   0.081 0.935653    
standLRT:school49 -2.836e-01  1.210e-01  -2.343 0.019165 *  
standLRT:school50 -9.472e-02  1.280e-01  -0.740 0.459353    
standLRT:school51 -3.929e-01  1.238e-01  -3.172 0.001523 ** 
standLRT:school52  4.597e-02  1.302e-01   0.353 0.724011    
standLRT:school53  5.404e-01  1.279e-01   4.224 2.45e-05 ***
standLRT:school54 -1.286e+00  3.514e-01  -3.660 0.000256 ***
standLRT:school55 -6.381e-05  1.377e-01   0.000 0.999630    
standLRT:school56  9.874e-02  1.707e-01   0.578 0.563122    
standLRT:school57 -1.599e-01  1.362e-01  -1.174 0.240268    
standLRT:school58 -3.511e-01  1.709e-01  -2.055 0.039940 *  
standLRT:school59 -2.066e-02  1.373e-01  -0.150 0.880391    
standLRT:school60 -1.599e-01  1.309e-01  -1.221 0.222163    
standLRT:school61 -1.319e-01  1.325e-01  -0.996 0.319551    
standLRT:school62 -2.314e-01  1.455e-01  -1.591 0.111642    
standLRT:school63 -2.478e-01  2.080e-01  -1.191 0.233670    
standLRT:school64 -3.988e-02  1.313e-01  -0.304 0.761371    
standLRT:school65 -1.665e-01  1.207e-01  -1.379 0.167984    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7902 on 3993 degrees of freedom
Multiple R-squared:  0.3843,	Adjusted R-squared:  0.3743 
F-statistic: 38.34 on 65 and 3993 DF,  p-value: < 2.2e-16
```
</font>

***

<font size="4">

```r
summary(randomSlopeFit) 
```

```
Linear mixed model fit by REML t-tests use Satterthwaite approximations
  to degrees of freedom [merModLmerTest]
Formula: normexam ~ standLRT + (0 + standLRT | school)

REML criterion at convergence: 9700.6

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.2793 -0.6501  0.0241  0.6833  3.9119 

Random effects:
 Groups   Name     Variance Std.Dev.
 school   standLRT 0.0259   0.1609  
 Residual          0.6251   0.7906  
Number of obs: 4059, groups:  school, 65

Fixed effects:
              Estimate Std. Error         df t value Pr(>|t|)    
(Intercept)   -0.01463    0.01284 4019.00000  -1.139    0.255    
standLRT       0.58782    0.02423   58.00000  24.256   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr)
standLRT 0.000 
```

Note that we can't directly compare the standLRT in this case because the interaction shifts the estimate due to the fact that the effect of schools is calculated relative to the first school!

</font>




Obvious question
===

Which of the four models should we use?

- All are sensible 
- All predict a significant effect of standLRT
- **But with different p-values and different effect sizes**

What to do?

- **Model diagnostics** to detect problems in the model specification
  - We saw already a problem (randon slope not normal!)
- **Model selection** on the random effect structure (in two weeks)

Some more things to consider
===

In this short repetition, we were only considering independent random effects

- Last lecture, I have mentioned already the difference between **crossed** and **nested** random effects, which is that
  - crossed = independent random terms, usually also means that the terms appear in a factorial design
  - nested = A is nested in B if all subgroups of A appear only in one subgroup of B

- Lots of possibilities to modify the **variance-covariance structure** in the random effects (covariance between fixed and random effects, but also covariance within the random effects like in a GLS)


But today: Model Diagnostics
=== 

Each model makes assumptions about

- The mean value of the response as a function of the predictors
- The stochasticity (error) around this mean value
  
Model diagnostics (or residual diagnostics) means that we check whether the observed residuals (residual = data - model prediction) are in line with the model assumptions


New Dataset
===




Measured beetle counts over 20 years on 50 different plots across an altitudinal gradient, with the predictors moisture (varying from year to year) and altitude (fix for each plot)

<font size="5">

```r
head(data)
```

```
  dataID beetles  moisture altitude plot year
1      1       9 0.1848823        0    1    1
2      2      54 0.7023740        0    1    2
3      3       8 0.5733263        0    1    3
4      4       3 0.1680519        0    1    4
5      5      53 0.9438393        0    1    5
6      6      38 0.9434750        0    1    6
```

```r
str(data)
```

```
'data.frame':	1000 obs. of  6 variables:
 $ dataID  : int  1 2 3 4 5 6 7 8 9 10 ...
 $ beetles : int  9 54 8 3 53 38 5 114 4 22 ...
 $ moisture: num  0.185 0.702 0.573 0.168 0.944 ...
 $ altitude: num  0 0 0 0 0 0 0 0 0 0 ...
 $ plot    : int  1 1 1 1 1 1 1 1 1 1 ...
 $ year    : int  1 2 3 4 5 6 7 8 9 10 ...
```
</font>

Univariate environmental responses
===

<font size="6">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-22-1.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" style="display: block; margin: auto;" />
</font>

Plot and year
===

<font size="6">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />
</font>

How do we model this?
===

Error distribution

- Poisson

Fixed effects
- moisture
- altitude

Random effects

- plot
- year

A first try
===

<font size="5">

```r
fit1 <- glmer(beetles ~ moisture + altitude + (1|year) + (1|plot), family = "poisson")
summary(fit1)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + (1 | year) + (1 | plot)

     AIC      BIC   logLik deviance df.resid 
 11151.7  11176.2  -5570.8  11141.7      995 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-8.4045 -1.1974 -0.0908  1.4036 19.1910 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 1.4196   1.191   
 year   (Intercept) 0.8855   0.941   
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  2.33473    0.30745    7.59 3.11e-14 ***
moisture     2.53364    0.01522  166.49  < 2e-16 ***
altitude    -0.88863    0.29347   -3.03  0.00246 ** 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr) moistr
moisture -0.058       
altitude -0.479  0.052
```
</font>

Note: centering is usually good 
===

<font size="4">

Correlations are strongly reduced by centering, algorithms converge better through scaling.


```r
altitude <- scale(altitude, center = F, scale = F)
moisture <- scale(moisture, center = T, scale = F)
fit1 <- glmer(beetles ~ moisture + altitude + (1|year) + (1|plot), family = "poisson")
summary(fit1)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + (1 | year) + (1 | plot)

     AIC      BIC   logLik deviance df.resid 
 11151.7  11176.2  -5570.8  11141.7      995 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-8.4045 -1.1974 -0.0908  1.4036 19.1910 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 1.4196   1.191   
 year   (Intercept) 0.8855   0.941   
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  3.59663    0.30706   11.71  < 2e-16 ***
moisture     2.53364    0.01522  166.49  < 2e-16 ***
altitude    -0.88865    0.29345   -3.03  0.00246 ** 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr) moistr
moisture -0.034       
altitude -0.478  0.052
```

I just didn't center and scale everything here because I want to compare to my original parameters later.

For a real example, you will likely really have to scale, because lme4 gets numerical problems otherwise!

</font>




Let's look at the residual first
===

lme4 has a function to plot residuals, for details see help


```r
?plot.merMod
```


```r
## S3 method for class 'merMod'
plot(x, form = resid(., type = "pearson") ~ fitted(.), abline, id = NULL, idLabels = NULL, grid, ...)
```

Btw, what are pearson residuals?
===

- For lm(), the error is iid normal, which implies constant variance 
  - For heteroskedasticity and misfit, we can therefore look at the normal residuals 
  - To see whether the normality assumptions holds, we can do qq-plots

- For poisson or logistic errors, variance is not constant, it doesn't make sense to look at absolute residuals
  - Pearson residuals divide the observed residual against the expected variance at the fitted point
  - Residual variance should now be constant, but the shape doesn't need to be normal and can change 
  

However
===

<font size="6">

The pearson residuals standardize to the top error structure (in our example Poisson). They don't properly standardize variance that comes from the random effect components. E.g.


```r
treatment = c(rep(2, 1000), rep(4, 1000))
group = rep(1:10, each = 200)
groupRandom = rnorm(10, sd = 1)
resp = rpois(2000, exp(treatment + groupRandom[group]))
treatment <- as.factor(treatment)
```
</font>

***

<font size="6">

```r
plot(glmer(resp ~ treatment + (1|group) , family = "poisson"))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-29-1.png" title="plot of chunk unnamed-chunk-29" alt="plot of chunk unnamed-chunk-29" style="display: block; margin: auto;" />
</font>

Now with strong overdispersion
===


<font size="6">

```r
treatment = c(rep(2, 1000), rep(4, 1000))
group = rep(1:10, each = 200)
groupRandom = rnorm(10, sd = 1)
resp = rpois(2000, exp(treatment + groupRandom[group] + rnorm(2000, sd = 0.5)))
ID = 1:2000
treatment <- as.factor(treatment)
```
Overdispersion is introduced and corrected here via a random term on each data point (1|ID)
</font>

***

<font size="6">

```r
testFit <- glmer(resp ~ treatment + (1|group) + (1|ID) , family = "poisson")
plot(testFit)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-31-1.png" title="plot of chunk unnamed-chunk-31" alt="plot of chunk unnamed-chunk-31" style="display: block; margin: auto;" />
</font>

Simulation
===

<font size="6">

```r
simulatedResiduals <- function(fittedModel){
  results <- simulate(fittedModel, nsim = 500)
  results <- data.matrix(results)
  ecdf.p <- numeric(1000)
  for (i in 1:1000){
    ecdf.p[i] <- ecdf(results[i,])(beetles[i])
  }
  return(ecdf.p)
}
residuals <- simulatedResiduals(testFit)
```
This returns, for each data point, the quantile of the data point for the simulated distribution of residuals.

</font>

Plot of the simulated residuals
===


<font size="5">

Overall - note that our expectation would be flat


```r
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-33-1.png" title="plot of chunk unnamed-chunk-33" alt="plot of chunk unnamed-chunk-33" style="display: block; margin: auto;" />
</font>

***

<font size="5">

As a function of the predicted value - not that our expectation would be flat in y-direction, but not neccessarily in x direction


```r
plot(log(sort(fitted(testFit))), residuals[order(fitted(testFit))], pch = 3)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-34-1.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" style="display: block; margin: auto;" />
</font>

Summary simulation
===

<font size="5">

We are fitting the correct model - it should look good in the simulation. I does look a lot better than for the Pearson residuals, but there are some deviations. I think the problem is that random effect estimates are very instable! Original values were 1 for plot and 0.5 for ID. I ran this several times, the values for the random effects vary strongly. Doing the simulation with parameter uncertainty (this is often called the Bayesian p-value) might solve this problem. 
</font>

***

<font size="4">

```r
summary(testFit)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: resp ~ treatment + (1 | group) + (1 | ID)

     AIC      BIC   logLik deviance df.resid 
 17123.3  17145.7  -8557.6  17115.3     1996 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-1.95587 -0.26958 -0.01417  0.15566  1.49448 

Random effects:
 Groups Name        Variance Std.Dev.
 ID     (Intercept) 0.2317   0.4813  
 group  (Intercept) 2.0110   1.4181  
Number of obs: 2000, groups:  ID, 2000; group, 10

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   2.5152     0.6351   3.960 7.49e-05 ***
treatment4    1.8232     0.8988   2.029   0.0425 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
           (Intr)
treatment4 -0.708
```
</font>


Conclusion Person / simulated residuals
===

Careful with the interpreation of Pearson residuals, specially of heteroskedasticity, for complicated random effect structures.

In general, it may be that the true model shows a bit of overdispersion or structure in the residuals due to the more "shaky" nature of the random effect estimates.

- Will be a topic in the next lecture on model selection

OK, but now back to our example
  
  

Residuals against fitted values
===


<font size="6">

```r
plot(fit1, form = resid(., type = "pearson") ~ log(fitted(.)))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-36-1.png" title="plot of chunk unnamed-chunk-36" alt="plot of chunk unnamed-chunk-36" style="display: block; margin: auto;" />

Definitely overdispersion (values tend to exceed 2)
</font>

Residuals against moisture and altitude
===

<font size="6">

```r
plot(fit1, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-37-1.png" title="plot of chunk unnamed-chunk-37" alt="plot of chunk unnamed-chunk-37" style="display: block; margin: auto;" />
</font>

***

<font size="6">

```r
plot(fit1, resid(.) ~ altitude, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-38-1.png" title="plot of chunk unnamed-chunk-38" alt="plot of chunk unnamed-chunk-38" style="display: block; margin: auto;" />
Observation - variance increases in the middle.
</font>



Add a quadratic effect for altitude
===
  
<font size="5">

```r
fit2 <- glmer(beetles ~ moisture + altitude + I(altitude^2) + (1|year) + (1|plot), family = "poisson")
summary(fit2)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + I(altitude^2) + (1 | year) +  
    (1 | plot)

     AIC      BIC   logLik deviance df.resid 
 10980.6  11010.0  -5484.3  10968.6      994 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-8.6101 -1.2006 -0.0609  1.3357 19.1863 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5611   0.7490  
 year   (Intercept) 0.8769   0.9364  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
               Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.61552    0.29674    5.44  5.2e-08 ***
moisture        2.53586    0.01522  166.59  < 2e-16 ***
altitude       10.43755    0.82552   12.64  < 2e-16 ***
I(altitude^2) -10.76786    0.76407  -14.09  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.031              
altitude    -0.552  0.021       
I(altitd^2)  0.449 -0.009 -0.954
```
</font>
  
Residuals against moisture and altitude
===
  
<font size="6">

```r
plot(fit2, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-40-1.png" title="plot of chunk unnamed-chunk-40" alt="plot of chunk unnamed-chunk-40" style="display: block; margin: auto;" />
</font>
  
  ***
  
  <font size="6">
  
  ```r
  plot(fit2, resid(.) ~ altitude, abline = 0)
  ```
  
  <img src="MixedEffectsResiduals-figure/unnamed-chunk-41-1.png" title="plot of chunk unnamed-chunk-41" alt="plot of chunk unnamed-chunk-41" style="display: block; margin: auto;" />
</font>
  
  
  
What's going on?
===

<font size="6">

OK, so the quadratic effect is very significantly supported, but the overdispersion around the mean altitudues is not much better. Could it be that we simply have a general overdispersion phenomenon here, that is more visible for the places where there are lots of beetles?


```r
plot(fit2, form = resid(., type = "pearson") ~ log(fitted(.)))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-42-1.png" title="plot of chunk unnamed-chunk-42" alt="plot of chunk unnamed-chunk-42" style="display: block; margin: auto;" />
</font>

Checking for overdispersion
====

<font size="5">

Here, it's obvious that we have a lot of overdispersion in the model, but if you want to prove it a quick and dirty parametric way approximation comes from http://glmm.wikidot.com/faq . This is quick and dirty. It may be more efficient to work with simualations, as I showed before. 


```r
overdisp_fun <- function(model) {
  ## number of variance parameters in 
  ##   an n-by-n variance-covariance matrix
  vpars <- function(m) {
    nrow(m)*(nrow(m)+1)/2
  }
  model.df <- sum(sapply(VarCorr(model),vpars))+length(fixef(model))
  rdf <- nrow(model.frame(model))-model.df
  rp <- residuals(model,type="pearson")
  Pearson.chisq <- sum(rp^2)
  prat <- Pearson.chisq/rdf
  pval <- pchisq(Pearson.chisq, df=rdf, lower.tail=FALSE)
  c(chisq=Pearson.chisq,ratio=prat,rdf=rdf,p=pval)
}
overdisp_fun(fit2)
```

```
      chisq       ratio         rdf           p 
7243.064617    7.286785  994.000000    0.000000 
```
</font>
  
OK, so let's add an overdispersion term
===

<font size="5">

```r
fit3 <- glmer(beetles ~ moisture + altitude + I(altitude^2) + (1|year) + (1|plot) + (1|dataID), family = "poisson")
summary(fit3)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + I(altitude^2) + (1 | year) +  
    (1 | plot) + (1 | dataID)

     AIC      BIC   logLik deviance df.resid 
  8151.7   8186.1  -4068.9   8137.7      993 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-1.9779 -0.3468 -0.0042  0.1807  4.4283 

Random effects:
 Groups Name        Variance Std.Dev.
 dataID (Intercept) 0.1403   0.3746  
 plot   (Intercept) 0.5361   0.7322  
 year   (Intercept) 0.6077   0.7795  
Number of obs: 1000, groups:  dataID, 1000; plot, 50; year, 20

Fixed effects:
               Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.51618    0.31609    4.80 1.61e-06 ***
moisture        1.94781    0.05004   38.93  < 2e-16 ***
altitude       10.59323    1.15418    9.18  < 2e-16 ***
I(altitude^2) -10.51809    1.10659   -9.50  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.018              
altitude    -0.682  0.021       
I(altitd^2)  0.551 -0.022 -0.957
```
</font>

Residual plot for GLMM Poisson with overdisp
===

<font size="6">

```r
plot(fit3, form = resid(., type = "pearson") ~ log(fitted(.)))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-45-1.png" title="plot of chunk unnamed-chunk-45" alt="plot of chunk unnamed-chunk-45" style="display: block; margin: auto;" />

```r
overdisp_fun(fit3)
```

```
      chisq       ratio         rdf           p 
390.8373274   0.3935925 993.0000000   1.0000000 
```
</font>

Residuals against moisture and altitude
===

<font size="6">

```r
plot(fit3, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-46-1.png" title="plot of chunk unnamed-chunk-46" alt="plot of chunk unnamed-chunk-46" style="display: block; margin: auto;" />
</font>

***

<font size="6">

```r
plot(fit3, resid(.) ~ altitude, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-47-1.png" title="plot of chunk unnamed-chunk-47" alt="plot of chunk unnamed-chunk-47" style="display: block; margin: auto;" />
</font>

Parameters with / without overdispersion
===

<font size="5">

```r
fixef(fit2)
```

```
  (Intercept)      moisture      altitude I(altitude^2) 
     1.615525      2.535863     10.437551    -10.767861 
```

```r
confint(fit2, method = "Wald")
```

```
                   2.5 %    97.5 %
(Intercept)     1.033920  2.197130
moisture        2.506027  2.565698
altitude        8.819569 12.055533
I(altitude^2) -12.265412 -9.270311
```
</font>
***
<font size="5">

```r
fixef(fit3)
```

```
  (Intercept)      moisture      altitude I(altitude^2) 
     1.516176      1.947815     10.593235    -10.518092 
```

```r
confint(fit3, method = "Wald")
```

```
                    2.5 %    97.5 %
(Intercept)     0.8966419  2.135709
moisture        1.8497479  2.045882
altitude        8.3310824 12.855388
I(altitude^2) -12.6869600 -8.349223
```
</font>

Conclusion
===

- Including overdispersion makes quite a bit of difference for both fixed effect estimates and CIs!

- The fixed effect influence comes from the nonlinearity of the GLM structure (exponential link)

Are we OK now?
===

We have 

- Checked the fixed effect structure, significance for all variables
- Residuals seem to look ok (with reservation)
- Overdispersion is controlled

Random effect estimates
===


<font size="5">

```r
hist(ranef(fit3)$plot[,1], breaks = 50)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-50-1.png" title="plot of chunk unnamed-chunk-50" alt="plot of chunk unnamed-chunk-50" style="display: block; margin: auto;" />

```r
shapiro.test(ranef(fit3)$plot[,1])
```

```

	Shapiro-Wilk normality test

data:  ranef(fit3)$plot[, 1]
W = 0.9746, p-value = 0.3524
```
</font>

***

<font size="5">

```r
hist(ranef(fit3)$year[,1], breaks = 50)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-51-1.png" title="plot of chunk unnamed-chunk-51" alt="plot of chunk unnamed-chunk-51" style="display: block; margin: auto;" />

```r
shapiro.test(ranef(fit3)$year[,1])
```

```

	Shapiro-Wilk normality test

data:  ranef(fit3)$year[, 1]
W = 0.9158, p-value = 0.08223
```
Although not significant, we could suspect something is not right for the year random effect!
</font>


Residuals against fitted values for each year
===

<font size="6">

```r
plot(fit3, resid(.) ~ fitted(.) | year, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-52-1.png" title="plot of chunk unnamed-chunk-52" alt="plot of chunk unnamed-chunk-52" style="display: block; margin: auto;" />

A lot of variation, despite the fact that we have already include a random effect
</font>
  
  
Residuals against moisture for each year
===
  
<font size="6">

```r
plot(fit2, resid(.) ~ moisture | year, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-53-1.png" title="plot of chunk unnamed-chunk-53" alt="plot of chunk unnamed-chunk-53" style="display: block; margin: auto;" />
Aha, the plots differ in the effect of moisture!
</font>
  
  
Include year as random slope on moisture
===
  
<font size="4">

```r
fit6 <- glmer(beetles ~ moisture + altitude + I(altitude^2) + (0+moisture|year) + (1|plot) + (1|dataID), family = "poisson")
summary(fit6)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + I(altitude^2) + (0 + moisture |  
    year) + (1 | plot) + (1 | dataID)

     AIC      BIC   logLik deviance df.resid 
  9024.2   9058.6  -4505.1   9010.2      993 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-1.57104 -0.24266  0.03119  0.12599  1.11341 

Random effects:
 Groups Name        Variance Std.Dev.
 dataID (Intercept) 0.5072   0.7122  
 plot   (Intercept) 0.5084   0.7130  
 year   moisture    2.6203   1.6187  
Number of obs: 1000, groups:  dataID, 1000; plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.5139     0.2749   5.507 3.66e-08 ***
moisture        1.7656     0.3716   4.752 2.02e-06 ***
altitude       10.9162     1.2455   8.765  < 2e-16 ***
I(altitude^2) -10.8891     1.1988  -9.084  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.002              
altitude    -0.832  0.002       
I(altitd^2)  0.690 -0.002 -0.962
```
</font>
  

  
Plot
===
  
<font size="5">

```r
plot(fit6, form = resid(., type = "pearson") ~ log(fitted(.))) 
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-55-1.png" title="plot of chunk unnamed-chunk-55" alt="plot of chunk unnamed-chunk-55" style="display: block; margin: auto;" />

```r
overdisp_fun(fit6)
```

```
      chisq       ratio         rdf           p 
147.5552556   0.1485954 993.0000000   1.0000000 
```
</font>

***

<font size="5">

```r
residuals <- simulatedResiduals(fit6)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-56-1.png" title="plot of chunk unnamed-chunk-56" alt="plot of chunk unnamed-chunk-56" style="display: block; margin: auto;" />
</font>

Looks really good! Funny that it is not the correct model ;)


True model
===
  
The true model (look it up in my code) didn't have an overdispersion term. If I remove the 1|plotId, we get this
  
<font size="4">

```r
fit7 <- glmer(beetles ~ moisture + altitude + I(altitude^2) + (0+moisture|year) + (1|plot) , family = "poisson")
summary(fit7)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + I(altitude^2) + (0 + moisture |  
    year) + (1 | plot)

     AIC      BIC   logLik deviance df.resid 
 22430.8  22460.2 -11209.4  22418.8      994 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-12.8595  -2.1999  -0.0953   2.0859  21.2919 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5648   0.7515  
 year   moisture    4.3628   2.0887  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.2640     0.2139   5.909 3.45e-09 ***
moisture        2.1579     0.4672   4.619 3.86e-06 ***
altitude       12.1595     0.8409  14.460  < 2e-16 ***
I(altitude^2) -11.5927     0.7779 -14.903  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.001              
altitude    -0.782  0.001       
I(altitd^2)  0.634 -0.001 -0.954
```
</font>
  

  
Residuals for the true model
===
  
<font size="5">

```r
plot(fit7, form = resid(., type = "pearson") ~ log(fitted(.))) 
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-58-1.png" title="plot of chunk unnamed-chunk-58" alt="plot of chunk unnamed-chunk-58" style="display: block; margin: auto;" />

```r
overdisp_fun(fit7)
```

```
      chisq       ratio         rdf           p 
17313.84172    17.41835   994.00000     0.00000 
```
</font>

***

<font size="5">

```r
residuals <- simulatedResiduals(fit7)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-59-1.png" title="plot of chunk unnamed-chunk-59" alt="plot of chunk unnamed-chunk-59" style="display: block; margin: auto;" />

I seem to think the overdispersion looks worse for the pearson residuals than for the simulation. According to the Pearson and the overdispersion test, we would definitely diagnose overdispersion. 

</font>


So, how did we learn?
===
left:60%

<font size="5">

- Possible to improve model structure by looking at the residuals 

  - Admittedly, I knew what I was looking for. We should make a blind test!

- True parameters were retrieved quite OK

  - moisture effect = 2
  - altitude = 10
  - altitude^2 = -10

- According to standard diagnostics, we would probably have included an overdispersion term. We can argue whether this is correct or not. Parameter estimates are somewhat influenced by that, but the model with overdispersion is not horrible.

</font>

***

<font size="4">


```r
summary(fit7)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ moisture + altitude + I(altitude^2) + (0 + moisture |  
    year) + (1 | plot)

     AIC      BIC   logLik deviance df.resid 
 22430.8  22460.2 -11209.4  22418.8      994 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-12.8595  -2.1999  -0.0953   2.0859  21.2919 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5648   0.7515  
 year   moisture    4.3628   2.0887  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.2640     0.2139   5.909 3.45e-09 ***
moisture        2.1579     0.4672   4.619 3.86e-06 ***
altitude       12.1595     0.8409  14.460  < 2e-16 ***
I(altitude^2) -11.5927     0.7779 -14.903  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.001              
altitude    -0.782  0.001       
I(altitd^2)  0.634 -0.001 -0.954
```

</font>

Summary Residual Analysis
===
incremental: true

- Main residuals in principle like for a GLM. Careful because 
  - Expected variance from Pearson is not exact -> possibility to move to simulations 
  - Random effect estimates are often shaky, which can result in diagnosed under- and specially over-dispersion
  
- Random effects assumptions
  - Typical (because convenient) to test normality of estimated random effects. Because the mixed structure forces the random effects towards normality, this is potentially not sensitve enough to diagnose all problems
    - But if you see something here, you can be pretty sure that things are wrong.
  

To demonstrate the last point
===

Data where a random effects on group comes from an exponential distribution

<font size="4">




```r
treatment = c(rep(2, 1000), rep(4, 1000))
group = rep(1:20, each = 100)
groupRandom = rexp(20)
hist(groupRandom, breaks = 30, xlim = c(-5,10), main = "True random effects")
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-61-1.png" title="plot of chunk unnamed-chunk-61" alt="plot of chunk unnamed-chunk-61" style="display: block; margin: auto;" />

```r
resp = rpois(2000, exp(treatment + groupRandom[group]))
treatment <- as.factor(treatment)
fitTest <- glmer(resp ~ treatment + (1|group) , family = "poisson")
```
</font>

***

This is caught by the normality test 

<font size="4">

```r
randcoef = ranef(fitTest)$group[,1]
hist(randcoef,  breaks = 30, xlim = c(-5,10) , main = "Estimated random effects")
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-62-1.png" title="plot of chunk unnamed-chunk-62" alt="plot of chunk unnamed-chunk-62" style="display: block; margin: auto;" />

```r
shapiro.test(randcoef)
```

```

	Shapiro-Wilk normality test

data:  randcoef
W = 0.7702, p-value = 0.0003211
```
Note that the two distributions differ because the model tries to fit the data to a normal distribution.
</font>








