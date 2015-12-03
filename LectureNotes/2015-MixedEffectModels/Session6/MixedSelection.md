Model selection with mixed models
========================================================
author: Florian Hartig
date: 6th mixed model session, Feb 04, 2015



What we have learned so far
===

For any categorical variable (specially for groups / plots / blocks), you can decide whether to include it as

- Fixed effect
- Random effect

Both cases fit a estimate for each level of the categorical variable, and we can include the variable as **main effect** or as an **interaction** with another variable. 

- So, what's the difference between fixed and random?


Difference fixed and random
===

Basic structure identical

- $y \sim A \cdot X + (b + R_i)$ main effect / random intercept
- $y \sim  (A  + R_i)  \cdot X + b)$ interaction / random slope 

The **only difference** is the additional assumption $R_i \sim Norm(0, \sigma)$ for the random effect version. Leads to 

1. less degrees of freedom lost 
2. typically smaller parameter estimates (shrinkage)


Demonstration of the shrinkage
===


<img src="MixedSelection-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

<font size="5">

Change of parameter estimates when moving from fixed effect lm(Reaction ~ Days * Subject, data=sleepstudy) to random effect lmer(Reaction ~ Days + (Days | Subject), sleepstudy), From mbjoseph.github.io/blog/2015/01/20/shrink/
</font>

So ...
===

Using a random effect means we 

- Can fit more parameters with the same amount of data

  - Allows to include lots of variables (plot/subplot) 

On the other hand

- More complicated structure --> need to check assumptions, many statistical problems (p-values ...)
- Also a random effect is not for free!!!

What we did so far
===

- Learned how to specify a mixed effect model (lecture 2)
- Learned how to simulate power (lecture 4)
- Learned how to check residuals (lecture 5)

Comments last lecture
===

- I had a small error in the function for creating simulated residuals
- Also, I added an additional option to create simulated residuals 

Still diagnose overdispersion for the true model, which is a bit of a concern to me, but the plots look nicer. Hence, **have a look at the updated code**!


Some more comments 
===

Motivated by questions that were asked after the lectures / via email 

- The "at least 7 for a random effect" rule
- Preparing a study, power
- After a study, how do I find the right model


Comment 1: The "at least 7 rule"
===

It is written in many books that the categorical variable should have at least 7 levels to qualify as a random effect. 

- Rules ob thumb are good, **but they are rules of thumb** and they are rarely generally valid!!!

- I see no reason why a random effect model should be worse than a fixed effect model for <7 levels, except for the fact that shrinkage may be stronger

But you know, instead of speculating, just try it out!


Function to create virtual datasets
===

<font size="6">

```r
createData <- function(n=250, numGroups = 10, sampleSize = 1000){
  out = list()
  for (i in 1:n){
    environment1 = seq(-1,1,len = sampleSize)
    group = rep(1:numGroups, each = sampleSize/numGroups)
    groupRandom = rnorm(numGroups, sd = 1)
    counts = rpois(sampleSize, exp(environment1 + groupRandom[group] + rnorm(sampleSize, sd = 0.5)))
    out[[i]] <- data.frame(ID = 1:2000, counts, environment1, group)
  }
  return(out)
}
```

Fit this with 


```r
glmer(counts ~ environment1 + (1|group) + (1|ID) , family = "poisson")
```

</font>


Fitting mixed model with 10 groups
===

<img src="MixedSelection-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


Fitting mixed model with 4 groups
===


<img src="MixedSelection-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

Comparing to group as fixed effect
===

<font size="5">


```r
glmer(counts ~ environment1 + (1|group) + (1|ID) , family = "poisson")
glmer(counts ~ environment1 + group + (1|ID) , family = "poisson")
```

</font>


<img src="MixedSelection-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Conclusion "at least 7 rule"
===

For the example, I didn't see any larger problems with <7

- actually, mixed model provides better estimates than the fixed effect variant. 
  -Could continue to look now at p-values etc., see how confidence intervals change, but in general things don't seem to go terribly wrong with the mixed model.

- The >7 rule may have it's reason, and be useful in some situations. But who knows when. General rules are complicated. 




Comment 2: Power
===

"How many data points do I need? I read that you nead at least X replicates for this analysis!"

I want to repeat how useful it is to do simulations to explore the properties and the accuracy of the analysis you are doing, e.g.

- The power analysis that we made 2 lectures ago
- The analysis we just did

In times where everyone has a good computer, you don't have to accept rules such as "you need at least 50 datapoints"! **Simulate and find out!!!**. 


Comment 3: Residual diagnostics and Model selection
===

I think some might have misunderstood the rationale for residual diagnostics

1. Residual diagnostics allow us to remove inadequate models

2. The model with the **best residuals is not neccessarily the best model**!!!

3. To select among models that cannot be rejected based on the residuals, we need **model selection techniques**


Model selection (MS)
===

*Model selection is the task of selecting a statistical model from a set of candidate models, given data.* (Wikipedia)

- Reasons for MS

  - Too many predictors, too little data 
  
  - Unsure about model structure (quadratic terms, random effects structure)

- Huge topic in statistics, no agreement about how to do it best, specially not for mixed models!!! 


  
Best model != Best fit
===

Imagine we have some data that comes from a quadradic function (polynomial order 2)

<img src="MixedSelection-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />


Fit for different polynomials
===


<img src="MixedSelection-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" style="display: block; margin: auto;" />

***

<img src="MixedSelection-figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

The more complex the model, the better it fits! 

Complex models fit great!
===

Here again in terms of R2 and adjusted R2

<img src="MixedSelection-figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

***

But here's the error for predicting on new data

<img src="MixedSelection-figure/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />


Anticipate this via cross-validation
===

- Calculate expected error for new data by splitting up the data in training and validation chunks

- Select the model structure with the lowest predictive error for new data

***

<img src="MixedSelection-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" style="display: block; margin: auto;" />


What did we learn?
===

There is the so-called **bias / variance trade-off**

- More complex, more variance explained (and better residuals)
- More complex, more bias for new data (and typically less "true")

--> Model selection tries find this sweet spot by defining a score that includes model fit, but **penalizes for complexity**

But: objectives / philosophies differ in detail 


Model selection strategies overview
===

- I: MS with a set of fixed candidate models

  - "score" that says if one model fits better than the other (AIC, BIC, ...)
  
- II: MS with one flexible model structure that adjust itself 

  - Lasso / Bayesian analysis with mildly informative priors. 
  - Mixed models: variance parameter adjusts for flexibility of the random effects. 
  
  
Searching for the best in a set of models
===

For each candidate model we can calculate a **score**. If many models, search for the best model possible in two ways:

- Step-wise: start with the minimal / full model, increase / simplify until it is not getting better. (stepAIC) - **Don't do it any more!!!**, leads to various problems!
- Today **always preferred: global**, i.e. check all models. Use, e.g., the MuMIn package in R 


Many possible scores
===

- Cross-validation (CV) - good and general, but costly

- Akaike Information Criterion (AIC) approximates CV via likelihood, very common in ecology
  
- Likelihood Ratio Tests (LRT) - test $\Delta L$ against H0
  
- Bayes Factor (BF), requires Bayesian posterior

- BIC approximates BF via Likelihood, similar to AIC

- Deviance Information Criterion (DIC), requires Bayes


Marginal vs. conditional scores
===

Many MS (implicitly) evaluate the predictive error on new data. 

Question for mixed models: new data from 

- the same random structure (e.g. same plots): **conditional** 

- with the random structure averaged (e.g. an average new plot): **marginal**

Results in marginal and conditional AIC, see e.g. Vaida, F. & Blanchard, S. (2005) Conditional Akaike information for mixed-effects models. Biometrika, 92, 351-370.



Degrees of freedom 
===

We had this already: not clear how to calculate df for random effects, but need them for AIC, BIC. Various approximations. General tendency seems to be to count 

- 1 DF per sigma, but not per random group for marginal
- 1 DF per group for conditional 

Usually important only $\Delta df$, not such a big problem as long as we don't compare random effect structures

Müller, S.; Scealy, J. L. & Welsh, A. H. (2013) Model Selection in Linear Mixed Models. Statist. Sci., 28, 135-167.


Flexible penalizing models
===

- Regression with the full model (df > data); include zero-preference for parameters (shrinkage). Solves the overparameterization problem (regularization). 

  - Popular variant of this is the Lasso (and we have glmmLasso in R) <font size="5"> Tibshirani, R. (1996) Regression Shrinkage and Selection via the Lasso. Journal of the Royal Statistical Society B, 58, pp. 267-288.</font>

- Bayesian version / interpretation: Regression with zero-mean Laplace prior <font size="5"> Park, T. & Casella, G. (2008) The Bayesian Lasso. Journal of the American Statistical Association, 103, 681-686. </font>


I will do 3 examples
===

- Example I: comparing few nested models with LRT via anova() and parametric bootstrap
- Example II: comparing many models via AIC
- Example III: a flexible, self-adjusting model via a regularized Bayesian approach


Compare 2 nested fixed structures 
===

<font size="6">

```r
str(sleepstudy)
```

```
'data.frame':	180 obs. of  3 variables:
 $ Reaction: num  250 259 251 321 357 ...
 $ Days    : num  0 1 2 3 4 5 6 7 8 9 ...
 $ Subject : Factor w/ 18 levels "308","309","310",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
fm0 <- lmer(Reaction ~ 1 + (1|Subject), sleepstudy, REML = F)
fm1 <- lmer(Reaction ~ Days + (1|Subject), sleepstudy, REML = F)
```
</font>

Random effect structure the same, fixed effects differ 

We can do anova()
===

<font size="5">

```r
anova(fm0, fm1)
```

```
Data: sleepstudy
Models:
object: Reaction ~ 1 + (1 | Subject)
..1: Reaction ~ Days + (1 | Subject)
       Df    AIC    BIC  logLik deviance  Chisq Chi Df Pr(>Chisq)    
object  3 1916.5 1926.1 -955.27   1910.5                             
..1     4 1802.1 1814.8 -897.04   1794.1 116.46      1  < 2.2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
</font>

Problems:

- Assumption here is that likelihoods are chisq distributed, which is not reliable for mixed models, small data. Also, is the difference in the DF really 1? 
- Tendency is p-values are anti-conservative (tend to reject H0 too often)

Alternatives http://glmm.wikidot.com/faq
===

<font size="5">

From worst to best:

- Wald chi-square tests (e.g. car::Anova)
- Likelihood ratio test (via anova or drop1)
- For balanced, nested LMMs where df can be computed: conditional F-tests
- For LMMs: conditional F-tests with df correction (e.g. Kenward-Roger in pbkrtest package). (Stroup [29] states on the basis of (unpresented) simulation results that K-r actually works reasonably well for GLMMs. However, at present the code in KRmodcomp only handles LMMs.)
- MCMC or parametric, or nonparametric, bootstrap comparisons (nonparametric bootstrapping must be implemented carefully to account for grouping factors)

Is the likelihood ratio test reliable for mixed models? 

- It depends. Not for fixed effects in finite-size cases (see [23]): may depend on 'denominator degrees of freedom' (number of groups) and/or total number of samples - total number of parameters. Conditional F-tests are preferred for LMMs, if denominator degrees of freedom are known

</font>

Parametric bootstrapping
===

<font size="4">

```r
pboot <- function(m0,m1) {
  s <- simulate(m0)
  L0 <- logLik(refit(m0,s))
  L1 <- logLik(refit(m1,s))
  2*(L1-L0)
}
sleepstudy_PB <- replicate(500,pboot(fm0,fm1))
```

We can read off the p-value for the likelihod ratio test (frequency observed difference > expected difference under the null hypothesis fm0)


```r
obsLLDiff <- -2*(logLik(fm0)-logLik(fm1))
pValue = mean(sleepstudy_PB>=obsLLDiff) 
pValue
```

```
[1] 0
```

*** 

```r
hist(sleepstudy_PB, breaks = 50, xlim = c(0,120))
abline(v = obsLLDiff, col = "red", lwd = 2)
```

<img src="MixedSelection-figure/unnamed-chunk-19-1.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" style="display: block; margin: auto;" />
</font>


Compare 2 nested random structures 
===

<font size="6">

```r
fm2 <- lmer(Reaction ~ Days + (Days|Subject), sleepstudy, REML = F)
fm3 <- lmer(Reaction ~ Days + (1|Subject) + (0+Days|Subject), sleepstudy, REML = F)
```
</font>

Btw: what is the difference between the two models?

Compare the output
===

<font size="4">

```r
summary(fm2)
```

```
Linear mixed model fit by maximum likelihood t-tests use Satterthwaite
  approximations to degrees of freedom [merModLmerTest]
Formula: Reaction ~ Days + (Days | Subject)
   Data: sleepstudy

     AIC      BIC   logLik deviance df.resid 
  1763.9   1783.1   -876.0   1751.9      174 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.9416 -0.4656  0.0289  0.4636  5.1793 

Random effects:
 Groups   Name        Variance Std.Dev. Corr
 Subject  (Intercept) 565.52   23.781       
          Days         32.68    5.717   0.08
 Residual             654.94   25.592       
Number of obs: 180, groups:  Subject, 18

Fixed effects:
            Estimate Std. Error      df t value Pr(>|t|)    
(Intercept)  251.405      6.632  18.000  37.906  < 2e-16 ***
Days          10.467      1.502  18.000   6.968 1.65e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
     (Intr)
Days -0.138
```
</font>

***
<font size="4">

```r
summary(fm3)
```

```
Linear mixed model fit by maximum likelihood t-tests use Satterthwaite
  approximations to degrees of freedom [merModLmerTest]
Formula: Reaction ~ Days + (1 | Subject) + (0 + Days | Subject)
   Data: sleepstudy

     AIC      BIC   logLik deviance df.resid 
    1762     1778     -876     1752      175 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.9535 -0.4673  0.0239  0.4625  5.1883 

Random effects:
 Groups    Name        Variance Std.Dev.
 Subject   (Intercept) 584.25   24.171  
 Subject.1 Days         33.63    5.799  
 Residual              653.12   25.556  
Number of obs: 180, groups:  Subject, 18

Fixed effects:
            Estimate Std. Error      df t value Pr(>|t|)    
(Intercept)  251.405      6.708  19.349  37.480  < 2e-16 ***
Days          10.467      1.519  19.349   6.889  1.3e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
     (Intr)
Days -0.194
```
</font>


Likelihood ratio tests
===

<font size="4">

Parametric, chisq. Note: chisq for random terms tends to be too conservative, although not here


```r
anova(fm2, fm3)
```

```
Data: sleepstudy
Models:
..1: Reaction ~ Days + (1 | Subject) + (0 + Days | Subject)
object: Reaction ~ Days + (Days | Subject)
       Df    AIC    BIC  logLik deviance  Chisq Chi Df Pr(>Chisq)
..1     5 1762.0 1778.0 -876.00   1752.0                         
object  6 1763.9 1783.1 -875.97   1751.9 0.0639      1     0.8004
```


LRT based on non-parametric bootstrap


```r
sleepstudy_PB <- replicate(500,pboot(fm3,fm2))
obsLLDiff <- -2*(logLik(fm3)-logLik(fm2))
pValue = mean(sleepstudy_PB>=obsLLDiff) 
pValue
```

```
[1] 0.78
```

*** 

```r
hist(sleepstudy_PB, breaks = 50, xlim = c(0,120))
abline(v = obsLLDiff, col = "red", lwd = 2)
```

<img src="MixedSelection-figure/unnamed-chunk-25-1.png" title="plot of chunk unnamed-chunk-25" alt="plot of chunk unnamed-chunk-25" style="display: block; margin: auto;" />
</font>

Deviation from chisq minimal
===

<font size="5">

To see whether the bootstrapped distribution deviates from a chisq distribution with df = 1.

<img src="MixedSelection-figure/unnamed-chunk-26-1.png" title="plot of chunk unnamed-chunk-26" alt="plot of chunk unnamed-chunk-26" style="display: block; margin: auto;" />
</font>

Should you select the random effect structure?
===

Not quite sure - as random effects have a built-in shrinkage, so we might not have to be too careful about them

<font size="5">

*Through theoretical arguments and Monte Carlo simulation, we show that LMEMs generalize best when they include the maximal random effects structure justified by the design. The generalization performance of LMEMs including data-driven random effects structures strongly depends upon modeling criteria and sample size, yielding reasonable results on moderately-sized samples when conservative criteria are used, but with little or no power advantage over maximal models. Finally, random-intercepts-only LMEMs used on within-subjects and/or within-items data from populations where subjects and/or items vary in their sensitivity to experimental manipulations always generalize worse than separate F1 and F2 tests, and in many cases, even worse than F1 alone. Maximal LMEMs should be the "gold standard" for confirmatory hypothesis testing in psycholinguistics and beyond.*

Barr, D. J.; Levy, R.; Scheepers, C. & Tily, H. J. (2013) Random effects structure for confirmatory hypothesis testing: Keep it maximal. Journal of Memory and Language, 68, 255-278.
</font>


Conclusions
===

- If you just want to compare two models, LRT work fine

  - Can select random and fixed effects, but don't overdo it with the random effects

  - chisq approximation in anova is useable, but better to use the parametric bootstrap in most cases, solves small data and df problems. 
  
  - My code, or packages RLRsim, PBmodcomp



Example II: many models 
===

Practical viewpoint is that AIC is the most accepted score, so probably least resistance in publishing

$$AIC = 2 k - 2 log (L(\phi))$$


Our "old" dataset
===



Measured beetle counts over 20 years on 50 different plots across an altitudinal gradient, with the predictors moisture (varying from year to year) and altitude (fix for each plot). I added another variable temperature which shows some colinearity with altitude and moisture, and which could have an effect

<font size="5">

```r
str(data)
```

```
'data.frame':	1000 obs. of  8 variables:
 $ dataID           : int  1 2 3 4 5 6 7 8 9 10 ...
 $ beetles          : int  2 32 5 1 1 46 6 1 6 4 ...
 $ moisture         : num  0.185 0.702 0.573 0.168 0.944 ...
 $ altitude         : num  0 0 0 0 0 0 0 0 0 0 ...
 $ temperature      : num  2.14 1.34 2.16 2.32 1.29 ...
 $ plot             : int  1 1 1 1 1 1 1 1 1 1 ...
 $ year             : int  1 2 3 4 5 6 7 8 9 10 ...
 $ spatialCoordinate: num  0 0 0 0 0 0 0 0 0 0 ...
```
</font>

Visually
===

<font size="4">
<img src="MixedSelection-figure/unnamed-chunk-29-1.png" title="plot of chunk unnamed-chunk-29" alt="plot of chunk unnamed-chunk-29" style="display: block; margin: auto;" />
</font>

*** 

<font size="4">
<img src="MixedSelection-figure/unnamed-chunk-30-1.png" title="plot of chunk unnamed-chunk-30" alt="plot of chunk unnamed-chunk-30" style="display: block; margin: auto;" />
</font>

Question
===

- Ecologically: what is the niche of the species, what is the effect of altitude?

- Statistical: if we wouldn't know the true model, could we find it by comparing different model structures?


Define full model
===


<font size="4">

```r
fullModel <- glmer(beetles ~ moisture + I(moisture^2) + altitude + I(altitude^2) + temperature + I(temperature^2) + (0 + moisture|year) + (1|plot) + (1|dataID), family = "poisson", na.action="na.fail")
```
</font>


Using dredge() in MuMIn
===

This tests all possible submodels 

<font size="4">

```r
library(MuMIn)

submodels <- dredge(fullModel)
print(submodels[1:10])
```

```
Global model call: glmer(formula = beetles ~ moisture + I(moisture^2) + altitude + 
    I(altitude^2) + temperature + I(temperature^2) + (0 + moisture | 
    year) + (1 | plot) + (1 | dataID), family = "poisson", na.action = "na.fail")
---
Model selection table 
   (Intrc) alttd alttd^2 mostr  mostr^2     tmprt tmprt^2 df    logLik
40  0.8783 7.458  -7.127 1.879                    0.01089  8 -3203.306
24  0.8680 7.447  -7.118 1.875           0.027800          8 -3203.605
8   0.9367 7.414  -7.113 1.850                             7 -3205.171
56  0.8850 7.460  -7.130 1.879          -0.010330 0.01442  9 -3203.285
48  0.8806 7.458  -7.127 1.871 0.006990           0.01079  9 -3203.301
32  0.8737 7.447  -7.118 1.854 0.018610  0.027350          9 -3203.568
16  0.9442 7.415  -7.113 1.815 0.030930                    8 -3205.067
64  0.8859 7.460  -7.130 1.874 0.003919 -0.009677 0.01413 10 -3203.283
36  0.8833 7.456  -7.127                          0.01029  7 -3213.963
20  0.8738 7.445  -7.118                 0.026180          7 -3214.237
     AICc delta weight
40 6422.8  0.00  0.287
24 6423.4  0.60  0.213
8  6424.5  1.70  0.123
56 6424.8  1.99  0.106
48 6424.8  2.03  0.104
32 6425.3  2.56  0.080
16 6426.3  3.52  0.049
64 6426.8  4.03  0.038
36 6442.0 19.28  0.000
20 6442.6 19.83  0.000
Models ranked by AICc(x) 
Random terms (all models): 
'0 + moisture | year', '1 | plot', '1 | dataID'
```
</font>

Best model
===

<font size="4">

```r
best <- get.models(submodels, subset = 1)[[1]]
summary(best)
```

```
Generalized linear mixed model fit by maximum likelihood (Laplace
  Approximation) [glmerMod]
 Family: poisson  ( log )
Formula: beetles ~ altitude + I(altitude^2) + moisture + temperature +  
    (0 + moisture | year) + (1 | plot) + (1 | dataID)

     AIC      BIC   logLik deviance df.resid 
  6423.2   6462.5  -3203.6   6407.2      992 

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-2.3553 -0.6306 -0.0415  0.5366  4.2107 

Random effects:
 Groups Name        Variance Std.Dev.
 dataID (Intercept) 0.0000   0.0000  
 plot   (Intercept) 0.4541   0.6739  
 year   moisture    1.8459   1.3586  
Number of obs: 1000, groups:  dataID, 1000; plot, 50; year, 20

Fixed effects:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)     0.8680     0.2789   3.113  0.00185 ** 
altitude        7.4472     1.2750   5.841 5.19e-09 ***
I(altitude^2)  -7.1178     1.2331  -5.772 7.82e-09 ***
moisture        1.8754     0.3048   6.153 7.61e-10 ***
temperature     0.0278     0.0157   1.770  0.07665 .  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Correlation of Fixed Effects:
            (Intr) altitd I(l^2) moistr
altitude    -0.849                     
I(altitd^2)  0.723 -0.967              
moisture    -0.009  0.001  0.000       
temperature -0.139  0.015 -0.002  0.048
```
</font>

Excursion: R2 for GLMM
===

<font size="5">

If you really want to use this, there are some ideas how to calculate R2 for (G)LMMs, based on Nakagawa, S, Schielzeth, H. (2012). A general and simple method for obtaining R^2 from Generalized Linear Mixed-effects Models. Methods in Ecology and Evolution. Implemented in MuMIn


```r
r.squaredGLMM(best)
```

```
      R2m       R2c 
0.3587817 0.9763625 
```

- First value, Marginal R_GLMM² , represents the variance explained by fixed factors, 
- Second value, Conditional R_GLMM² is interpreted as variance explained by both fixed and random factors (i.e. the entire model)

</font>


Notes on the use of AIC
===

- In general, AIC tends to select too complicated models, specially if the true model is not in the set of candidate models!

- AIC requires Likelihood $L(\phi)$ and degrees of freedom k. Specially the latter is not unambigous for mixed models

  - Due to the problem with defining k for the random effects, I would NOT recommend to use AIC for a global search across all possible random effect structures. Probably better to keep it maximal!

- AICc corrects for small sample size, but this is not perfect, various issues, specially for mixed models 


Some more remarks about dredging
===

Although frequently interpreted as finding the "biologically meaningful" model, MS does not work that way in practice

- The numbers of selected predictors depends STRONGLY on the amount of data you have 

- Parameter estimates are biased upwards when there is multicolinearity 

This severely limits the biological interpretability of results after model selection!

Alternatives to AIC
===

- Cross Validation: very robust, requires much less assumptions, should be used more!!!

- BIC: similar general problems than AIC, except for the fact that it has less tendency towards too complicated models for large data

- DIC: not recommended, unreliable, but widely used for Bayesian hierarchical models

- BF / RJ-MCMC: consistent, but high computational costs

Many more ... 

A note to global model selection in general
===

- MS globally among a large set of possible models generally performs OK to select a model with good predictive abilities, but specially for with little, colinear data
  - poorly in retrieving the correct model structure, 
  - parameters are typically biased upwards 

- If you are in a global MS situation due to no fault of your own, fine

- But don't design experiments relying on global MS, make power analysis in advance and stick to what you can fit without MS!


Example
===

Apply model selection to random data selects a lot of wrong models

<font size="4">

```r
set.seed(3)
n = 15
x1 = runif(n) ; x2 = runif(n) + x1
x3 = runif(n) + x1 ; x4 = runif(n) + x1
x5 = runif(n) + x4 + x3 ; x6 = runif(n) + x4 + x3
x7 = runif(n) + x4

randomData <- data.frame(y = rnorm(n), x1, x2, x3, x4, x5, x6, x7 )

fullModel <- lm(y ~ x1 + x2 + x3 + x4 + x5 + x6 + x7, data = randomData, na.action="na.fail")
submodels <- dredge(fullModel)
print(submodels[1:10])
```

```
Global model call: lm(formula = y ~ x1 + x2 + x3 + x4 + x5 + x6 + x7, data = randomData, 
    na.action = "na.fail")
---
Model selection table 
    (Intrc)      x2     x3     x4     x5      x7 df  logLik AICc delta
83 -0.64320 -0.8341               0.9401 -0.7750  5  -5.828 28.3  0.00
3   0.53450 -0.8390                               3 -11.013 30.2  1.89
91 -0.57190 -0.6950        0.9742 0.7988 -1.3290  6  -4.137 30.8  2.45
89 -0.98010                1.3990 0.7043 -1.6400  5  -7.426 31.5  3.20
81 -1.22100                       0.8969 -0.8676  4  -9.779 31.6  3.23
7  -0.09438 -0.9039 0.7647                        4  -9.800 31.6  3.28
19 -0.30610 -0.9363               0.3866          4  -9.854 31.7  3.39
1  -0.28440                                       2 -13.369 31.7  3.41
73  0.06823                1.8020        -1.4470  4  -9.886 31.8  3.45
77 -0.57830         0.8823 1.8580        -1.5910  5  -8.037 32.7  4.42
   weight
83  0.341
3   0.133
91  0.100
89  0.069
81  0.068
7   0.066
19  0.063
1   0.062
73  0.061
77  0.037
Models ranked by AICc(x) 
```
</font>


Example 3: Full model with shrinkage
===

I wanted to show you the glmmlasso package (Lasso Regression: think of it as a normal regression with parameters being biased towards zero)

<font size="6">

```r
library(glmmLasso)
glmmLasso(fix=beetles ~ moisture + moisture^2 + altitude + I(altitude^2), rnd=list(year=~1), data = data, lambda = 30, family = poisson(link = log))
```
</font>

If you want to have a go, be my guest

Bayesian version of the Lasso
===

<font size="4">

```r
modelstring="
  model {

    # Likelihood
    for (i in 1:nobs) {
      beetles[i]~dpois(lambda[i])
      lambda[i] <- exp(intercept + (moist + Ryear[year[i]]) * moisture[i] + moist2 * moisture[i] * moisture[i] + alt * altitude[i] + alt2 * altitude[i] * altitude[i] + Rplot[plot[i]]  + temp * temperature[i] + temp2 * temperature[i]* temperature[i]) 
    }

    # Effect priors 
    intercept ~ dnorm(0,0.1)
    moist ~ dnorm(0,0.1)
    moist2 ~ dnorm(0,0.1)
    alt ~ dnorm(0,0.01)
    alt2 ~ dnorm(0,0.01)
    temp ~ dnorm(0,0.1)
    temp2 ~ dnorm(0,0.1)

    # Random effects 

    for (i in 1:nplots) {
      Rplot[i]~dnorm(0,sigmaPlot)
    }

    for (i in 1:nyears) {
      Ryear[i]~dnorm(0,sigmaYear)
    }

    # Variance priors 
    sigmaYear~dgamma(0.001,0.001)
    sigmaPlot~dgamma(0.001,0.001)

  }
"
```
</font>

  
Running this
===

<font size="4">

```r
library(R2jags)
modelData=as.list(data)
modelData = append(data, list(nobs=1000, nplots = 50, nyears = 20))

model=jags(model.file = textConnection(modelstring), data=modelData, n.iter=5000,  parameters.to.save = c("intercept", "moist", "moist2", "alt", "alt2","temp", "temp2", "sigmaPlot", "sigmaYear"))
```

```
Compiling model graph
   Resolving undeclared variables
   Allocating nodes
   Graph Size: 12206

Initializing model
```

```r
print(model)
```

```
Inference for Bugs model at "5", fit using jags,
 3 chains, each with 5000 iterations (first 2500 discarded), n.thin = 2
 n.sims = 3750 iterations saved
           mu.vect  sd.vect     2.5%      25%      50%      75%    97.5%
alt          7.225    1.324    4.583    6.343    7.221    8.124    9.816
alt2        -6.903    1.282   -9.437   -7.748   -6.902   -6.049   -4.374
intercept    0.927    0.296    0.355    0.736    0.933    1.117    1.516
moist        1.852    0.340    1.176    1.636    1.855    2.066    2.524
moist2       0.005    0.086   -0.140   -0.044    0.005    0.051    0.139
sigmaPlot   25.394  839.598    1.298    1.772    2.056    2.363    3.059
sigmaYear    8.237  280.701    0.240    0.396    0.498    0.618    0.898
temp        -0.010    0.060   -0.112   -0.046   -0.012    0.023    0.088
temp2        0.015    0.020   -0.021    0.002    0.015    0.027    0.051
deviance  6010.089 1478.025 5944.970 5958.402 5966.734 5975.400 5993.607
           Rhat n.eff
alt       1.001  3800
alt2      1.001  3800
intercept 1.001  3800
moist     1.001  3800
moist2    1.001  3800
sigmaPlot 1.001  3800
sigmaYear 1.001  3800
temp      1.003   960
temp2     1.003   770
deviance  1.001  3800

For each parameter, n.eff is a crude measure of effective sample size,
and Rhat is the potential scale reduction factor (at convergence, Rhat=1).

DIC info (using the rule, pD = var(deviance)/2)
pD = 1092859.5 and DIC = 1098869.6
DIC is an estimate of expected predictive error (lower deviance is better).
```
Note: the large max values for the sigma are due to a known bug http://stats.stackexchange.com/questions/45193/r2jags-does-not-remove-the-burn-in-part-sometimes, I was just too lazy to remove the burnin by hand
</font>

Graphically
===

<font size="4">

```r
plot(model$BUGSoutput, display.parallel = T)
```

<img src="MixedSelection-figure/unnamed-chunk-39-1.png" title="plot of chunk unnamed-chunk-39" alt="plot of chunk unnamed-chunk-39" style="display: block; margin: auto;" />
</font>


===
Decision tree

- Compare two models random / fixed

  - Nested: LRT via parametric bootstrap, or if lazy anova()
  - Non-nested: AIC, or better Bayes Factor
  
- Compare many models fixed / (random)

  - AIC OR BIC
  - Full model, and frequentist (Lasso) or Bayesian Regularization


Conclusions 
===

- We can use the normal model selection methods also for mixed models, 

  - with the usual caveats
  - and a few more complications

- Global selection of random effect structures doesn't seem reliable to me, because of the df problem. Probably better to fix the random effect structure biologically.

- There is a lot of things that can go wrong with model selection! If you don't have to, don't do it!

  












