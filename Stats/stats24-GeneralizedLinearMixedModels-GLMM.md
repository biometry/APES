---
layout: page
title: Generalized linear mixed models
category: stats
subcategory: Regression
---

Generalized linear mixed models
===





http://jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r

http://jaredknowles.com/journal/2014/5/17/mixed-effects-tutorial-2-fun-with-mermod-objects

Material from "in silico ecology", with link to e.g. model selection in mixed effect models
http://www.r-bloggers.com/notes-on-shrinkage-prediction-in-hierarchical-models/


### Multinomial response

Note: there seems to be some inconsistency in what people mean by a mixed multinomial logit. Check packages for the exact specification of the rando effect structure (if any)

* mlogit: base package for estimating multinomial logit models http://cran.r-project.org/web/packages/mlogit/index.html 
* glmmMCMC: http://glmmadmb.r-forge.r-project.org/
* mclogit: estimate parameters for the conditional logit model (also with multinomial counts), and for the mixed conditional logit model, or conditional logit with random effects (random intercepts only, no random slopes yet). The current implementation of random effects is limited to the PQL technique, which requires large cluster sizes. http://cran.r-project.org/web/packages/mclogit/index.html
* coxme: Mixed Effects Cox Models - Cox proportional hazards models containing Gaussian random effects, also known as frailty models. http://cran.r-project.org/web/packages/coxme/index.html
* TwoStepCLogit: Conditional logistic regression with longitudinal follow up and individual-level random coefficients: A stable and efficient two-step estimation method http://cran.r-project.org/web/packages/TwoStepCLogit/

see also https://gist.github.com/casallas/8263818

# Literature

Bayesian 

Fong, Y.; Rue, H. & Wakefield, J. (2010) Bayesian inference for generalized linear mixed models. Biostatistics, 11, 397-412.
