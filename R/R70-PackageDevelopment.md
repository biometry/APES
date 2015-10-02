---
layout: page
title: Package development
category: r
---

Package development
===

Package development is a lot easier than you think. Follow the steps below, and you should have no problem. 

### Creating a new package

* Work with RStudio, makes many things easier (alternative is StatET in eclipse, particular if you also have C/C++ code in your package)
* Follow [this article](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) to create a new package
* Enable the package development in tools/project options, and you will see a new menu in Rstudio that allows you to build the package with one click

### Adding R code to the package

Simply move your R code to the R folder (if it doesn't exist, create an R folder directly under the package root)

### Documentation

Documentation files for each function are in the man folder. The name must be functionName.Rd.

We won't even bother explaining how to modify this file, because it doesn't make sense to write the documentation by hand. Use the Roxygen style for commenting your R functions, and the .Rd files in man will be created automatically.

* Read [here](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html) about how to work with Roxygen
* The easiest way to do this during package development is to enable tick the Roxygen options in RStudio, project options, and then you can create the man files in the build menu

### Advanced topics and further reading 

Before you go on with package developments, read [this](http://r-pkgs.had.co.nz/) which explains all essentials in more detail!

Special topics 

* Compiled code in the package see [here](http://r-pkgs.had.co.nz/src.html)
* RCPP (integration or R and C++) see [here](http://dirk.eddelbuettel.com/code/rcpp.html)
* Boost see [here](http://dirk.eddelbuettel.com/code/bh.html)
* Testing see [here](http://r-pkgs.had.co.nz/tests.html#test-workflow)
