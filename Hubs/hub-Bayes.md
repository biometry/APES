---
layout: page
title: Bayesian statistics 
category: hubs
---

# Introduction

Bayesian inference is often named as an alternative to "standard statistics" for solving particular problems.

The most common misunderstanding, and the also the most important thing to understand about Bayesian inference that BAYESIAN INFERENCE IS NOT ABOUT USING DIFFERENT STATISTICAL MODELS. Bayesian inference is based on the same statistical model assumptions (Regression, mixed models, ...) than "standard" statistical inference (if compared to Bayesians, standard statistical approaches are called "frequentist"). 

What Bayesian Inference adds is a different way to EVALUATE statistical models. In short, it allows to calculate a POSTERIOR DISTRIBUTION as a result of the model, instead of the point estimate given by maximum likelihood estimation. The interpretation of the posterior is a bit different to what you are probably are used to.


An example showing that how all typical inferential produces (p-values, MLE, Bayesian posterior) are derived from the same model is provided [here](https://github.com/florianhartig/LearningBayes/blob/master/CommentedCode/01-Principles/InferenceMethods.md)

# Why use Bayesian inference?

In a nutshell, because the posterior is easier to calculate than the maximum likelihood estimate for complicated, hierarchical models such as state-space models, models with latent variables (see examples [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/05-HierarchicalAndSpatialModels)) In particular the calculcation of maximum likelihood confidence intervals gets really tricky for this kind of models. 

It is hard to understand why as a beginner, but one reason why Bayesian approaches fare better is that they estimate the posterior by sampling algorithms such as MCMC (see [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/02-Samplers)), and these do better for the more complicated statistical models than optimization algorithms that are used for MLE.


# How to do Bayesian inference in practice


A more detailed page on how to do Bayesian inference in practice is [here](http://florianhartig.github.io/LearningBayes/). The links above go to this page as well. 


# Bayesian inference with process-based models 

See [here](https://github.com/florianhartig/LearningBayes/tree/master/CommentedCode/09-BayesAndProcessBasedModels)




