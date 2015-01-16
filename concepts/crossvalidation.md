---
layout: page
title: Crossvalidation
category: concepts
maintainer: Florian Hartig
---

Crossvalidation
===

Cross-validation (CV) is a common and general technique to assess the predictive performance of a model. The idea of a k-fold cross-validation is to split the data into k parts, fit the model to all possible k subsets with size k-1, and predict on the remaining part.

The remaining predictions are then compared to data, either via a general measure of disrepancy such as RMSE, or via the likelihood of the model.

CV will penalize too complex models because they don't predict well on validation data, and can therefore be used for model selection, even in cases where AIC doesn't work or is not available. For restrictive conditions, CV is approximately equal to AIC (Stone, 1977). 

### References 

Stone, M. (1977) An Asymptotic Equivalence of Choice of Model by Cross-Validation and Akaike's Criterion. Journal of the Royal Statistical Society. Series B, 39, 44-47.


### CV in R

* http://cran.r-project.org/web/packages/cvTools/index.html
* http://topepo.github.io/caret/index.html


### Further links

cross-validation - http://robjhyndman.com/hyndsight/crossvalidation/


