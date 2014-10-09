---
layout: page
title: Linear mixed models
category: stats
subcategory: Regression
---

Linear mixed models
===


Synopsis: remember that the assumptions of the linear regression were that

1. The response variable is linearly correlated to the predictor varialbes or to functions of the predictor variables
2. The variability around this deterministic part
  a. iid
  b. normal (gaussian)

The linear mixed model keeps assumptions 1. and 2b., but changes 2a: the variability doesn't need to be independent any more, but can be correlated between groups of data points.

The linear mixed model has become a kind of standard weapon in ecology, because many datasets and experimental desings suggest that one should set up the model in this structure. Examples are:

* We are measuring individuals in a population, and individuals are measured more than once. Clearly, if the first mearurment of individual A is higher than our expectation from the model, we might also expect the second measurement of this individual to be higher. Hence, measurements are not independent, but rather measurements of the same individual can be expected to be closer to each other than between different individuals (grouping: individual)
* Plot designs: we have n plots, and each plot has k treatments. If a measurements of treatment 1 in plot A is higher than expected from the model, we might also expect the measurement of treatment 2 to be higher than expected. The idea that is that therea are some random differences between plots, that act uniformly on all treatments. Hence, treatments on the same plot are not independent, grouping: plot.

The idea of the mixed model ist to split the variance that is to take the normal linear model with its iid normal error, but add an additional error that is typically also assumed to be normal, and that is iid, but not for each data point, but for each group (i.e. all data points in the same group get the same error)

Thus, the model structure is 

y = a x + b + N(0,sigmaData) + N(0, sigmaGroup)

where the second term, N(0, sigmaGroup) acts on the groups and not on the individual data point.


Material for later:

Note that we need to fit the model using maximum likelihood, **not** REML (restricted/residual maximum likelihood). REML is dependent on the fixed effects and changes as the fixed part of the model changes. Hence we cannot compare likelihoods of two REML-fitted mixed models differing in their fixed structure (see, e.g., http://www.unc.edu/courses/2010fall/ecol/563/001/docs/lectures/lecture28.htm). 


http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r


# R<sup>2</sup> for mixed models

<!--![Mou icon](http://mouapp.com/Mou_128.png)-->

## What's the problem?

Linear regression models (LMs) allow the computation of a measure of model fit called R<sup>2</sup>. The function `summary.lm` will automatically return this value. 

For Generalised Linear Models (GLMs), where the data are not following a normal distribution, no exact analogue of  R<sup>2</sup> exists. (There are several alternatives, e.g. Nagelkerke's R<sup>2</sup>, but that is a story for another day.) Typically, people here compute something often called D<sup>2</sup>, i.e. an R<sup>2</sup> based on the deviance explained by the model. It is computed as
$$
 D^2 = 1- \frac{D_0 - D_R}{D_0} = \frac{D_0 - D_R}{D_0},
$$
where $$$ D_0 $$$ is the null deviance and $$$D_R$$$ is the residual deviance. This deviance-based pseudo-R<sup>2</sup> is rather widespread. 

Due to the link-function used in GLMs (apart when using the identity link, which is common really only with normal data, and then we are back to the LM), the model is actually a non-linear function, and R<sup>2</sup>s don't make sense for non-linear regression (another topic again, but see [here](https://stat.ethz.ch/pipermail/r-help/2002-July/023461.html) for some discussion).

Now we're coming to **mixed models** (be it linear or generalised linear, i.e. LMM or GLMM). Here the problem (in the case of GLMM: the *additional* problem) is that typically no likelihood (and hence no deviance) is being maximised, but rather a penalised quasi-likelihood (PQL), or a restricted maximum likelihood (REML). This is because the random effects make the analytical solution of the likelihood unbearable complicated, while a solution proportional to the true likelihood exists and can be computed with much less effort (the pseudo-likelihood, or the quasi-likelihood; again, we won't go into the differences between these two expressions, see here: Nelder 2000, if you must).
 
The key problems ar that any change to the random structure of the model completely changes the function that is being optimised and hence (1) **no two models with different random effect structure are comparable by their pseudo/quasi-likelihood values**. Also, (2) the **models do not readily tell you which proportion of the variance is explained by the fixed and by the random terms of the model**. 

## What's the solution?

What people do, although that is not strictly correct but apparently "approximately okay" is to compute a pseudo-R<sup>2</sup> for the comparison of the fitted model and a intercept-only model with the same random effect structure (see Thornton & Fletcher 2014 for an example).

Let $$$ll_0$$$ be the log-likelihood of the intercept-only model (it serves as our null model, just as in the case of the D<sup>2</sup>-case above) and $$$ll_f$$$ the log-likelihood of our fitted model with fixed effects. Then we can, in complete analogy to the D<sup>2</sup>-function above), compute a pseudo-R<sup>2</sup>-value $$$pR$$$ as
$$
	pR = \frac{ll_0 - ll_f}{ll_O}.
$$

For a typical fitted model (e.g. using `nlme::lme`, `lme4::glmer`, `lme4::lmer`, `MASS::glmmPQL`) the log-likelihood can be accessed using function `logLik`.

## Example in R
This uses the cbpp data from package **lattice**; the example is take from the help page of `lme4::glmer`.

```R
> require(lme4)
> require(lattice)

> gm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), data = cbpp, family = binomial)
> logLik(gm1)
'log Lik.' -92.02657 (df=5)
> gm0 <- glmer(cbind(incidence, size - incidence) ~ 1 + (1 | herd), data = cbpp, family = binomial)
> logLik(gm0)
'log Lik.' -104.8315 (df=2)
# now compute pR:
> as.vector(logLik(gm0) - logLik(gm1)) / logLik(gm0))
[1] 0.1221481
```
So we see that the fixed effect "period" only explains a small proportion of the model's deviance. I recommend not going so far as to claim that it is actuall 12%!

(The `as.vector` is only used to get rid of the names and attributes of the output, otherwise it would be a bit confusing.)

## References

Nelder JA (2000) Quasi-likelihood and pseudo-likelihood are not the same thing. J Appl Stat 27: 1007–1011. doi: 10.1080/02664760050173328

Thornton DH, Fletcher RJ (2014) Body size and spatial scales in avian response to landscapes: a meta-analysis. Ecography 37: 454–463. doi: 10.1111/j.1600-0587.2013.00540.x



