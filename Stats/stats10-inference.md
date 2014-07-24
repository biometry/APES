Inferential approaches
===


# *t*-test
The *t*-test can be used to test whether one sample is different from a reference value (e.g. 0: one-sample *t*-test), whether two samples are different (two-sample *t*-test) or whether two paired samples are different (paired *t*-test).

The *t*-test assumes that the data are normally distributed. It can handle samples with same or different variances, but needs to be "told" so. 

```
# invent some data, reproducibly:
set.seed(1)
Y1 <- rnorm(20)
Y2 <- rlnorm(20)
# now carry out a t-test:
t.test(Y1, Y2, var.equal=FALSE, paired=FALSE)
# two-sample t-test with unequal variances; actually the default settings in R
```
The *t*-test should be preceeded by a graphical depiction of the data in order to check for normality within groups and for evidence of heteroscedasticity (= differences in variance), like so:

```
# reshape the data:
Y <- c(Y1, Y2)
groups <- as.factor(c(rep("Y1", length(Y1)), rep("Y2", length(Y2))))
# now plot them as points (not box-n-whiskers):
plot.default(Y ~ groups)
```

![image](http://t-test-plot)

The points to the right scatter similar to those on the left, although a bit more asymmetrically. Although we know that they are from a log-normal distribution (right), they don't look problematic.

If data are **not** normally distributed, we sometimes succeed making data normal by using transformations, such as square-root, log, or alike (see section on transformations).

While *t*-tests on transformed data now actually test for differences between these transformed data, that is typically fine. Think of the pH-value, which is only a log-transform of the proton concentration. Do we care whether two treatments are different in pH or in proton concentrations? If so, then we need to choose the right data set. Most likely, we don't and only choose the log-transform because the data are actually lognormally distributed, not normally.

A non-parametric alternative is the Mann-Whitney-U-test, or, the ANOVA-equivalent, the Kruskal-Wallis test. Both are available in R, but instead we recommend the following:

Use rank-transformations, which replaces the values by their rank (i.e. the lowest value receives a 1, the second lowest a 2 and so forth). A *t*-test of rank-transformed data is not the same as the Mann-Whitney-U-test, but it is more sensitive and hence preferable (Ruxton 2006) or at least equivalent (Zimmerman 2012).

```
t.test(rank(Y) ~ groups)
# to use the rank, we need to employ the "formula"-invokation of t.test!
```
In this case, results are the same, indicating that our hunch about acceptable skew and scatter was correct.

(Note that the original *t*-test is a test for differences between means, while the rank-*t*-test becomes a test for general differences in values between the two groups, not specifically of the mean.)

####References
Ruxton, G. D. (2006). The unequal variance t-test is an underused alternative to Student’s t-test and the Mann-Whitney U test. Behavioral Ecology, 17, 688–690.

Zimmerman, D. W. (2012). A note on consistency of non-parametric rank tests and related rank transformations. British Journal of Mathematical and Statistical Psychology, 65, 122–44.
