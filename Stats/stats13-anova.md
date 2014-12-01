---
layout: page
title: ANOVA
category: stats
subcategory: Hypothesis Testing
---

Analysis of variance (ANOVA)
===

Anova or analysis of variance makes basically the same assumptions as a t-test (normally distributed responses), but allows for more than two groups. More precisely, the measured response (i.e. the dependent variable) can be influence by several categorical variables that could also interact. Here a simple example for testing whether weight depends on group, where group is a variable that codes for three different options control, treatment1 and treatment2:

\begin{lstlisting}
aovresult <- aov(weight~group)
summary(aovresult)

# Df Sum Sq Mean Sq F value Pr(>F)  
# group        2  3.766  1.8832   4.846 0.0159 *
#   Residuals   27 10.492  0.3886                 
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
\end{lstlisting}

We find a p-value of 0.0159, which is significant at an $\alpha$ level of 0.05. Note that in this case, we don't get any parameter estimates. If you want those, there are two options for the ANOVA:
\begin{itemize}
\item Either you apply what is called post-hoc testing, which means that you test for differences (e.g. with a t-test) between the subgroups, i.e. control vs. treatment1, treatment1 vs. treatment2, etc.
\item Or you switch to a regression, which is described in the next chapter
\end{itemize}
If you do post-hoc testing, you are doing multiple tests on the same data. This is a problem - the idea of the p-value is that you calculate the probability of seeing the data under ONE null hypothesis. If you do this, you will get at most 5\% error at an $\alpha$ level of 0.05. \marginnote{When doing multiple tests on the same data, we need to correct the p-values for multiple testing.} However, if we do multiple tests, we are testing multiple null hypotheses, and there are more options for the test statistics to get significant just by chance. Hence, we need to correct the p-values for multiple testing. There are a number of options to do so, google is your friend. 
