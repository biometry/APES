---
layout: page
title: Interaction
category: concepts
maintainer: Florian Hartig
---

Interaction
===

An interaction between two variables means that the effect of one variable on the response is not independent of the value of another variable.

To specify regression models or ANOVA in R, we would typically write

y ~ a + b 

for a case without interaction between a and b (meaning that a and b affect the response independently from each other). If we want to add an interaction, the following are identical

y ~ a * b ; y ~ a + b + a:b ; y ~ a + b + I(a*b)

where the * notation is short for adding variables as main effects and interactions, the a:b notation is the interaction only, and the I(a*b) is the interaction written as a formula. Note that, in either case, including the interaction means that one additional parameter needs to be fitted. 

See also [http://en.wikipedia.org/wiki/Interaction_%28statistics%29](http://en.wikipedia.org/wiki/Interaction_%28statistics%29)

