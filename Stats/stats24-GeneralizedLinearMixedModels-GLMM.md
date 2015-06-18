---
layout: page
title: Generalized linear mixed models
category: stats
subcategory: Regression
---

Generalized linear mixed models (GLMM)
===


## Definition 

GLMMs are GLMs with random effects added, in the same way as LMM are linear models with a random effect added. 

For description of random effects / mixed effects, see the page about mixed effects. Nothing new appears for GLMMs. The only issue with GLMMs as opposed to LMMs is that estimation, but in particular the calculation of confidence intervals and model selection is not so easy, because general parametric methods are not available. 

Hence, many common tasks like residual checks, confidence intervals or model selection require nonparametric or Bayesian methods (or one has to go back to approximations that are not reliable in general). 

## Estimation

### Standated GLMMs

Maximum likelihood estimation in R with mainly with mle4 or nle. 

* http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r
* http://jaredknowles.com/journal/2014/5/17/mixed-effects-tutorial-2-fun-with-mermod-objects

Bayesian estimation with JAGS or STAN, glmmMCMC.

### Multinomial models 

Multinomial models can be estimated with

* mlogit: base package for estimating multinomial logit models http://cran.r-project.org/web/packages/mlogit/index.html 
* glmmMCMC: http://glmmadmb.r-forge.r-project.org/
* mclogit: estimate parameters for the conditional logit model (also with multinomial counts), and for the mixed conditional logit model, or conditional logit with random effects (random intercepts only, no random slopes yet). The current implementation of random effects is limited to the PQL technique, which requires large cluster sizes. http://cran.r-project.org/web/packages/mclogit/index.html
* coxme: Mixed Effects Cox Models - Cox proportional hazards models containing Gaussian random effects, also known as frailty models. http://cran.r-project.org/web/packages/coxme/index.html
* TwoStepCLogit: Conditional logistic regression with longitudinal follow up and individual-level random coefficients: A stable and efficient two-step estimation method http://cran.r-project.org/web/packages/TwoStepCLogit/
* Fully Bayesian solutions in Bugs, Jags or STAN

Note: there seems to be some inconsistency in what people mean by a mixed multinomial logit. Check packages for the exact specification of the rando effect structure (if any)

See also https://gist.github.com/casallas/8263818

### Challenges in the estimation 

Browne, W. J.; Draper, D. & others (2006) A comparison of Bayesian and likelihood-based methods for fitting multilevel models. Bayesian Analysis, International Society for Bayesian Analysis, 1, 473-514.


## Confidence intervals 

http://www.r-bloggers.com/confidence-intervals-for-prediction-in-glmms/


## Model validation 


## Model selection 

Material from "in silico ecology", with link to e.g. model selection in mixed effect models
http://www.r-bloggers.com/notes-on-shrinkage-prediction-in-hierarchical-models/






# Literature

Bayesian 

Fong, Y.; Rue, H. & Wakefield, J. (2010) Bayesian inference for generalized linear mixed models. Biostatistics, 11, 397-412.
