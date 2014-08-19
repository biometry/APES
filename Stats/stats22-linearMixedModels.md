---
layout: page
title: Linear mixed models
category: subregression
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

