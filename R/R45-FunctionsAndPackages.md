---
layout: page
title: Functions and packages
category: r
---


## Built-in functions

R has a quite extensive set of base functions that come with each R distrution. It is possible to get a complete list by typing <i>builtins()</i> in the R console. Some examples of R functions [here](http://www.sr.bham.ac.uk/~ajrs/R/r-function_list.html) and [here](http://www.statmethods.net/management/functions.html).

* [Quick-list-of-useful-R-packages](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)

## Getting help on functions

RStudio has a help tab in the right part of the window. You can search there, or type ?functionName in the console. The easiest, however, is to put the cursor on a function name and press F1. 

Some extended help functions in the console:

```{r}
help.start()      #opens the help summary
help(var)         #we get info about the variance function
?var
apropos("var")    #a list with the functions that contain the letters "var"
help.search(var)
??var             #it extends the search 
```


## R packages

To extend the base functionalities, you have can load R packages. A large list of packages is available. Many of them are hosted on the central package repository CRAN. Here is a [list of all contributed CRAN packages](https://cran.r-project.org/web/packages/). A list of recommendations of useful packages is available [here](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)

To load a package, type 

```{r}
library("packageName")
```

If the package is not available, you will get an error. In this case, you need to install the package first (see below)

## Installing R packages

The basic way to install a packages from CRAN is to type 

```{r}
install.packages("packageName")
```

You can modify the source of the packages to be installed (repos other than CRAN, or from a file), as well as the location where the package should be installed to (default is in the directory of R, but you may not have write permissions there). 

For example, when on a linux machine without root acces and you can specify a local directory such as

```{r}
install.packages("spatstat", lib="/data/Rpackages/")
library(spatstat, lib.loc="/data/Rpackages/")
```

A longer-term solution in this case though is to modify the .Renviron file with the line R_LIBS=/data/Rpackages/, in which case we can drop the lib commands and do everything as before.

Alternatively, in RStudio, one can install packages in <i>Tools-> Install Packages</i>. We can then select if we want to install it from the repository or from an archive file and whereis the library where it will be installed. Once installed, we can activate clicking on its correspondent box in the bottom right window from RStudio.




