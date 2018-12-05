---
layout: page
title: Spatial analysis
category: hubs
---

# Principle

This page tries to explain the theory, while each subsection links to R-code on how to actually do it.

Within statistics, the same methods are used with different intent in two more or less separate fields: spatial statistics and geostatistics. The former seems to focus more on classical statistical topics, such as inference from spatially autocorrelated data and unbiased parameter estimation. The latter tends towards geographic applications and uses "predictors" to improve spatial interpolation (e.g. in kriging). 

We are here more concerned with "spatial statistics", although (again) the methods are essentially identical, despite different focus.


# Spatial autocorrelation
Spatial autocorrelation describes the phenomenon that data points closer to each other are more similar than those further apart. Space, in this view, is essentially a matter of distance. 

Spatial statistics is concerned with spatial autocorrelation *in the residuals* of the regression. For inferential statistics this means that the assumption of independence of data points may be violated, invalidating "ordinary" likelihood-based approaches. That means, spatial autocorrelation *in the raw data* is not typically a concern, as it may be explained by a (spatially autocorrelated) predictor, yielding perfectly uncorrelated residuals. (Note that in geostatistics the *raw* data are typically of interest, not the relationship between some predictor and the response. That is the reason why in geostatistics the spatial autocorrelation in the *raw* data is used to improve on interpolations. It is important to get these two goals and strategies clearly differentiated!)

The causes for spatial autocorrelation may be many, but mostly they come as one of two:

  1. An important (spatially autocorrelated) predictor has not been made available in the regression analysis.
  2. Mass effects of the response "spill over" from one place to another, thereby tainting that place's actual state (think some insect producing vast numbers of offspring, which then disperse into the vicinity, even into sites unsuitable for survival).

For spatial statistics, we are thus seeking for methods that somehow take the non-independence of spatial data into account, thereby still allowing for valid inference despite spatially autocorrelated residuals. We return to these methods below, but first discuss simulating and diagnosing spatial autocorrelation.

## Simulating spatial autocorrelation
See [this page](https://biometry.github.io/APES/Stats/stats33-SimulatingSpatialAutocorrelation.html) for technical details.

## How to measure spatial autocorrelation
Two visualisations and one numeric method should be employed after the analysis of any spatial data set to explore the residuals for potential spatial non-independence:

  1. Correlogram or variogram (which depicts similarity as a function of distance);
  2. map of model residuals (which should not show any pattern but in case of SAC would have clusters or gradients); and
  3. (global) Moran's I (a measure of the amount of spatial autocorrelation, here in the model residuals).

Again, see [this page](https://biometry.github.io/APES/Stats/stats33-SimulatingSpatialAutocorrelation.html) for technical details.


## Remedies: spatial regression models

It seems that remedies fall essentially into three categories:

  1. Statistical approaches that use information on distances between points to [build a "correct" variance-covariance matrix](https://biometry.github.io/APES/Stats/stats33-vcovApproachesToSpatialAutocorrelation.html) for the evaluation of the model's likelihood; examples are autoregressive models, typically implemented as Generalised Least Squares.
  2. Statistical approaches that [create predictors](https://biometry.github.io/APES/Stats/stats33-createPredictorApproachesToSpatialAutocorrelation.html) in such a way that the residuals do not show any spatial pattern anymore; examples are spatial eigenvector mapping, wavelets and (shrunken) trend-surface regressions (models that use geographical coordinates as predictors: Gaussian Process, polynomials, space-splines).
  3. spatially [non-stationary models](https://biometry.github.io/APES/Stats/stats33-nonStationaryApproachesToSpatialAutocorrelation.html) (either spatially variable coefficient models or geographically weighted regression); finally,
  4. (why do you say three and then make a forth category) point-process-models. These are particularly aiming at point pattern analysis and will thus not receive much attention here. However, PPMs link statistically nicely with some of the above methods and can similarly be used for the analysis of "ordinary" spatial data (e.g. Fithian & Hastie 2013, Renner et al. 2015).




### References
Fithian, W., & Hastie, T. (2013). Statistical models for presence-only data: Finite-sample equivalence and addressing observer bias. The Annals of Applied Statistics, 7, 1917–1939.

Renner, I. W., Baddeley, A., Elith, J., Fithian, W., Hastie, T., Phillips, S., … Warton, D. I. (2015). Point process models for presence-only analysis – a review. Methods in Ecology and Evolution, 6, 366–379.
