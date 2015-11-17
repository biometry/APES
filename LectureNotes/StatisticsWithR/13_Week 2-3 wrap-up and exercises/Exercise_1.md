# Exercise 1

Set your working directory here:

```r
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/13_Week 2-3 wrap-up and exercises")
```


This chunck loads the data for you (including some pre-required data handling):

```r
birds <- read.delim("birds.txt")
birds$fGRAZE = as.factor(birds$GRAZE)
birds$L.AREA = log10(birds$AREA)
birds$L.DIST = log10(birds$DIST)
birds$L.LDIST = log10(birds$LDIST)
head(birds)
```

```
##   Site ABUND AREA DIST LDIST YR.ISOL GRAZE ALT fGRAZE   L.AREA   L.DIST
## 1    1   5.3  0.1   39    39    1968     2 160      2 -1.00000 1.591065
## 2    2   2.0  0.5  234   234    1920     5  60      5 -0.30103 2.369216
## 3    3   1.5  0.5  104   311    1900     5 140      5 -0.30103 2.017033
## 4    4  17.1  1.0   66    66    1966     3 160      3  0.00000 1.819544
## 5    5  13.8  1.0  246   246    1918     5 140      5  0.00000 2.390935
## 6    6  14.1  1.0  234   285    1965     3 130      3  0.00000 2.369216
##    L.LDIST
## 1 1.591065
## 2 2.369216
## 3 2.492760
## 4 1.819544
## 5 2.390935
## 6 2.454845
```

Dataset details:
ABUND =  RESPONSE [bird density measured in 56 forest patches in Victoria, Australia].
AREA =  size FOREST patch.
DIST = dist closest patch. 
LDIST =  distance to the nearest larger patch.
YR.ISOL = year isolation by clearance. 
GRAZE =  index of livestock grazing (1 light, 5 intensive).
ALT =  altitude of the patch.

In the previous chunk, we actually converted GRAZE into a factor, and log10 transformed AREA, DIST, and LDIST to reduce the influence of outliers (you can plot the distributions of these data and will see how they look after data transformation). SO, forget about AREA, DIST, and LDIST.. you are supposed to use L.AREA L.DIST and L.LDIST instead. The full list of predictors we expect to affect ABUND is: YR.ISOL, ALT, fGRAZE, L.AREA, L.DIST, L.LDIST.


Now, your tasks.

(1) check/test for collinearity issues.


(2) define the model structure including all quadratic effects but not interactions (we do not have specific expectations here. Also, the dataset is 56 rows and we should be cautious in using interactions here).



(3) perform model selection using MuMIn package. What's the structure of the top-ranked model suggested by MuMIn?



(4) perform model selection using step AIC. Does the model structure differ from (3)?



(5) referring to the best model selected by MuMIn. Does it meet model assumptions? Y/N? Why?



