Assumptions, power analysis, validation and model comparison of mixed effects models - Session I
========================================================
author: Florian Hartig
date: 4th mixed model session

Reminder
===
incremental: true

We started with the **generalized linear model (GLM)** framework. We want to see how the **response y** depends on a number of **predictors $X = x_1 ... x_n$**

- $y_{lin} = A * X + b$ (**linear predictor**) codes influence of the predictors
- $y_{res} = f(y_{lin})$ (**link function**) transformation that brings $y_{lin}$ on the right interval
- $y_{res}$ goes in an **error model** (probability distribution) 

So, we have **$y_{obs} \sim Distribution(mean= link(A \cdot X + b))$**, and we use that to calculate probability of seing the data $y_{obs}$ given the model parameters (Likelihood)        


Examples
===
incremental: true

**Linear regression** is when the link function is the identity function, and the error is normally distributed

- $y \sim Norm(\mu = A \cdot X + b, \sigma )$

**Poisson regression** is when the link function is exponential (to bring the response to $(0,\infty)$, and the error is poisson

- $y \sim Poisson(\mu= exp(A \cdot X + b))$

Estimation
===
incremental: true

In either case, what R does is 

- Looking for the parameters that result in the highest likelihood (**MLE estimate**)

- Calculate a number of other things (**confidence intervals, p-values per parameter, overall p-value**)


Example Poisson regression by hand I
===

![plot of chunk unnamed-chunk-1](MixedEffectsFoundationsFH-figure/unnamed-chunk-1.png) 


Example Poisson regression by hand II
===

Definining the likelihood


```r
loglikelihood <- function(par){
  
  linear = par[1]*attrakt + par[2]  
  
  linkPrediction = exp(linear)    
  
  logprobabilities = dpois(stuecke, linkPrediction, log=T)  
  
  return(-sum(logprobabilities))
}
```

Example Poisson regression by hand III
===

Plotting the likelihood surface (= likelihood as a function of slope, intercept)

![plot of chunk unnamed-chunk-3](MixedEffectsFoundationsFH-figure/unnamed-chunk-3.png) 
 
Example Poisson regression by hand IV
===

Optimization with the optim function
<font size="4">

```r
bestfit = optim(c(0.12,1.3), loglikelihood, method = "BFGS", hessian = T)
bestfit
```

```
$par
[1] 0.1479 1.4745

$value
[1] 55.71

$counts
function gradient 
      19        6 

$convergence
[1] 0

$message
NULL

$hessian
     [,1] [,2]
[1,] 2225  573
[2,]  573  174
```

```r
bestfit$hessian
```

```
     [,1] [,2]
[1,] 2225  573
[2,]  573  174
```
</font>




Common extension of GLMs
===  
incremental: true

1) Extensions of the functional response 

- **nonlinear regression** means that $y \sim f(parameter, x)$ is **nonlinear in the parameters** -> in R: nls
- Smooth response functions (**generalized additive models, GAM**) -> in R: gam, mgcv

2) Relaxing the iid assumption of the errors

- autocorrelation and heteroskedasticity -> **generalized least square (GLS)**
- Structured errors -> **Mixed models**

Relaxing the iid assumption
===

iid = **identical and independently distributed**. 

Not iid: e.g. **heteroskedasticity, autocorrelation**

- Homogenous heteroskedasticity, autocorrelation can be treated in the framework of **generalised least square models**, e.g. in the gls function in R

- Structured (blocked) correlation in the random terms: **random effects**!

There is an important technical difference between those two

Generalised least square models (GLS)
===

Reminder: linear regression was 

- $y \sim Norm(\mu = A \cdot X + b, \sigma )$

GLS is 

- $y \sim MultiNorm(\mu = A \cdot X + b, \Sigma(X) )$

This is identical to the structure of a linear regression, except that the homogenous variance of the normal error is replaced by **matrix $\Sigma(X)$** to accomdate autocorrelation (via off-diagonal elements) and a potential dependence on the predictors (heteroskedasticity)


Mixed models are different
===

Mixed models are multi-level models, aka hierarchical models. Their general structure is that of a GLM

- $y_{obs} \sim Distribution(mean = link (A \cdot X + b + R))$ 

but with a **new term R**, which depends on a second error term

- $R \sim Norm(0, \sigma)$ 

R is what is called a **latent variable**, meaning that we can't observe it directly. It depends on a random process (Normal distribution), with its variance controlled by a **hyperparameter** $\sigma$. The two levels of error make this a **hierarchical model**

Consequences of the hierarchical structure
===

$y_{obs} \sim Distribution(mean = link (A \cdot X + b + R))$ 
$R \sim Norm(0, \sigma)$ 

- # parameteres / degrees of freedom not clear, because the hyperparameter $\sigma$ dermines how much freedom the random effect terms have 
- More technical: MLE estimates of the variance parameters are biased for typical sample sizes


Restricted maximum likelihood (REML)
===

Basically, the problem is that MLE estimates can have a relatively large bias for smaller sample sizes. REML behaves better here by first estimating the variance components, and then the fixed effects in a second step. 

- Better parameter estimates, therefore why standard
- Does not return full Likelihood values --> therefore we have to switch REML off if we want to use Likelihood / AIC values or similar

With REML to estimate the parameters, you can only compare two models that have the identical fixed-effects design matrices and are nested in their random-effects terms.

REML in lme4
===




```r
logLik(lmer(normexam ~ standLRT + (1 | school), data=Exam, REML = T))
```

```
'log Lik.' -4684 (df=4)
```

```r
logLik(lmer(normexam ~ standLRT + (1 | school), data=Exam, REML = F))
```

```
'log Lik.' -4679 (df=4)
```

Variations for including random effects
===

Random effect can be on 

- **Random interecpt**, meaning that each group has a different intercept, but the effect of all other predictors is the same across group

- **Random slope**, meaning that the effect of a predictor is different across groups 

Random effects can be 

- **Nested**. Random B is nested in random A, if groups in A only appear in one of the groups of B (non-crossed). 

- **Non-nested**, also called crossed - if A and B are random variables, but act independently on the linear predictor


Random effect only
===


```r
lmer(normexam ~ 1 + (1 | school), data=Exam)
```

```
Linear mixed model fit by REML ['lmerMod']
Formula: normexam ~ 1 + (1 | school)
   Data: Exam
REML criterion at convergence: 11015
Random effects:
 Groups   Name        Std.Dev.
 school   (Intercept) 0.414   
 Residual             0.921   
Number of obs: 4059, groups:  school, 65
Fixed Effects:
(Intercept)  
    -0.0133  
```

Mixed with random intercept
===


```r
lmer(normexam ~ standLRT + (1 | school), data=Exam)
```

```
Linear mixed model fit by REML ['lmerMod']
Formula: normexam ~ standLRT + (1 | school)
   Data: Exam
REML criterion at convergence: 9369
Random effects:
 Groups   Name        Std.Dev.
 school   (Intercept) 0.306   
 Residual             0.752   
Number of obs: 4059, groups:  school, 65
Fixed Effects:
(Intercept)     standLRT  
    0.00232      0.56331  
```

Mixed with random slope AND intercept
===


```r
lmer(normexam ~ standLRT + (standLRT | school), data=Exam)
```

```
Linear mixed model fit by REML ['lmerMod']
Formula: normexam ~ standLRT + (standLRT | school)
   Data: Exam
REML criterion at convergence: 9328
Random effects:
 Groups   Name        Std.Dev. Corr
 school   (Intercept) 0.304        
          standLRT    0.122    0.49
 Residual             0.744        
Number of obs: 4059, groups:  school, 65
Fixed Effects:
(Intercept)     standLRT  
    -0.0116       0.5565  
```

Including more than one random effect
=== 

What is confusing to many is the different between independent (crossed) and nested random effects. 

Again, we use independend random effects if we have a crossed design, meaning that groups in A and groups in B appear in all possible combinations. We use nested effects if groups in A only appear in one of the groups of B

See also Schielzeth, H. & Nakagawa, S. (2013) Nested by design: model fitting and interpretation in a mixed model era. Methods in Ecology and Evolution, 4, 14-24.


Mixed with two independent (crossed) random effects
===


```r
lmer(normexam ~ standLRT + (1 | school) + (1 | student), data=Exam)
```

```
Linear mixed model fit by REML ['lmerMod']
Formula: normexam ~ standLRT + (1 | school) + (1 | student)
   Data: Exam
REML criterion at convergence: 9368
Random effects:
 Groups   Name        Std.Dev.
 student  (Intercept) 0.0564  
 school   (Intercept) 0.3060  
 Residual             0.7501  
Number of obs: 4059, groups:  student, 650; school, 65
Fixed Effects:
(Intercept)     standLRT  
     0.0023       0.5638  
```

Mixed with random slope and intercept
===


```r
lmer(normexam ~ standLRT + (1 | school/student), data=Exam)
```

```
Linear mixed model fit by REML ['lmerMod']
Formula: normexam ~ standLRT + (1 | school/student)
   Data: Exam
REML criterion at convergence: 9369
Random effects:
 Groups         Name        Std.Dev.
 student:school (Intercept) 6.79e-07
 school         (Intercept) 3.06e-01
 Residual                   7.52e-01
Number of obs: 4059, groups:  student:school, 4055; school, 65
Fixed Effects:
(Intercept)     standLRT  
    0.00232      0.56331  
```

Note that (1 | school/student) is equivalent to (1|shool)+(1|school:student). It doesn't work very well here because the two factors here seem to be crossed.


===
Power analysis

**Power analysis** is when we want to find out how likely it is that we get a significant effect with a given experimental setup

For GLMM, difficult to give the probability in a closed formula --> but what we can always do is simulate.


=== 
Function to simulate the data 


```r
createData <- function(plots = 10, samplesizePerPlot = 20, effect = 1, plotvariance = 1){
  
  plot = rep(1:plots, each = samplesizePerPlot)
  randomEffect = rnorm(plots, 0, plotvariance)
  gradient = seq(-1, 1, length.out = plots)
  gradient = rep(gradient, each = samplesizePerPlot)
  
  beetles <- rpois(plots * samplesizePerPlot, exp(gradient * effect + randomEffect[plot]))
  return(data.frame(plot, gradient, beetles ))
}
```

=== 
Check whether this works


```r
test <- createData()
boxplot(beetles ~ gradient, data = test)
```

![plot of chunk unnamed-chunk-14](MixedEffectsFoundationsFH-figure/unnamed-chunk-14.png) 


Choose the analysis we want to do
===


```r
library(lmerTest)

analysis <- function(data){
  fit <- glmer(beetles ~ gradient + (1|plot), data=data, family = "poisson")
  fitSum <- summary(fit)
  return(c(fitSum$coefficients[2,1], fitSum$coefficients[2,4]))
}
analysis(test)
```

```
[1] 1.09176 0.02115
```



Doing this for many simulations
===



```r
size = 100

results <- data.frame(estimate = rep(NA, size), pValue = rep(NA, size))
for (i in 1:size){
  data <- createData()
  singleResult <- analysis(data)
  results[i,] <- singleResult
}
```


Result visual
===


![plot of chunk unnamed-chunk-17](MixedEffectsFoundationsFH-figure/unnamed-chunk-17.png) 


Result in numbers
===


```r
sum(results$pValue < 0.05) / length(results$pValue)
```

```
[1] 0.63
```


===
Outlook next time

- Model validation (residual analysis) for (G)LMMs
- Model selection
  - # parameters?
  - Likelihood? Which model selection criteria work? AIC, BIC, DIC, Bayes Factors
  - Alternatives to the currently used approximations for p-values in lmerTest







