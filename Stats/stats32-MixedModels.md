---
layout: page
title: Mixed models
category: stats
subcategory: Advanced topics
author: Florian Hartig
maintainer: Florian Hartig
contributor: Carsten Dormann
---
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

Note that we need to fit the model using maximum likelihood, **not** REML (restricted/residual maximum likelihood). REML is dependent on the fixed effects and changes as the fixed part of the model changes. Hence we cannot compare likelihoods of two REML-fitted mixed models differing in their fixed structure (see, e.g., [http://www.unc.edu/courses/2010fall/ecol/563/001/docs/lectures/lecture28.htm](http://www.unc.edu/courses/2010fall/ecol/563/001/docs/lectures/lecture28.htm)). 


[http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r](http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r)

[https://freshbiostats.wordpress.com/2013/07/28/mixed-models-in-r-lme4-nlme-both/](https://freshbiostats.wordpress.com/2013/07/28/mixed-models-in-r-lme4-nlme-both/)


# Confidence intervals and predictive uncertainty

[http://stackoverflow.com/questions/14358811/extract-prediction-band-from-lme-fit/14435982#14435982](http://stackoverflow.com/questions/14358811/extract-prediction-band-from-lme-fit/14435982#14435982)




=======
## Q & A

* Is the model performance or quality affected if the share of variance explained by random effects is larger than the share of variance explained by fixed effects? - No! A priori the model quality is not affected. :-) A large share of variance explained by random effects means that the difference between the experimental/sampling sites (if these differences are treated as random effects) is larger than the effects the model builder is interested in (the fixed effects). So maybe the fixed effects described may be generalised for a large spectrum of sampling sites or a very important variable which could also be treated as fixed effect is missing in the model. In the latter case the model could be enhanced. — Michael Rudner 2012/02/16 18:20

* What do do about Heavy tails / outliers --> Check out heavyLme (package heavy), lqmm (lqmm), or rlmer


## Further links 

* A brilliant starting page for problems with mixed effect models in R is [http://glmm.wikidot.com/faq](http://glmm.wikidot.com/faq), which tries to bundle these discussions on a FAQWA (Frequently Asked Questions With Answers) page. 
* See also: [http://psy-ed.wikidot.com/glmm](http://psy-ed.wikidot.com/glmm), [http://wiki.math.yorku.ca/index.php/SPIDA_2009:_Mixed_Models_with_R](http://wiki.math.yorku.ca/index.php/SPIDA_2009:_Mixed_Models_with_R)



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

The package **MuMIn** offers an (experimental) alternative with the function `r.squaredGLMM`. It computes both marginal R<sup>2</sup> (variance explained by the fixed effects) and the conditional R<sup>2</sup> (variance explained by fixed and random effects), following Nakagawa & Schielzeth (2013). So far, it does not work for all GLM-families (notably the Poisson distribution is not supported). The computation is based only on variances, not on the actual likelihood (it seems) and should thus be a *real* solution.


## Example in R
This uses the cbpp data from package **lattice**; the example is take from the help page of `lme4::glmer`.

```r
> library(lme4)
> library(lattice)
> library(MuMIn)

> gm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), data = cbpp, family = binomial)
> logLik(gm1)
'log Lik.' -92.02657 (df=5)
> gm0 <- glmer(cbind(incidence, size - incidence) ~ 1 + (1 | herd), data = cbpp, family = binomial)
> logLik(gm0)
'log Lik.' -104.8315 (df=2)
```# now compute pR:
> as.vector(logLik(gm0) - logLik(gm1)) / logLik(gm0))
[1] 0.1221481
```# now compute marginal and conditional r2:
> r.squaredGLMM(gm1)
The result is correct only if all data used by the model has not changed since model was fitted.
      R2m       R2c 
0.1054475 0.1127991
```
So we see that the fixed effect "period" only explains a small proportion of the model's deviance. The marginal R<sup>2</sup> is a bit lower, but goes in the same direction. The conditional R<sup>2</sup> indicates that the random effect adds very little to the overall explained deviance in this analysis.

(The `as.vector` is only used to get rid of the names and attributes of the output, otherwise it would be a bit confusing.)

## References

Nakagawa, S. & Schielzeth, H. (2013). A general and simple method for obtaining R2 from generalized linear mixed-effects models. Methods in Ecology and Evolution 4: 133–142.
 
Lahuis, D et al (2014) Explained Variance Measures for Multilevel Models. Organizational Research Methods. 

Nelder JA (2000) Quasi-likelihood and pseudo-likelihood are not the same thing. J Appl Stat 27: 1007–1011. doi: 10.1080/02664760050173328

Thornton DH, Fletcher RJ (2014) Body size and spatial scales in avian response to landscapes: a meta-analysis. Ecography 37: 454–463. doi: 10.1111/j.1600-0587.2013.00540.x
 
 
 
 
 # Generalized linear mixed models (GLMM)
 
 
 **Definition**: GLMMs are GLMs with random effects added, in the same way as LMM are linear models with a random effect added. 
 
 For description of random effects / mixed effects, see the page about mixed effects. Nothing new appears for GLMMs. The only issue with GLMMs as opposed to LMMs is that estimation, but in particular the calculation of confidence intervals and model selection is not so easy, because general parametric methods are not available. 
 
 Hence, many common tasks like residual checks, confidence intervals or model selection require nonparametric or Bayesian methods (or one has to go back to approximations that are not reliable in general). 
 
 ## Estimation
 
 ### "Standard" GLMMs
 
 Maximum likelihood estimation in R with mainly with mle4 or nle. 
 
 * [http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r](http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r)
 * [http://jaredknowles.com/journal/2014/5/17/mixed-effects-tutorial-2-fun-with-mermod-objects](http://jaredknowles.com/journal/2014/5/17/mixed-effects-tutorial-2-fun-with-mermod-objects)
 
 Bayesian estimation with JAGS or STAN, glmmMCMC.
 
 ### Multinomial models 
 
 Multinomial models can be estimated with
 
 * [mlogit](http://cran.r-project.org/web/packages/mlogit/index.html): base package for estimating multinomial logit models.
 * [glmmMCMC](http://glmmadmb.r-forge.r-project.org/)
 * [mclogit](http://cran.r-project.org/web/packages/mclogit/index.html): estimate parameters for the conditional logit model (also with multinomial counts), and for the mixed conditional logit model, or conditional logit with random effects (random intercepts only, no random slopes yet). The current implementation of random effects is limited to the PQL technique, which requires large cluster sizes. 
 * [coxme](http://cran.r-project.org/web/packages/coxme/index.html): Mixed Effects Cox Models - Cox proportional hazards models containing Gaussian random effects, also known as frailty models.
 * [TwoStepCLogit](http://cran.r-project.org/web/packages/TwoStepCLogit/): Conditional logistic regression with longitudinal follow up and individual-level random coefficients: A stable and efficient two-step estimation method
 * Fully Bayesian solutions in Bugs, Jags or STAN
 * [ordinal](http://www.cran.r-project.org/web/packages/ordinal/index.html): Regression Models for Ordinal Data. Implementation of cumulative link (mixed) models also known as ordered regression models, proportional odds models, proportional hazards models for grouped survival times and ordered logit/probit/... models.
 
 Note: there seems to be some inconsistency in what people mean by a mixed multinomial logit. Check packages for the exact specification of the rando effect structure (if any)
 
 [See also](https://gist.github.com/casallas/8263818)
 
 ### Challenges in the estimation 
 
 Browne, W. J.; Draper, D. & others (2006) A comparison of Bayesian and likelihood-based methods for fitting multilevel models. Bayesian Analysis, International Society for Bayesian Analysis, 1, 473-514.
 
 
 ## Confidence intervals 
 
 [http://www.r-bloggers.com/confidence-intervals-for-prediction-in-glmms/](http://www.r-bloggers.com/confidence-intervals-for-prediction-in-glmms/)
 
 
 ## Model validation 
 
 
 ## Model selection 
 
 Material from "in silico ecology", with link to e.g. model selection in mixed effect models
 [http://www.r-bloggers.com/notes-on-shrinkage-prediction-in-hierarchical-models/](http://www.r-bloggers.com/notes-on-shrinkage-prediction-in-hierarchical-models/)
 
 
 

# Power analysis

* In general: use the simulate function 
* Random effects - see Kain, M. P.; Bolker, B. M. & McCoy, M. W. (2015) Letcher, B. (Ed.) A practical guide and power analysis for GLMMs: detecting among treatment variation in random effects. PeerJ, PeerJ, 3, e1226-.
 
 
 
 # Literature
 
 Bayesian 
 
 Fong, Y.; Rue, H. & Wakefield, J. (2010) Bayesian inference for generalized linear mixed models. Biostatistics, 11, 397-412.




