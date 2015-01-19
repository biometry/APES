---
layout: page
title: basic tests
category: stats
subcategory: Hypothesis testing
---

Important statistical tests
===

Recall statistical tests, or more formally, null-hypothesis significance testing (NHST) is one of several ways in which you can approach data. The idea is that you define a null-hypothesis, and then you look a the probability that the data would occur under the assumption that the null hypothesis is true.

Now, there can be many null hypothesis, so you need many tests. The most widely used tests are given here.


# *t*-test
The *t*-test can be used to test whether one sample is different from a reference value (e.g. 0: one-sample *t*-test), whether two samples are different (two-sample *t*-test) or whether two paired samples are different (paired *t*-test).

The *t*-test assumes that the data are normally distributed. It can handle samples with same or different variances, but needs to be "told" so. 


## t-test for 1 sample (PARAMETRIC TEST)

The one-sample t-test compares the MEAN score of a sample to a known value, usually the population MEAN (the average for the outcome of some population of interest). 


```r
data = read.table("Z:/GitHub/RMarkdowns - Stat with R/4_Classical Tests/das.txt",header=T)
attach(data)
boxplot(y)
```

![plot of chunk unnamed-chunk-1](./stats12-ttest_files/figure-html/unnamed-chunk-1.png) 

Our null hypothesis is that the mean of the sample is not less than 2.5 (real example: weight data of 200 lizards collected for a research, we want to compare it with the known average weights available in the scientific literature)


```r
t.test(y,mu=2.5,alt="less",conf=0.95)  # mean = 2.5, alternative hypothesis one-sided; we get a one-sided 95% CI for the mean 
```

```
## 
## 	One Sample t-test
## 
## data:  y
## t = -3.335, df = 99, p-value = 0.000601
## alternative hypothesis: true mean is less than 2.5
## 95 percent confidence interval:
##  -Inf 2.46
## sample estimates:
## mean of x 
##     2.419
```



```r
t.test(y,mu=2.5,alt="two.sided",conf=0.95) #2 sided-version
```

```
## 
## 	One Sample t-test
## 
## data:  y
## t = -3.335, df = 99, p-value = 0.001202
## alternative hypothesis: true mean is not equal to 2.5
## 95 percent confidence interval:
##  2.372 2.467
## sample estimates:
## mean of x 
##     2.419
```

```r
detach(data)
```


## t-test for 1 sample (NON-PARAMETRIC TEST)

One-sample Wilcoxon signed rank test is a non-parametric alternative method of one-sample t-test, which is used to test whether the location (MEDIAN) of the measurement is equal to a specified value


Create fake data log-normally distributed and verify data distribution

```r
x<-exp(rnorm(15))
plot(x)
```

![plot of chunk unnamed-chunk-4](./stats12-ttest_files/figure-html/unnamed-chunk-41.png) 

```r
boxplot(x)
```

![plot of chunk unnamed-chunk-4](./stats12-ttest_files/figure-html/unnamed-chunk-42.png) 

```r
qqnorm(x)
qqline(x,lty=2,col=2,lwd=3)
```

![plot of chunk unnamed-chunk-4](./stats12-ttest_files/figure-html/unnamed-chunk-43.png) 

```r
shapiro.test(x) # not normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  x
## W = 0.7499, p-value = 0.000896
```

```r
summary(x)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.217   0.600   0.886   1.390   1.800   5.480
```

Our null hypothesis is that the median of x is not different from 1


```r
wilcox.test(x, alternative="two.sided", mu=1) # high p value-> median of x is not different from 1
```

```
## 
## 	Wilcoxon signed rank test
## 
## data:  x
## V = 65, p-value = 0.804
## alternative hypothesis: true location is not equal to 1
```


## Two Independent Samples T-test (PARAMETRIC TEST)
```
Parametric method for examining the difference in MEANS between two independent populations. 
The *t*-test should be preceeded by a graphical depiction of the data in order to check for normality within groups and for evidence of heteroscedasticity (= differences in variance), like so:

Reshape the data:


```r
Y1 <- rnorm(20)
Y2 <- rlnorm(20)
Y <- c(Y1, Y2)
groups <- as.factor(c(rep("Y1", length(Y1)), rep("Y2", length(Y2))))
```

Now plot them as points (not box-n-whiskers):


```r
plot.default(Y ~ groups)
```

![plot of chunk unnamed-chunk-7](./stats12-ttest_files/figure-html/unnamed-chunk-7.png) 


The points to the right scatter similar to those on the left, although a bit more asymmetrically. Although we know that they are from a log-normal distribution (right), they don't look problematic.

If data are **not** normally distributed, we sometimes succeed making data normal by using transformations, such as square-root, log, or alike (see section on transformations).

While *t*-tests on transformed data now actually test for differences between these transformed data, that is typically fine. Think of the pH-value, which is only a log-transform of the proton concentration. Do we care whether two treatments are different in pH or in proton concentrations? If so, then we need to choose the right data set. Most likely, we don't and only choose the log-transform because the data are actually lognormally distributed, not normally.

A non-parametric alternative is the Mann-Whitney-U-test, or, the ANOVA-equivalent, the Kruskal-Wallis test. Both are available in R and explained later, but instead we recommend the following:

Use rank-transformations, which replaces the values by their rank (i.e. the lowest value receives a 1, the second lowest a 2 and so forth). A *t*-test of rank-transformed data is not the same as the Mann-Whitney-U-test, but it is more sensitive and hence preferable (Ruxton 2006) or at least equivalent (Zimmerman 2012).


```r
t.test(rank(Y) ~ groups)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  rank(Y) by groups
## t = -4.107, df = 32.74, p-value = 0.0002511
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -19.143  -6.457
## sample estimates:
## mean in group Y1 mean in group Y2 
##             14.1             26.9
```
To use the rank, we need to employ the "formula"-invokation of t.test!
In this case, results are the same, indicating that our hunch about acceptable skew and scatter was correct.

(Note that the original *t*-test is a test for differences between means, while the rank-*t*-test becomes a test for general differences in values between the two groups, not specifically of the mean.)


Cars example:

```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
mtcars$fam=factor(mtcars$am, levels=c(0,1), labels=c("automatic","manual")) #transform "am" into a factor (fam) [Transmission (0 = automatic, 1 = manual)]

attach(mtcars)
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##                         fam
## Mazda RX4            manual
## Mazda RX4 Wag        manual
## Datsun 710           manual
## Hornet 4 Drive    automatic
## Hornet Sportabout automatic
## Valiant           automatic
```

```r
summary(mtcars$fam)
```

```
## automatic    manual 
##        19        13
```

Test the difference in car consumption depending on the transmission type. 
Check wherever the 2 'independent populations' are normally distributed


```r
par(mfrow=c(1,2))
qqnorm(mpg[fam=="manual"]);qqline(mpg[fam=="manual"])
qqnorm(mpg[fam=="automatic"]); qqline(mpg[fam=="automatic"])
```

![plot of chunk unnamed-chunk-10](./stats12-ttest_files/figure-html/unnamed-chunk-10.png) 

```r
shapiro.test(mpg[fam=="manual"])  #normal distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  mpg[fam == "manual"]
## W = 0.9458, p-value = 0.5363
```

```r
shapiro.test(mpg[fam=="automatic"])   #normal distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  mpg[fam == "automatic"]
## W = 0.9768, p-value = 0.8987
```

```r
par(mfrow=c(1,1))
```

Graphic representation

```r
boxplot(mpg~fam, ylab="Miles/gallon",xlab="Transmission",las=1)
```

![plot of chunk unnamed-chunk-11](./stats12-ttest_files/figure-html/unnamed-chunk-11.png) 

We have two ~normally distributed populations.
In order to test for differences in means, we applied a t-test for independent samples. 

Any time we work with the t-test, we have to verify whether the variance is equal betwenn the 2 populations or not, then we fit the t-test accordingly.  
Our Ho or null hypothesis is that the consumption is the same irrespective to transmission. We assume non-equal variances


```r
t.test(mpg~fam,mu=0, alt="two.sided",conf=0.95,var.eq=F,paired=F)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  mpg by fam
## t = -3.767, df = 18.33, p-value = 0.001374
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -11.28  -3.21
## sample estimates:
## mean in group automatic    mean in group manual 
##                   17.15                   24.39
```
From the output: please note that CIs are the confidence intervales for differences in means

Same results if you run the following (meaning that the other commands were all by default)

```r
t.test(mpg~fam) 
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  mpg by fam
## t = -3.767, df = 18.33, p-value = 0.001374
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -11.28  -3.21
## sample estimates:
## mean in group automatic    mean in group manual 
##                   17.15                   24.39
```
The alternative could be one-sided (greater, lesser) as we discussed earlier for one-sample t-tests

If we assume equal variance, we run the following 


```r
t.test(mpg~fam,var.eq=TRUE,paired=F)
```

```
## 
## 	Two Sample t-test
## 
## data:  mpg by fam
## t = -4.106, df = 30, p-value = 0.000285
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -10.848  -3.642
## sample estimates:
## mean in group automatic    mean in group manual 
##                   17.15                   24.39
```

Ways to check for equal / not equal variance

1) To examine the boxplot visually


```r
boxplot(mpg~fam, ylab="Miles/gallon",xlab="Transmission",las=1)
```

![plot of chunk unnamed-chunk-15](./stats12-ttest_files/figure-html/unnamed-chunk-15.png) 

2) To compute the actual variance

```r
var(mpg[fam=="manual"])
```

```
## [1] 38.03
```

```r
var(mpg[fam=="automatic"])
```

```
## [1] 14.7
```
There is 2/3 times difference in variance.

3) Levene's test

```r
library(car)
```

```
## Warning: package 'car' was built under R version 3.0.3
```

```r
leveneTest(mpg~fam) # Ho is that the population variances are equal
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##       Df F value Pr(>F)  
## group  1    4.19   0.05 *
##       30                 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# Ho rejected, non-equal variances
```

## Mann-Whitney U test/Wilcoxon rank-sum test for two independent samples  (NON-PARAMETRIC TEST) 

We change the response variable to hp (Gross horsepower)


```r
qqnorm(hp[fam=="manual"]);qqline(hp[fam=="manual"])
```

![plot of chunk unnamed-chunk-18](./stats12-ttest_files/figure-html/unnamed-chunk-181.png) 

```r
qqnorm(hp[fam=="automatic"]);qqline(hp[fam=="automatic"])
```

![plot of chunk unnamed-chunk-18](./stats12-ttest_files/figure-html/unnamed-chunk-182.png) 

```r
shapiro.test(hp[fam=="manual"])  #not normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  hp[fam == "manual"]
## W = 0.7676, p-value = 0.00288
```

```r
shapiro.test(hp[fam=="automatic"])  #normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  hp[fam == "automatic"]
## W = 0.9583, p-value = 0.5403
```

The 'population' of cars with manual transmission has a hp not normally distributed, so we have to use a test for independent samples - non-parametric

We want to test a difference in hp depending on the transmission
Using a non-parametric test, we test for differences in MEDIANS between 2 independent populations


```r
boxplot(hp~fam)
```

![plot of chunk unnamed-chunk-19](./stats12-ttest_files/figure-html/unnamed-chunk-19.png) 

Our null hypothesis will be that the medians are equal (two-sided)


```r
wilcox.test(hp~fam,mu=0,alt="two.sided",conf.int=T,conf.level=0.95,paired=F,exact=F) ## non parametric conf.int are reported
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  hp by fam
## W = 176, p-value = 0.0457
## alternative hypothesis: true location shift is not equal to 0
## 95 percent confidence interval:
##  8.624e-05 9.200e+01
## sample estimates:
## difference in location 
##                     55
```


```r
detach(mtcars)
```

## Wilcoxon signed rank test for two dependend samples (NON PARAMETRIC)
This is a non-parametric method appropriate for examining the median difference in 2 populations observations that are paired or dependent one of the other.

This is a dataset about some water measurements taken at different levels of a river: 'up' and 'down' are water quality measurements of the same river taken before and after a water treatment filter, respectively 


```r
streams = read.table("Z:/GitHub/RMarkdowns - Stat with R/4_Classical Tests/streams.txt",header=T)
head(streams)
```

```
##   down up
## 1   20 23
## 2   15 16
## 3    6 10
## 4    5  4
## 5   20 22
## 6   15 15
```



```r
attach(streams)
summary(streams)
```

```
##       down             up       
##  Min.   : 5.00   Min.   : 4.00  
##  1st Qu.: 5.75   1st Qu.: 9.25  
##  Median :12.50   Median :13.00  
##  Mean   :12.00   Mean   :13.38  
##  3rd Qu.:15.75   3rd Qu.:17.25  
##  Max.   :20.00   Max.   :23.00
```

```r
plot(up,down)
abline(a=0,b=1) #add a line with intercept 0 and slope 1
```

![plot of chunk unnamed-chunk-23](./stats12-ttest_files/figure-html/unnamed-chunk-23.png) 
The line you see in the plot corresponds to x=y, that is, the same water measuremets before and after the water treatment (it seems to be true in 2 rivers only, 5 and 15)

Our null hypothesis is that the median before and after the treatment are not different


```r
shapiro.test(down) #not normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  down
## W = 0.866, p-value = 0.02367
```

```r
shapiro.test(up) #normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  up
## W = 0.9361, p-value = 0.3038
```

```r
#the assumption of normality is certainly not met for the measurements after the treatment

summary(up)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    4.00    9.25   13.00   13.40   17.20   23.00
```

```r
summary(down)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    5.00    5.75   12.50   12.00   15.80   20.00
```

```r
wilcox.test(up,down,mu=0,paired=T,conf.int=T,exact=F) #paired =T, low p ->reject Ho, medians are different
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  up and down
## V = 97, p-value = 0.004971
## alternative hypothesis: true location shift is not equal to 0
## 95 percent confidence interval:
##  1.0 2.5
## sample estimates:
## (pseudo)median 
##            1.5
```

```r
detach(streams)
```


## Paired T-test for two dependend samples test. (PARAMETRIC)
This parametric method examinates the difference in means for two populations that are paired or dependent one of the other


```r
fish = read.table("Z:/GitHub/RMarkdowns - Stat with R/4_Classical Tests/fishing.txt",header=T)
```

This is a dataset about the density of a fish prey species (fish/km2) in 121 lakes before and after removing a non-native predator


```r
attach(fish)
head(fish)
```

```
##   lakes before  after
## 1     1 19.509 20.509
## 2     2  5.297  7.297
## 3     3 26.496 27.496
## 4     4  3.928  5.928
## 5     5 12.956 15.956
## 6     6  9.776 15.776
```

```r
boxplot(before,after,ylab="Fish Density",
        names=c("before", "after"))
```

![plot of chunk unnamed-chunk-26](./stats12-ttest_files/figure-html/unnamed-chunk-261.png) 

```r
shapiro.test(before) #normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  before
## W = 0.9958, p-value = 0.9777
```

```r
shapiro.test(after)  #normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  after
## W = 0.9946, p-value = 0.9258
```

```r
plot(before,after)
abline(a=0,b=1) 
```

![plot of chunk unnamed-chunk-26](./stats12-ttest_files/figure-html/unnamed-chunk-262.png) 



```r
t.test(before,after,mu=0,paired=T)
```

```
## 
## 	Paired t-test
## 
## data:  before and after
## t = -12.06, df = 120, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.514 -1.805
## sample estimates:
## mean of the differences 
##                   -2.16
```

```r
t.test(after,before,mu=0,paired=T) #changing the order of variables, we have a change in the sign of the t-test estimated mean of differences
```

```
## 
## 	Paired t-test
## 
## data:  after and before
## t = 12.06, df = 120, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  1.805 2.514
## sample estimates:
## mean of the differences 
##                    2.16
```

```r
#low p ->reject Ho, means are equal 

detach(fish)
```


####References
Ruxton, G. D. (2006). The unequal variance t-test is an underused alternative to Studentâs t-test and the Mann-Whitney U test. Behavioral Ecology, 17, 688â690.

Zimmerman, D. W. (2012). A note on consistency of non-parametric rank tests and related rank transformations. British Journal of Mathematical and Statistical Psychology, 65, 122â44.
