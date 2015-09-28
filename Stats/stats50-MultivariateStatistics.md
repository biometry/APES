---
layout: page
title: Multivariate statistics
category: stats
subcategory: Advanced topics
---

Multivariate statistics
===

Multivariate statistics in the strict sense are statistics with a **multivariate response**. The large variety of methods can be loosely grouped into methods that compute distances between the elements of the (multivariate) response Y and then relate this distance matrix to predictors (sometimes called "indirect ordination"). Or those methods that directly compare two matrices (raw data or distances). In either case, multivariate statistics make heavy use of linear algebra and permutations of data (for testing). Some basic knowledge of both methods is essential for understanding multivariate statistics. 

Recommended sources:
There are few good books tackling multivariate statistics. First and foremost to mention is Numerical Ecology, by Legendre & Legendre (3rd edition 2013). This is a heavy tomb, somewhat tedious to work with, but very comprehensive! A "best of" with R is Borcard, Gillet & Legendre (2011). More recently, and for free, is Greenacre & Primicerio (2013). All three use R as reference software.


Borcard, D., Gillet, F., Legendre, P., 2011. Numerical Ecology with R. Springer, Berlin.

Greenacre, M., Primicerio, P., 2013. Multivariate Analysis of Ecological Data. Fundacíon BBVA. http://www.multivariatestatistics.org/

Legendre, P., Legendre, L., 2013. Numerical Ecology, 3rd ed. Elsevier Science.


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
