---
layout: page
title: Getting started with R
category: r
---

**Synopsis:** R is the most widely used software for statistical calculations. This explains how to get started with using R.

# R Software

If you are starting wit R, you need to install

 * The R software (http://www.r-project.org/)
 * Optional, but recommended, an editor. 
  * For beginners, we strongly recommend RStudio (https://www.rstudio.com/)
  * An alternative, specially if you're familiar with eclipse, is the statET plugin for eclipse (http://www.walware.de/goto/statet)

Both is available for free on all major platforms.


# R Tutorials for beginners

The following links are tutorials on using R as a language. They are helpful if you understand which statistical tests or analyses you want to do, and you just want to learn how to do it in R. They do typically NOT replace a proper statistics book that explains to you in detail why we do a regression, and whhat the assumptions are. If this is what you want to know, go to our stats section.

## Recommended free tutorials

* [Introduction to R](http://www3.nd.edu/~mclark19/learn/Introduction_to_R.pdf), by Michael Clark. Recommendation as a basic text for beginners.  
* [R for Beginners](http://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf), by Emmanuel Paradis. A bit more comprehensive than the reference above. Also highly recommended. 

## Other shorter intros

* [A (very) short introduction to R](http://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf), by Paul Torfs & Claudia Brauer, very compact
* [An R reference card](http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf), by Matt Baggott
* [An introduction to R](http://cran.r-project.org/doc/contrib/Lam-IntroductionToR_LHL.pdf), by Longhow Lam. Longer and more comprehensive than the other tutorials linked here. 

## Websites with examples

* [Quick-R](http://www.statmethods.net/) (Highly recommend for beginners, have a look if your problem is here) 
* [R Examples Repository](http://www.uni-kiel.de/psychologie/rexrepos/index.html) If you don't find the test you need in Quick-R, have a look here
* [Cookbook for R](http://www.cookbook-r.com/) Similar to Quick-R
* [R by example](http://www.mayin.org/ajayshah/KB/R/) A lot of examples


## Introductions in German 

* Dormann, C. F. (2013) Parametrische Statistik. Springer, , 333-334. Free ebook for students from the University of Freiburg [here](http://link.springer.com.ezproxy.ub.uni-freiburg.de/book/10.1007/978-3-642-34786-3/page/1
) (works only within the university network). Buy a paper version [here](http://www.springer.com/springer+spektrum/statistik/statistik+f%C3%BCr+naturwissenschaft+medizin+%26+technik/book/978-3-642-34785-6)
* Dormann, C.F., I. Kühn. 2008. Statistische Analyse biologischer Daten (mit dem freien Programmpaket R). 2. Auflage. [here](https://www.biom.uni-freiburg.de/mitarbeiter/dormann/resolveuid/ed4f35206584421e7406414aa2d4470a)
* [Programmieren mit R](http://www.statistik.tu-dortmund.de/~ligges/PmitR/)

## Finding a function in R
* The easiest way is to use the question mark: ?FUN to find the function FUN. 
* If you don't know the name, you can use: ??TOPIC to find functions where TOPIC features somewhere in the help page.
* Using package "SOS" and the tripple-question mark does a websearch (on R-help search) and returns the results: ???TOPIC. In contrast to ? and ?? it searches everythink, not only the installed pacakges.
* You may want to install Rdym (and load it) to automatically get suggestions in case you mistype a function name (see [here](http://www.r-bloggers.com/a-did-you-mean-feature-for-r/) for an example). "Is that what you mean?" (Cool!)


# Getting started with Rstudio

File->New File->R Script to open a new R script

We can add comments with the symbol #, to difference them from the codes

Use of run (top right) to run your script in the R consol (shortcut: Ctrl + enter)

While using RStudio, the working space is divided into 4 windows:
1) At the top righ window it is stored the work in the workspace memory.
we can also check ir by using the "ls" command

```r
ls()
```

```
## [1] "metadata"
```
2) At the top left we can write our script and save it for future uses

3) Down left is the console  where you can type commands and see output

4) Down right is located the files tab, it shows all the files and folders in your default workspace. The plots tab will show all your graphs. The packages tab will list a series of packages or add-ons needed to run certain processes. For additional info see the help tab 

