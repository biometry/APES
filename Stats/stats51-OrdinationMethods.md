---
layout: page
title: Ordination methods
category: stats
subcategory: Multivariate statistics
maintainer: Florian Hartig
---

Ordination methods
===


## Principal component analysis (PCA)

http://liorpachter.wordpress.com/2014/05/26/what-is-principal-component-analysis/

## Correspondence analysis (CA) 

## Redundancy analysis (RDA)

## Multidimensional scaling (MDS)






## Comments about assumptions and when to choose what

1) The original motivation for the algorithms that underlie PCA and RDA involve a multivariate normal distribution, in the sense that someone said: if the data is multivariate normal, then this is a good way to summarize the variability in this data.

2) But no one said we cannot apply these calculation rules non-normal data - as long as we are not calculating p-values or confidence intervals, you are not violating assumptions - we are just making rotations in the variable space according to a rule that was motivated as explained in 1). 

3) That being said, strong outliers can lead to really weird results because they dominate the transformation. Also skewed distribution and nonlinear correlations in the data can lead to effects that are difficult to interpret. That's why, unlike for a regression, it can make sense to transform variables before putting them into a PCA. 

4) About linearity assuptions: the rotation in variable space is linear, but one can include nonlinearities through transformation of variables, or by including nonlinear terms of the predictors (e.g. a quadratic term). It's the same as for a linear regression - linear regression doesn't mean you can't fit nonlinear functions, it means that the parameters act linear on the predictors.

5) Formally, normality assumptions come back into the game when starting to ask questions about significance. To develop a significance test for RDA, one need to make assumptions about how the data is distributed. See 

In R, the significance for RDA is done via permutation tests [NEED TO CHECK EXACT DETAILS], which should be relatively robust against moderate violations of the normality assumption.

Finally, a good practical introduction to RDA is in the Zuur book, Analysing ecolgical data 12.9 Redundancy analysis, and see also 13.5 When to use PCA, CA, RDA or CCA.
