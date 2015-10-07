---
layout: page
title: Functions and packages
category: r
---

There is a set of functions that are built into R and can be accssed by end-users.
It is possible to get a complete list with all built-in available functions by typing <i>builtins()</i> in the R console.

# Important built-in functions

Some of the more used R functions can be find [here](http://www.sr.bham.ac.uk/~ajrs/R/r-function_list.html) and [here](http://www.statmethods.net/management/functions.html)

## Getting help

If we are using R Studio, a help tab will appear in the botton right window.
We can also use commands to get help about any function:

```{r}
help.start()      #opens the help summary
help(var)         #we get info about the variance function
?var
apropos("var")    #a list with the functions that contain the letters "var"
help.search(var)
??var             #it extends the search 
```


# R packages

A large amount of R packages are available apart from the standard ones already integrated in R.
All these packages are storaged in the R <i>library</i> and have to be loaded to be able to use them.

A [list of all contributed packages](https://cran.r-project.org/web/packages/) can be found at the CRAN website.

## Installing R packages

If we have RStudio we can install packages in <i>Tools-> Install Packages</i>. We can then select if we want to install it from the repository or from an archive file and whereis the library where it will be installed.
Once installed, we can activate clicking on its correspondent box in the bottom right window from RStudio.

Other way to install packages is by typing:
```{r}
install.packages("spatstat")
```
However it does not work with Linuy without root acces and you will have to select the local mirror.
To install packages without a root acces we will need to set the directory where the packages will be save, i. e.:

```{r}
install.packages("spatstat", lib="/data/Rpackages/")
library(spatstat, lib.loc="/data/Rpackages/")
```

If we do not want to write everytime where the packages should be installed. We can create a .Renviron file with the line R_LIBS=/data/Rpackages/. That way we can install the packages as follows:

```{r}
install.packages("spatstat")
library(spatstat)
```

