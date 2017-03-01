---
layout: page
title: Nonparametric methods
category: stats
subcategory: Advanced topics
maintainer: Florian Hartig
---


# Resampling



# Bootstrap


## Literature

Efron, B. & Tibshirani, R. J. (1993). An introduction to the bootstrap. London: Chapman & Hall/CRC.

Davison, A. C. & Hinkley, D. V. (2009). Bootstrap methods and their application. New York, NY: Cambridge University Press.



# Crossvalidation

Cross-validation (CV) is a common and general technique to assess the predictive performance of a model. The idea of a k-fold cross-validation is to split the data into k parts, fit the model to all possible k subsets with size k-1, and predict on the remaining part.

The remaining predictions are then compared to data, either via a general measure of disrepancy such as RMSE, or via the likelihood of the model.

CV will penalize too complex models because they don't predict well on validation data, and can therefore be used for model selection, even in cases where AIC doesn't work or is not available. For restrictive conditions, CV is approximately equal to AIC (Stone, 1977). 

Cross-validation is covered in more detail on [this page](https://biometry.github.io/APES/LectureNotes/2017-Resampling/CrossValidationLecture.html) of APES. 

### References 

Roberts DR, Bahn V, Ciuti S, et al. (2017) Cross-validation strategies for data with temporal, spatial, hierarchical, or phylogenetic structure. Ecography, in press.

Stone, M. (1977) An Asymptotic Equivalence of Choice of Model by Cross-Validation and Akaike's Criterion. Journal of the Royal Statistical Society. Series B, 39, 44-47.


### CV in R

* [http://cran.r-project.org/web/packages/cvTools/index.html](http://cran.r-project.org/web/packages/cvTools/index.html)
* [http://topepo.github.io/caret/index.html](http://topepo.github.io/caret/index.html)


### Further links

* [http://www.petrkeil.com/?p=836](http://www.petrkeil.com/?p=836)
* [http://robjhyndman.com/hyndsight/crossvalidation/](http://robjhyndman.com/hyndsight/crossvalidation/)



## Block - CV

suggested by Jane Elith


Slavich, E., Warton, D. I., Ashcroft, M. B.,Gollan, J. R. & Ramp, D. (2014). Topoclimate versus macroclimate: how does climate mapping methodology affect species distribution models and climate change projections? Diversity and Distributions.

Burman, P., Chow, E. & Nolan, D. (1994). A cross-validatory method for dependent data.Biometrika, 81, 351?358.

Wenger, S. J. & Olden, J. D. (2012).Assessing transferability of ecological models: an underappreciated aspect of statistical validation. Methods in Ecology and Evolution, 3, 260-267.

Warton, D. I., Renner, I. W. & Ramp, D.(2013). Model-based control of observer bias for the analysis of presence-only data in ecology. PLoS one, 8, e79168.


Pearson, R. G., Phillips, S. J., Loranty, M. M.,Beck, P. S., Damoulas, T., Knight, S. J. & Goetz, S. J. (2013). Shifts in Arctic vegetation and associated feedbacks under climate change. Nature Climate Change, 3, 673-677.

Fithian, W.,Elith, J., Hastie, T. & Keith, D. (2014 early view) Bias Correction in Species Distribution Models: Pooling Survey and Collection Data for Multiple Species. Methods in Ecology and Evolution

Hutchinson,R.A., Liu, L.-P. & Dietterich, T.G. (2011) Incorporating Boosted Regression Trees into Ecological Latent Variable Models. Proceedings of the Twenty-fifth Conference on Artificial Intelligence (ed by, pp. 1343-1348.  San Francisco.
