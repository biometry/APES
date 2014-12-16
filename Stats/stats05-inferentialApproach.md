---
layout: page
title: Inferential approach
category: stats
subcategory: Basic concepts
---

Inferential approaches
===

## Statistical models

The problem with giving a straight answer to the question of whether the response variable is affected by the predictors is that all our ecological data contains random variability. If we take two pots and plant a plant in each one of them, and we expose one plant to classical music and the other to heavy metal, probably one of them will grow taller. But are we sure that this is an effect of the music, or could it just be due to the fact that no plant is exactly the same, and therefore one of the two will typically grow a bit taller?

Thus, to arrive at robust conclusions, we have to make some assumptions about how the growth of plants varies, so that we can see if some differences that we are seeing could be the result of random variation only. These assumptions are what we call a statistical model. A statistical model could, for example, make the assumptions that there is a medium growth rate for each plant species, but that the growth of each individual plant varies with a certain distribution around this mean growth. Based on this, we can now ask ourselves whether the data that we have allows us to draw conclusions about the effect of a predictor. 

## Inferential methods and their outputs

OK, we have some data and a statistical model. But there is still one step to go - how do we say if there is an effect or not? Basically, there are two classical ways of calculating a conclusion from a statistical model and some data: p-values and parameter estimates. There is a third option which I will mention very shortly at the end.  Btw., the process of drawing conclusions from data is called inference, when we use statistical models, we call it statistical inference. 

### p-values

The use of p-values is connected to the concept of null hypothesis significance testing (NHST). The idea is the following: if we have some data observed, and we have a statistical model, we can use this statistical model to specify a fixed hypothesis about how the data did arise. For the example with the plants and music, this hypothesis could be: music has no influence on plants, all differences we see are due to random variation between individuals. Such a scenario is called the null hypothesis. Although it is very typical to use the assumption of no effect as null-hypothesis, note that it is really your choice, and you could use anything as null hypothesis, also the assumption: "classical music doubles the growth of plants". The fact that it's the analyst's choice what to fix as null hypothesis is part of the reason why there are are a large number of tests available. We will see a few of them in the following chapter about important hypothesis tests.

If we have a null hypothesis, we calculate the probability that we would see the observed data or data more extreme under this scenario. This is called a hypothesis tests, and we call the probability the p-value. If the p-value falls under a certain level (the significance level $\alpha$) we say the null hypothesis was rejected, and there is significant support for the alternative hypothesis. The level of $\alpha$ is a convention, in ecology we chose typically 0.05, so if a p-value falls below 0.05, we can reject the null hypothesis. 

A problem with hypothesis tests and p-values is that their results are notoriously misinterpreted. The p-value is NOT the probability that the null hypothesis is true, or the probability that the alternative hypothesis is false, although many authors have made the mistake of interpreting it like that \citep[][]{Cohen-earthisround-1994}. Rather, the idea of p-values is to control the rate of false positives (Type I error). When doing hypothesis tests on random data, with an $\alpha$ level of 0.05, one will get exactly 5\% false positives. Not more and not less.  

### Parameter estimates

The second type of output that is reported by most statistical methods are parameter estimates. Without going into too much detail: while the p-value is the probability of the data or more extreme data under a fixed (null) hypothesis, a parameter estimate (often also called point estimate or maximum likelihood estimate) refers to those of many possible hypothesis that are spanned by a parameter that has the highest probability to produce the observed data. 

In plain words, the parameter estimate is our best estimate for a difference between groups, or the influence between parameters. Again, in contrast, the p-value typically tells us the probability that we would see the data if there is no such influence. 

Parameter estimates are typically accompanies by confidence intervals. Sloppily you can think of the 95\% confidence interval of a parameter as the probable range for this area. Somewhat confusing for many, it's not the interval in which the true parameter lies with 95\% probability. Rather, in a repeated experiments, the standard 95\% CI will contain the true value in 95\% of all cases. It's a subtle, but important difference. However, for now, don't worry about it. The CI interval is roughly where we expect the parameter. 

### Bayesian estimates

Just for completeness - there are some advanced methods that report a different thing than p-values and the parameter estimates discussed before. Bayesian methods calculate a quantity that is called the posterior parameter estimate. It is similar, but not identical to the parameter estimates discussed previously. You won't need this here, but if you want to know more about those, have a look at \citep{Gelman-BayesianDataAnalysis-2003}.
