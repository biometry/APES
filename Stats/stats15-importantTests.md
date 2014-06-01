Important statistical tests
===

Recall statistical tests, or more formally, null-hypothesis significance testing (NHST) is one of severa ways in which you can approach data. The idea is that you define a null-hypothesis, and then you look a the probability that the data would occur under the assumption that the null hypothesis is true.

Now, there can be many null hypothesis, so you need many tests. The most widely used tests are given here.



# *t*-test
The *t*-test can be used to test whether one sample is different from a reference value (e.g. 0: one-sample *t*-test), whether two samples are different (two-sample *t*-test) or whether two paired samples are different (paired *t*-test).

The *t*-test assumes that the data are normally distributed. It can handle samples with same or different variances, but needs to be "told" so. 

```
t.test(Y1, Y2, var.equal=FALSE, paired=FALSE) 
# two-sample t-test with unequal variances; actually the default settings in R
```
If data are **not** normally distributed, we sometimes succeed making data normal by using transformations, such as square-root, log, or alike (see section on transformations).

While *t*-tests on transformed data now actually test for differences between these transformed data, that is typically fine. Think of the pH-value, which is only a log-transform of the proton concentration. Do we care whether two treatments are different in pH or in proton concentrations? If so, then we need to choose the right data set. Most likely, we don't and only choose the log-transform because the data are actually lognormally distributed, not normally.

Most interesting is however the rank-transformation, which replaces the values by their rank (i.e. the lowest value receives a 1, the second lowest a 2 and so forth). A *t*-test of rank-transformed data is also called Mann-Whitney-U-test.

```
t.test(rank(Y) ~ group)
# to use the rank, we need to employ the "formula"-invokation of t.test!
```
