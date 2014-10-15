---
layout: page
title: Interaction
category: concepts
---

Interaction
===

An interaction between two variables means that the effect of one variable on the response is not independent of the value of another variable.

In regression models or ANOVA, we would typically write

y ~ a + b 

for a case without interaction between a and b (meaning that a and b affect the response independently from each other), and

y ~ a * b ; or y ~ a + b + I(a*b)

for the case where there is an interaction between the variables. Note that, in this case, including the interaction means that one additional parameter needs to be fitted. 

See also [http://en.wikipedia.org/wiki/Interaction_%28statistics%29](http://en.wikipedia.org/wiki/Interaction_%28statistics%29)

http://en.wikipedia.org/wiki/Interaction_%28statistics%29
