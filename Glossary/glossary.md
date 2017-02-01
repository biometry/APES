---
layout: page
title: Glossary
permalink: /Glossary/
# category: glossary
labels: main
---


### Credible Interval

A (Bayesian) crebile interval for a parameter is the range in which the true parameter lies with a probability of 95%


### Confidence interval

A (frequentist) confidence interval is a measure of uncertainty around a point estimate for a parameter. The definition of the CI is, as all frequentististic indicators, via error rates under repeated application of the method: a correctly calibrated 95% CI, under repeated sampling, will contain the true parameter in 95% of the cases. A frequent misunderstanding is that, for ONE given experiment, we are in general NOT 95% certain that the true parameter is cotained in teh CI. The interval with these properties is called the credible interval (see above). See discussion [here](http://stats.stackexchange.com/questions/6652/what-precisely-is-a-confidence-interval).


### Degrees of freedom

Degrees of freedom: for simple models, the number of parameters. 

For more complicated models such as mixed models, this concept becomes tricky. It is in general NOT directly the number of parameters. Why is that? Typically, one wants to use the degrees of freedom in statistical tests, e.g. the F-test in a regression. Hence, the degrees of freedom could be defined as the number that one should put in an F test to get appropriate type I error rates. Discussions all around, e.g. in <a href="http://stats.stackexchange.com/questions/16921/how-to-understand-degrees-of-freedom" target="_blank">here</a>.


### Interaction

An interaction between two variables means that the effect of one variable on the response is not independent of the value of another variable.

To specify regression models or ANOVA in R, we would typically write

y ~ a + b 

for a case without interaction between a and b (meaning that a and b affect the response independently from each other). If we want to add an interaction, the following are identical

y ~ a * b ; y ~ a + b + a:b ; y ~ a + b + I(a*b)

where the * notation is short for adding variables as main effects and interactions, the a:b notation is the interaction only, and the I(a*b) is the interaction written as a formula. Note that, in either case, including the interaction means that one additional parameter needs to be fitted. 

<a href="http://en.wikipedia.org/wiki/Interaction_%28statistics%29" target="_blank">See also</a>



### Null hypothesis / p-value / alpha-level / significance

Given a statistical model, a "normal" or "simple" null hypothesis specifies a single value for the parameter of interest as the "base expectation". A composite null hypothesis specifies a range of values for the parameter. 

Given a null hypothesis H<sub>0</sub> specified by a statistical model, the p-value is the probability to obtain the observed or more extreme data given H<sub>0</sub>. If p < alpha, we say we have significant evidence against H<sub>0</sub>. For details, see the [section on hypothesis testing](http://biometry.github.io/APES/Stats/stats12-basic_tests.html)
