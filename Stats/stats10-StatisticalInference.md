---
layout: page
title: Inferential statistics
category: stats
---

Approaches to statstical inference
===

The idea of inferential statistics, or statistical inference, is to learn something, such as

* Does a variable have an effect
* Is there a difference between treatment and control

from the data. To do so, different methods can be used. We distinguish here to broad categories

* Parameteric vs. non-parametric approaches

* Method of inference: Hypothesis testing, Maximum Likelihood estimation, and Bayesian inference


## Parameteric vs. non-parametric approaches

### Parametric approaches use statistical models

The problem with giving a straight answer to the question of whether the response variable is affected by the predictors is that all our ecological data contains random variability. If we take two pots and plant a plant in each one of them, and we expose one plant to classical music and the other to heavy metal, probably one of them will grow taller. But are we sure that this is an effect of the music, or could it just be due to the fact that no plant is exactly the same, and therefore one of the two will typically grow a bit taller?

Thus, to arrive at robust conclusions, we have to make some assumptions about how the growth of plants varies, so that we can see if some differences that we are seeing could be the result of random variation only. These assumptions are what we call a statistical model. A statistical model could, for example, make the assumptions that there is a medium growth rate for each plant species, but that the growth of each individual plant varies with a certain distribution around this mean growth. Based on this, we can now ask ourselves whether the data that we have allows us to draw conclusions about the effect of a predictor. 

OK, we have some data and a statistical model. But there is still one step to go - how do we say if there is an effect or not? Basically, there are two classical ways of calculating a conclusion from a statistical model and some data: p-values and parameter estimates. There is a third option which I will mention very shortly at the end.  Btw., the process of drawing conclusions from data is called inference, when we use statistical models, we call it statistical inference. 


## Method of inference


## Hypothesis testing

The idea of null hypothesis significance testing (NHST) is the following: if we have some data observed, and we have a statistical model, we can use this statistical model to specify a fixed hypothesis about how the data did arise. Based on this hypothesis, we can decide if the observing this data would be likely. If not, we reject the hypothesis. Details are explained in the section on hypothesis testing. 

## Maximum likelihood estimation

The second type of output that is reported by most statistical methods are parameter estimates. Without going into too much detail: while the p-value is the probability of the data or more extreme data under a fixed (null) hypothesis, a parameter estimate (often also called point estimate or maximum likelihood estimate) refers to those of many possible hypothesis that are spanned by a parameter that has the highest probability to produce the observed data. 

In plain words, the parameter estimate is our best estimate for a difference between groups, or the influence between parameters. Again, in contrast, the p-value typically tells us the probability that we would see the data if there is no such influence. 

Parameter estimates are typically accompanies by confidence intervals. Sloppily you can think of the 95\% confidence interval of a parameter as the probable range for this area. Somewhat confusing for many, it's not the interval in which the true parameter lies with 95\% probability. Rather, in a repeated experiments, the standard 95\% CI will contain the true value in 95\% of all cases. It's a subtle, but important difference. However, for now, don't worry about it. The CI interval is roughly where we expect the parameter. 

## Bayesian estimates

A third procedure of inference is Bayesian inference. It is typically used for more advanced models. Further info see Hub on Bayesian inference. 

