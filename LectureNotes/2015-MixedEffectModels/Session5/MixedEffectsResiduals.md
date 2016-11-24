Digging deeper with mixed models: Residual diagnostics
========================================================
author: Florian Hartig
date: 5th mixed model session, Jan 21, 2015

Reminder previous session
===
incremental: true

Mixed models = normal GLM structure + random effect

- Random intercept: $y_{obs} \sim ErrorDistr(mean = link (A \cdot X + (b + R_i))$ 
- Random slope: $y_{obs} \sim ErrorDistr(mean = link ( (A  + R_i)  \cdot X + b))$ 

**Random effect $R_i$** assigns a different value to each group $i$
- not independently (as for a fixed effect), 
- but from a common distribution that is assumed to be normal in all base packages, i.e. $R_i \sim Norm(0, \sigma)$
- Models estimate the $\sigma$ and the dependent $R_i$ 

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

2x2 basic opportunities for school to modify the outcome

1. School affects the mean normexan. 2 choices:
  - school as **main effect** (fixed effect)
  - school as **random interecept** (mixed model)


2. School modifies effect of standLRT. 2 choices:
  - school as **interaction** with standLRT (fixed effect)
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
</font>

Note that we can't directly compare the standLRT in this case because the interaction shifts the estimate due to the fact that the effect of schools is calculated relative to the first school!

</font>




Obvious question
===

Which of the four models should we use?

- All are sensible (with reservations)
- All predict a significant effect of standLRT
- **But with different p-values and different effect sizes**

What to do?

- **Model diagnostics** to detect problems in the model specification
  - We saw already a problem (randon slope not normal!)
- **Model selection** on the random effect structure (in two weeks)

Some more things to remember
===

In this short repetition, we were only considering one random effect. Important extensions: 

- **Crossed** and **nested** random effects:
  - A,B crossed = 2 independent random effects for groups of variables A and B
  - A nested in B = Several groups of A appear always with one group of B. Assumes independent normal distr for each subgroup of A 

- Modifications of the **variance-covariance structure** of the random effects (covariance between fixed and random effects, or covariance within the random effects like in a GLS)


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
  dataID beetles  moisture altitude plot year spatialCoordinate
1      1       9 0.1848823        0    1    1                 0
2      2      54 0.7023740        0    1    2                 0
3      3       8 0.5733263        0    1    3                 0
4      4       3 0.1680519        0    1    4                 0
5      5      53 0.9438393        0    1    5                 0
6      6      38 0.9434750        0    1    6                 0
```

```r
str(data)
```

```
'data.frame':	1000 obs. of  7 variables:
 $ dataID           : int  1 2 3 4 5 6 7 8 9 10 ...
 $ beetles          : int  9 54 8 3 53 38 5 114 4 22 ...
 $ moisture         : num  0.185 0.702 0.573 0.168 0.944 ...
 $ altitude         : num  0 0 0 0 0 0 0 0 0 0 ...
 $ plot             : int  1 1 1 1 1 1 1 1 1 1 ...
 $ year             : int  1 2 3 4 5 6 7 8 9 10 ...
 $ spatialCoordinate: num  0 0 0 0 0 0 0 0 0 0 ...
```
</font>

Visually
===


<font size="4">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-22-1.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" style="display: block; margin: auto;" />
</font>


Univariate environmental responses
===

<font size="6">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />
</font>

Plot and year
===

<font size="6">
<img src="MixedEffectsResiduals-figure/unnamed-chunk-24-1.png" title="plot of chunk unnamed-chunk-24" alt="plot of chunk unnamed-chunk-24" style="display: block; margin: auto;" />
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
 11429.2  11453.7  -5709.6  11419.2      995 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-9.0692 -1.2621  0.0203  1.3257 16.4605 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 1.2911   1.1363  
 year   (Intercept) 0.8709   0.9332  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  1.98263    0.37973    5.22 1.78e-07 ***
moisture     2.55437    0.01501  170.15  < 2e-16 ***
altitude    -0.08312    0.54648   -0.15    0.879    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr) moistr
moisture -0.026       
altitude -0.720 -0.001
```
</font>

Ususally center and scale when working with lme4 
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
 11429.2  11453.7  -5709.6  11419.2      995 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-9.0692 -1.2621  0.0203  1.3257 16.4605 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 1.2911   1.1363  
 year   (Intercept) 0.8708   0.9332  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  3.25484    0.37953    8.58   <2e-16 ***
moisture     2.55437    0.01501  170.15   <2e-16 ***
altitude    -0.08309    0.54628   -0.15    0.879    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
         (Intr) moistr
moisture -0.006       
altitude -0.720 -0.001
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
  

Normal mixed Poisson 
===

<font size="6">


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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-30-1.png" title="plot of chunk unnamed-chunk-30" alt="plot of chunk unnamed-chunk-30" style="display: block; margin: auto;" />
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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-32-1.png" title="plot of chunk unnamed-chunk-32" alt="plot of chunk unnamed-chunk-32" style="display: block; margin: auto;" />
The problem here is obviously that the residuals are not homogenous. So, do we have a problem?
</font>

Verify this by simulation
===

What would we expect for a model of this structure? In general, hard to say, but we can always do simualtions. Introduce a function that simulate new data with the MLE estimate, and then has two options:

- Compare simulated data to observed data (quantiles). Similar to Bayesian p-value

- Fit new models to simulated data, compare new residuals against observed residuals to check whether they are atypical. 

I tend to think that the second option is more reliable (), as it is known that option 1) 

***

<font size="3">

```r
simulatedResiduals <- function(fittedModel, response, n = 500, refit = F, plot = T, simulateLoop = F){
  len = nobs(fittedModel)

  
  # Either simulate from the MLE estimate, and compare the distribution of the model predictions
  # to the observed data
  if (refit == F){
  
    # To test whether simulate really does this correctly 
    if (simulateLoop == T){
      pred <- matrix(nrow = len, ncol = n )  
      for (i in 1:n){
        pred[,i] <- simulate(fittedModel, nsim = 1, use.u =F)[,1]
      }
    } else {
      pred <- data.matrix(simulate(fittedModel, nsim = n, use.u =F))
    }
    
    residuals <- numeric(len)
    for (i in 1:len){
      residuals[i] <- ecdf(pred[i,])(response[i])
    }
    
  # Or new data based on the MLE estimate, fit a new model to this data, look at the 
  # residuals, and check whether 
  
  } else {
    observedResiduals <- residuals(fittedModel)
    simulatedResiduals <- matrix(nrow = len, ncol = n )  
    newSimulatedData <- data.matrix(simulate(fittedModel, nsim = n, use.u =F))
    
    newData <-model.frame(fittedModel)  
    for (i in 1:n){
      newData[,1] = newSimulatedData[,i]
      simulatedResiduals[,i] <- residuals(update(fittedModel, data = newData ) )
    }
    residuals <- numeric(len)
    for (i in 1:len){
        residuals[i] <- ecdf(simulatedResiduals[i,])(observedResiduals[i])
    }
  }
  
  if (plot == T){
    oldpar <- par(mfrow = c(1,2))
    hist(residuals, breaks = 30)
    ord <- order(fitted(fittedModel))
    plot(log(fitted(fittedModel)[ord]), residuals[ord], pch = 3)
    par(oldpar)
  }
  return(residuals)
}
```
</font>


Residuals as quantiles against simualtion from fitted
===

<font size="5">

The first option to create residuals by simulation is to simulate from the fitted value, and plot the observed residuals as quantiles from the simulation. This corresponds (except for parametric uncertainty) to the Bayesian p-value


```r
residuals <- simulatedResiduals(testFit, resp, plot = F, refit = F)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-34-1.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" style="display: block; margin: auto;" />
</font>

***

<font size="5">

As a function of the predicted value


```r
plot(log(sort(fitted(testFit))), residuals[order(fitted(testFit))], pch = 3)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-35-1.png" title="plot of chunk unnamed-chunk-35" alt="plot of chunk unnamed-chunk-35" style="display: block; margin: auto;" />
</font>


Residuals as quantiles against refitted residuals
===

<font size="5">

The second option is to create new data from the fitted model, refit, and compare the observed residual against the residuals of the refitted model. 


```r
residuals <- simulatedResiduals(testFit, resp, plot = F, refit = T)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-36-1.png" title="plot of chunk unnamed-chunk-36" alt="plot of chunk unnamed-chunk-36" style="display: block; margin: auto;" />
</font>

***

<font size="5">

As a function of the predicted value


```r
plot(log(sort(fitted(testFit))), residuals[order(fitted(testFit))], pch = 3)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-37-1.png" title="plot of chunk unnamed-chunk-37" alt="plot of chunk unnamed-chunk-37" style="display: block; margin: auto;" />
</font>

Summary simulation
===

<font size="5">

We are fitting the correct model. Still, residual structure is not heterogenous, is this underdispersed? Seems difficult to say whether there is a problem. Doing the simulation with parameter uncertainty (this is often called the Bayesian p-value) might solve this problem. 
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
 17417.2  17439.6  -8704.6  17409.2     1996 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-1.9831 -0.2647 -0.0067  0.1546  0.9951 

Random effects:
 Groups Name        Variance Std.Dev.
 ID     (Intercept) 0.2682   0.5179  
 group  (Intercept) 0.4445   0.6667  
Number of obs: 2000, groups:  ID, 2000; group, 10

Fixed effects:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   2.2711     0.2987   7.602 2.90e-14 ***
treatment4    2.4079     0.4223   5.701 1.19e-08 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
           (Intr)
treatment4 -0.707
```
</font>


Conclusion Pearson / simulated residuals
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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-39-1.png" title="plot of chunk unnamed-chunk-39" alt="plot of chunk unnamed-chunk-39" style="display: block; margin: auto;" />

Definitely overdispersion (values tend to exceed 2)
</font>

Residuals against moisture and altitude
===

<font size="6">

```r
plot(fit1, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-40-1.png" title="plot of chunk unnamed-chunk-40" alt="plot of chunk unnamed-chunk-40" style="display: block; margin: auto;" />
</font>

***

<font size="6">

```r
plot(fit1, resid(.) ~ altitude, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-41-1.png" title="plot of chunk unnamed-chunk-41" alt="plot of chunk unnamed-chunk-41" style="display: block; margin: auto;" />
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
 11389.6  11419.0  -5688.8  11377.6      994 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-9.0670 -1.2481  0.0199  1.3295 16.4603 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5542   0.7445  
 year   (Intercept) 0.8635   0.9292  
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
               Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.46138    0.36906    3.96 7.50e-05 ***
moisture        2.55446    0.01501  170.16  < 2e-16 ***
altitude       10.90918    1.40873    7.74 9.63e-15 ***
I(altitude^2) -10.99482    1.36202   -8.07 6.89e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.007              
altitude    -0.708  0.000       
I(altitd^2)  0.604 -0.001 -0.967
```
</font>
  
Residuals against moisture and altitude
===
  
<font size="6">

```r
plot(fit2, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-43-1.png" title="plot of chunk unnamed-chunk-43" alt="plot of chunk unnamed-chunk-43" style="display: block; margin: auto;" />
</font>
  
  ***
  
  <font size="6">
  
  ```r
  plot(fit2, resid(.) ~ altitude, abline = 0)
  ```
  
  <img src="MixedEffectsResiduals-figure/unnamed-chunk-44-1.png" title="plot of chunk unnamed-chunk-44" alt="plot of chunk unnamed-chunk-44" style="display: block; margin: auto;" />
</font>
  
  
  
What's going on?
===

<font size="6">

OK, so the quadratic effect is very significantly supported, but the overdispersion around the mean altitudues is not much better. Could it be that we simply have a general overdispersion phenomenon here, that is more visible for the places where there are lots of beetles?


```r
plot(fit2, form = resid(., type = "pearson") ~ log(fitted(.)))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-45-1.png" title="plot of chunk unnamed-chunk-45" alt="plot of chunk unnamed-chunk-45" style="display: block; margin: auto;" />
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
7229.985348    7.273627  994.000000    0.000000 
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
  8247.1   8281.4  -4116.5   8233.1      993 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-2.30541 -0.32012 -0.00051  0.16766  2.97956 

Random effects:
 Groups Name        Variance Std.Dev.
 dataID (Intercept) 0.1422   0.3771  
 plot   (Intercept) 0.5299   0.7279  
 year   (Intercept) 0.5862   0.7656  
Number of obs: 1000, groups:  dataID, 1000; plot, 50; year, 20

Fixed effects:
               Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.56899    0.34561    4.54 5.63e-06 ***
moisture        1.94185    0.04981   38.98  < 2e-16 ***
altitude       10.72573    1.38527    7.74 9.73e-15 ***
I(altitude^2) -10.83389    1.33954   -8.09 6.08e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture    -0.008              
altitude    -0.744  0.007       
I(altitd^2)  0.634 -0.008 -0.967
```
</font>

Residual plot for GLMM Poisson with overdisp
===

<font size="6">

```r
plot(fit3, form = resid(., type = "pearson") ~ log(fitted(.)))
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-48-1.png" title="plot of chunk unnamed-chunk-48" alt="plot of chunk unnamed-chunk-48" style="display: block; margin: auto;" />

```r
overdisp_fun(fit3)
```

```
      chisq       ratio         rdf           p 
339.8012738   0.3421967 993.0000000   1.0000000 
```
</font>

Residuals against moisture and altitude
===

<font size="6">

```r
plot(fit3, resid(.) ~ moisture, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-49-1.png" title="plot of chunk unnamed-chunk-49" alt="plot of chunk unnamed-chunk-49" style="display: block; margin: auto;" />
</font>

***

<font size="6">

```r
plot(fit3, resid(.) ~ altitude, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-50-1.png" title="plot of chunk unnamed-chunk-50" alt="plot of chunk unnamed-chunk-50" style="display: block; margin: auto;" />
</font>

Parameters with / without overdispersion
===

<font size="5">

```r
fixef(fit2)
```

```
  (Intercept)      moisture      altitude I(altitude^2) 
     1.461383      2.554455     10.909180    -10.994824 
```

```r
confint(fit2, method = "Wald")
```

```
                    2.5 %    97.5 %
(Intercept)     0.7380308  2.184734
moisture        2.5250316  2.583879
altitude        8.1481204 13.670239
I(altitude^2) -13.6643285 -8.325319
```
</font>

***
<font size="5">

```r
fixef(fit3)
```

```
  (Intercept)      moisture      altitude I(altitude^2) 
     1.568988      1.941847     10.725729    -10.833886 
```

```r
confint(fit3, method = "Wald")
```

```
                    2.5 %    97.5 %
(Intercept)     0.8916046  2.246372
moisture        1.8442186  2.039476
altitude        8.0106551 13.440803
I(altitude^2) -13.4593324 -8.208440
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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-53-1.png" title="plot of chunk unnamed-chunk-53" alt="plot of chunk unnamed-chunk-53" style="display: block; margin: auto;" />

```r
shapiro.test(ranef(fit3)$plot[,1])
```

```

	Shapiro-Wilk normality test

data:  ranef(fit3)$plot[, 1]
W = 0.9704, p-value = 0.2394
```
</font>

***

<font size="5">

```r
hist(ranef(fit3)$year[,1], breaks = 50)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-54-1.png" title="plot of chunk unnamed-chunk-54" alt="plot of chunk unnamed-chunk-54" style="display: block; margin: auto;" />

```r
shapiro.test(ranef(fit3)$year[,1])
```

```

	Shapiro-Wilk normality test

data:  ranef(fit3)$year[, 1]
W = 0.9185, p-value = 0.09272
```
Although not significant, we could suspect something is not right for the year random effect!
</font>


Residuals against fitted values for each year
===

<font size="6">

```r
plot(fit3, resid(.) ~ fitted(.) | year, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-55-1.png" title="plot of chunk unnamed-chunk-55" alt="plot of chunk unnamed-chunk-55" style="display: block; margin: auto;" />

A lot of variation, despite the fact that we have already include a random effect
</font>
  
  
Residuals against moisture for each year
===
  
<font size="6">

```r
plot(fit2, resid(.) ~ moisture | year, abline = 0)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-56-1.png" title="plot of chunk unnamed-chunk-56" alt="plot of chunk unnamed-chunk-56" style="display: block; margin: auto;" />
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
  9118.2   9152.6  -4552.1   9104.2      993 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-1.70823 -0.22489  0.03604  0.12442  0.94282 

Random effects:
 Groups Name        Variance Std.Dev.
 dataID (Intercept) 0.4854   0.6967  
 plot   (Intercept) 0.5005   0.7075  
 year   moisture    2.4871   1.5771  
Number of obs: 1000, groups:  dataID, 1000; plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.5984     0.2976   5.371 7.84e-08 ***
moisture        1.7494     0.3620   4.832 1.35e-06 ***
altitude       10.8370     1.3741   7.887 3.10e-15 ***
I(altitude^2) -10.9882     1.3287  -8.270  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture     0.000              
altitude    -0.857  0.000       
I(altitd^2)  0.731  0.000 -0.967
```
</font>
  

  
Plot
===
  
<font size="5">

```r
plot(fit6, form = resid(., type = "pearson") ~ log(fitted(.))) 
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-58-1.png" title="plot of chunk unnamed-chunk-58" alt="plot of chunk unnamed-chunk-58" style="display: block; margin: auto;" />

```r
overdisp_fun(fit6)
```

```
      chisq       ratio         rdf           p 
140.3295175   0.1413187 993.0000000   1.0000000 
```
</font>


Hmm ... looks good, or underdispersed? Well, it's not the "true" model?


Simulation results
===

Distribution

<font size="5">

```r
residuals <- simulatedResiduals(fit6, beetles, plot = F, refit = T)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-59-1.png" title="plot of chunk unnamed-chunk-59" alt="plot of chunk unnamed-chunk-59" style="display: block; margin: auto;" />
</font>

***

Against fitted

<font size="5">


```r
plot(log(sort(fitted(testFit))), residuals[order(fitted(testFit))], pch = 3)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-60-1.png" title="plot of chunk unnamed-chunk-60" alt="plot of chunk unnamed-chunk-60" style="display: block; margin: auto;" />
</font>


Solution: the true model
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
 22466.4  22495.8 -11227.2  22454.4      994 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-12.9094  -2.2875   0.1052   2.1328  17.3657 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5213   0.722   
 year   moisture    4.3301   2.081   
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.7048     0.2974   5.732 9.91e-09 ***
moisture        2.1603     0.4658   4.638 3.52e-06 ***
altitude       10.9823     1.3766   7.978 1.49e-15 ***
I(altitude^2) -11.1573     1.3306  -8.385  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture     0.000              
altitude    -0.858 -0.001       
I(altitd^2)  0.734  0.001 -0.967
```
</font>
  

  
Standard Pearson residuals for the true model
===
  
<font size="5">

```r
plot(fit7, form = resid(., type = "pearson") ~ log(fitted(.))) 
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-62-1.png" title="plot of chunk unnamed-chunk-62" alt="plot of chunk unnamed-chunk-62" style="display: block; margin: auto;" />

```r
overdisp_fun(fit7)
```

```
      chisq       ratio         rdf           p 
17053.73692    17.15668   994.00000     0.00000 
```
</font>


Simulation results
===

Distribution

<font size="5">

```r
residuals <- simulatedResiduals(fit7, beetles, plot = F, refit = T)
hist(residuals)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-63-1.png" title="plot of chunk unnamed-chunk-63" alt="plot of chunk unnamed-chunk-63" style="display: block; margin: auto;" />
</font>

***

Against fitted

<font size="5">


```r
plot(log(sort(fitted(testFit))), residuals[order(fitted(testFit))], pch = 3)
```

<img src="MixedEffectsResiduals-figure/unnamed-chunk-64-1.png" title="plot of chunk unnamed-chunk-64" alt="plot of chunk unnamed-chunk-64" style="display: block; margin: auto;" />
</font>

```

So ...
====

Both according Pearson residuals, overdispersion test and simulations, we would definitely diagnose overdispersion for the true model. Weird, isn't it?


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
 22466.4  22495.8 -11227.2  22454.4      994 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-12.9094  -2.2875   0.1052   2.1328  17.3657 

Random effects:
 Groups Name        Variance Std.Dev.
 plot   (Intercept) 0.5213   0.722   
 year   moisture    4.3301   2.081   
Number of obs: 1000, groups:  plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     1.7048     0.2974   5.732 9.91e-09 ***
moisture        2.1603     0.4658   4.638 3.52e-06 ***
altitude       10.9823     1.3766   7.978 1.49e-15 ***
I(altitude^2) -11.1573     1.3306  -8.385  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) moistr altitd
moisture     0.000              
altitude    -0.858 -0.001       
I(altitd^2)  0.734  0.001 -0.967
```

</font>

Summary Residual Analysis
===
incremental: true

- Main residuals in principle like for a GLM. However, for hierarchical models we have to be a bit careful, because it is not so clear what we expect for the distribution of the residuals. 
  - Expected variance from Pearson is not a good test exact -> maybe better to move to Bayesian methods (Bayesian p-value), but that's another topic
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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-66-1.png" title="plot of chunk unnamed-chunk-66" alt="plot of chunk unnamed-chunk-66" style="display: block; margin: auto;" />

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

<img src="MixedEffectsResiduals-figure/unnamed-chunk-67-1.png" title="plot of chunk unnamed-chunk-67" alt="plot of chunk unnamed-chunk-67" style="display: block; margin: auto;" />

```r
shapiro.test(randcoef)
```

```

	Shapiro-Wilk normality test

data:  randcoef
W = 0.8471, p-value = 0.004772
```
Note that the two distributions differ because the model tries to fit the data to a normal distribution.
</font>








