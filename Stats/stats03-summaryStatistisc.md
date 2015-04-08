---
layout: page
title: Summary statistics
category: stats
subcategory: Basic concepts
---

Summary statistics and correlations
===

# Testing for normality


```r
library(knitr)
```

```
## Warning: package 'knitr' was built under R version 3.0.3
```

```r
opts_knit$set(global.par=TRUE) 
opts_chunk$set(cache.extra = rand_seed,fig.align='center')
set.seed(3)
```

The normal distribution is the most important and most widely used distribution in statistics.

We can say that a distribution is normally distributed when:

1) is symmetric around their mean.

2) the mean, median, and mode of a normal distribution are equal.

3) the area under the normal curve is equal to 1.0.

4) distributions are denser in the center and less dense in the tails.

5) distributions are defined by two parameters, the mean and the standard deviation (sd).

6) 68% of the area of a normal distribution is within one standard deviation of the mean.

7) Approximately 95% of the area of a normal distribution is within two standard deviations of the mean.

Normal distribution 

Simulation of the weight of 1570 adult males normally distributed

```r
data1=rnorm(1570,mean=75,sd=8)
hist(data1,main="Adult male weights",xlab="adult male weight",col="red",las=1)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

Load example data

```r
data = read.table("Z:/GitHub/RMarkdowns - Stat with R/4_Classical Tests/das.txt",header=T)
summary(data)
```

```
##        y       
##  Min.   :1.90  
##  1st Qu.:2.24  
##  Median :2.41  
##  Mean   :2.42  
##  3rd Qu.:2.57  
##  Max.   :2.98
```

Visualize example data

```r
attach(data) #command search() helps to verify what is/is not attached)
par(mfrow=c(2,2)) #to divide the plot window
plot(y)
boxplot(y)
hist(y,breaks=20)
y2=y
y2[52]=21.75 # to change the 52nd value for 21.75 instead of 2.175:
plot(y2)     #very good to spot mistakes, outliers
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

```r
par(mfrow=c(1,1)) #back to one plot window
```

## Visual Check for Normality: quantile-quantile plot

This one plots the ranked samples from our distribution against a similar number of ranked quantiles taken from a normal distribution.
If our sample is normally distributed then the line will be straight. 
Exceptions from normality show up different sorts of non-linearity (e.g. S-shapes or banana shapes). 


```r
qqnorm(y)
qqline(y,lty=2,col=2,lwd=3)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-5.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

## Normality test: the shapiro.test


```r
shapiro.test(y)  # p-value=0.753, these data are normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  y
## W = 0.9911, p-value = 0.753
```

```r
detach(data)
```


As an example we will create a fake data log-normally distributed and verify the assumption of normality

```r
x=exp(rnorm(30))  #rnorm without specification (normal distributed or not) picks data from the standard normal, mean = 0, sd = 1
plot(x)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-71.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

```r
boxplot(x)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-72.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

```r
hist(x,breaks=50)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-73.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

```r
qqnorm(x)
qqline(x,lty=2,col=2,lwd=3)
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-74.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

```r
shapiro.test(x)  #p-value=8.661e-07, not normally distributed
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  x
## W = 0.8572, p-value = 0.0008806
```


# Correlations tests

Correlation tests measure the relationship between variables. This relationship can goes from +1 to -1, where 0 means no relation. Some of the tests that we can use to estimate this relationship are the following:

-Pearson's correlation is a parametric measure of the linear association between 2 numeric variables (PARAMETRIC TEST)

-Spearman's rank correlation is a non-parametric measure of the monotonic association between 2 numeric variables (NON-PARAMETRIC TEST)

-Kendall's rank correlation is another non-parametric measure of the associtaion, based on concordance or discordance of x-y pairs (NON-PARAMETRIC TEST)


```r
attach(mtcars)  
plot(hp,wt, main="scatterplot",las=1, xlab ="gross horse power", ylab="Weight (lb/1000)")
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-8.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Compute the three correlation coefficients

```r
cor(hp,wt,method="pearson")
```

```
## [1] 0.6587
```

```r
cor(hp,wt)#Pearson is the default method; the order of variables is not important
```

```
## [1] 0.6587
```

```r
cor(hp,wt,method="spearman")
```

```
## [1] 0.7747
```

```r
cor(hp,wt,method="kendal")
```

```
## [1] 0.6113
```

Test the null hypothesis, that means that the correlation is 0 (there is no correlation)

```r
cor.test(hp,wt,method="pearson") #Pearson correlation test
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  hp and wt
## t = 4.796, df = 30, p-value = 4.146e-05
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.4025 0.8193
## sample estimates:
##    cor 
## 0.6587
```

```r
cor.test(hp,wt,method="spearman") #Spearmn is a non-parametric, thus it is not possible to get CIs. There is a error message because R cannot compute exact p values (the test is based on ranks, we have few cars with the same hp or wt).We can get rid off the warning letting R know that approximate values are fine
```

```
## Warning: Cannot compute exact p-value with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  hp and wt
## S = 1229, p-value = 1.954e-07
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##    rho 
## 0.7747
```

```r
cor.test(hp,wt,method="spearman",exact=F) 
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  hp and wt
## S = 1229, p-value = 1.954e-07
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##    rho 
## 0.7747
```

```r
cor.test(hp,wt,method="kendal",exact=F) #same happens with Kendal correlation test
```

```
## 
## 	Kendall's rank correlation tau
## 
## data:  hp and wt
## z = 4.845, p-value = 1.266e-06
## alternative hypothesis: true tau is not equal to 0
## sample estimates:
##    tau 
## 0.6113
```

When we have non-parametric data and we do not know which correlation method to choose, as a rule of thumb, if the correlation looks non-linear, Kendall tau should be better than Spearman Rho.


## Further handy functions for correlations

Plot all possible combinations with "pairs"

```r
pairs(mtcars)  # all possible pairwise plots
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-11.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

To make it simpler we select what we are interested

```r
names(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

```r
pairs(mtcars[,c(1,4,6)]) # subsetting the categories we will use
```

<img src="./stats03-summaryStatistisc_files/figure-html/unnamed-chunk-12.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

Building a correlation matrix

```r
cor(mtcars)
```

```
##          mpg     cyl    disp      hp     drat      wt    qsec      vs
## mpg   1.0000 -0.8522 -0.8476 -0.7762  0.68117 -0.8677  0.4187  0.6640
## cyl  -0.8522  1.0000  0.9020  0.8324 -0.69994  0.7825 -0.5912 -0.8108
## disp -0.8476  0.9020  1.0000  0.7909 -0.71021  0.8880 -0.4337 -0.7104
## hp   -0.7762  0.8324  0.7909  1.0000 -0.44876  0.6587 -0.7082 -0.7231
## drat  0.6812 -0.6999 -0.7102 -0.4488  1.00000 -0.7124  0.0912  0.4403
## wt   -0.8677  0.7825  0.8880  0.6587 -0.71244  1.0000 -0.1747 -0.5549
## qsec  0.4187 -0.5912 -0.4337 -0.7082  0.09120 -0.1747  1.0000  0.7445
## vs    0.6640 -0.8108 -0.7104 -0.7231  0.44028 -0.5549  0.7445  1.0000
## am    0.5998 -0.5226 -0.5912 -0.2432  0.71271 -0.6925 -0.2299  0.1683
## gear  0.4803 -0.4927 -0.5556 -0.1257  0.69961 -0.5833 -0.2127  0.2060
## carb -0.5509  0.5270  0.3950  0.7498 -0.09079  0.4276 -0.6562 -0.5696
##            am    gear     carb
## mpg   0.59983  0.4803 -0.55093
## cyl  -0.52261 -0.4927  0.52699
## disp -0.59123 -0.5556  0.39498
## hp   -0.24320 -0.1257  0.74981
## drat  0.71271  0.6996 -0.09079
## wt   -0.69250 -0.5833  0.42761
## qsec -0.22986 -0.2127 -0.65625
## vs    0.16835  0.2060 -0.56961
## am    1.00000  0.7941  0.05753
## gear  0.79406  1.0000  0.27407
## carb  0.05753  0.2741  1.00000
```

```r
cor(mtcars[,c(1,4,6)])
```

```
##         mpg      hp      wt
## mpg  1.0000 -0.7762 -0.8677
## hp  -0.7762  1.0000  0.6587
## wt  -0.8677  0.6587  1.0000
```

```r
detach(mtcars)
```

http://www.uni-kiel.de/psychologie/rexrepos/rerDescriptive.html
