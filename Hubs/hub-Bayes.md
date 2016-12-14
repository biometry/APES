---
layout: page
title: Bayesian statistics 
category: hubs
---

### Introduction

Bayesian inference is often named as an alternative to "standard statistics" for solving particular problems.

The most common misunderstanding, and the also the most important thing to understand about Bayesian inference that BAYESIAN INFERENCE IS NOT ABOUT USING DIFFERENT STATISTICAL MODELS. Bayesian inference is based on the same statistical model assumptions (Regression, mixed models, ...) than "standard" statistical inference (if compared to Bayesians, standard statistical approaches are called "frequentist"). 

What Bayesian Inference adds is a different way to EVALUATE statistical models. In short, it allows to calculate a POSTERIOR DISTRIBUTION as a result of the model, instead of the point estimate given by maximum likelihood estimation. The interpretation of the posterior is a bit different to what you are probably are used to.


An example showing that how all typical inferential produces (p-values, MLE, Bayesian posterior) are derived from the same model is provided [here](https://github.com/florianhartig/LearningBayes/blob/master/CommentedCode/01-Principles/InferenceMethods.md)

### Why use Bayesian inference?

In a nutshell, because the posterior is easier to calculate than the maximum likelihood estimate for complicated, hierarchical models such as state-space models, models with latent variables (see examples [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/05-HierarchicalAndSpatialModels)) In particular the calculcation of maximum likelihood confidence intervals gets really tricky for this kind of models. 

It is hard to understand why as a beginner, but one reason why Bayesian approaches fare better is that they estimate the posterior by sampling algorithms such as MCMC (see [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/02-Samplers)), and these do better for the more complicated statistical models than optimization algorithms that are used for MLE.


### How to do Bayesian inference in practice

* A more detailed page on how to do Bayesian inference in practice is [here](http://florianhartig.github.io/LearningBayes/). The links above go to this page as well. 

* For doing Bayesian inference specifically with process-based models see [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/09-BayesAndProcessBasedModels)

* [Here's](https://biometry.github.io/APES/LectureNotes/StatsCafe/Linear_models_jags.html) a page explaining how to do linear (mixed) models using Bayesian inference in JAGS. For such simple models, there is usually no point doing them in JAGS, but these simple examples will hopefully help you understand more complex Bayesian analyses.

* For the treatment of overdispersion, both in a classical (i.e. frequentist) and Bayesian way, please see [this page](https://biometry.github.io/APES/LectureNotes/2016-JAGS/Overdispersion/OverdispersionJAGS.html). Since the LaTeX-formulae don't render well in markdown, here a link to a [PDF](https://biometry.github.io/APES/LectureNotes/2016-JAGS/Overdispersion/OverdispersionJAGS.pdf).

* For an analysis of zero-inflated Poisson data within a mixed-effect model with overdispersion (and its stepwise derivation) you can consult [this page](https://biometry.github.io/APES/LectureNotes/2016-JAGS/ZeroInflation/ZeroInflation_JAGS.html). Since the LaTeX-formulae don't render well in markdown, here a link to a [PDF](https://biometry.github.io/APES/LectureNotes/2016-JAGS/ZeroInflation/ZeroInflation_JAGS.pdf).

