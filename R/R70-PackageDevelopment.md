---
layout: page
title: Package development
category: r
---

Package development is a lot easier than you think. Follow the steps below, and you should have no problem. 

## Basics

### Compiling a package

Assuming you have the package in a local folder, and work with RStudio (both recommended)

1. Create a new RStudio project in the folder
2. Choose the project folder in Tools/Project Options/Build tools. Make sure you also check Roxygen if you want to use Roxygen (see below, recommended)
3. Buttons for building the package should now appear in the top right panel of RStudio

For further help or for info how to compile from the console (takes more time) use google. 

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

## Advanced topics and further reading 

* [Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf)
* [A Quickstart Guide for Building Your First R Package](https://methodsblog.wordpress.com/2015/11/30/building-your-first-r-package/)

Before you go on with package developments, read [this](http://r-pkgs.had.co.nz/) which explains all essentials in more detail!

Special topics

* [Imports vs Depends](http://stackoverflow.com/questions/8637993/better-explanation-of-when-to-use-imports-depends)
* Compiled code in the package see [here](http://r-pkgs.had.co.nz/src.html)
* RCPP (integration or R and C++) see [here](http://dirk.eddelbuettel.com/code/rcpp.html)
* Boost see [here](http://dirk.eddelbuettel.com/code/bh.html)
* Testing see [here](http://r-pkgs.had.co.nz/tests.html#test-workflow)

## Submitting to CRAN tips / checklist 

Especially if you do this for the first time, read

* The official [CRAN Policy](https://cran.r-project.org/web/packages/policies.html)
* Hadley's release [recommendations](http://r-pkgs.had.co.nz/release.html)
* Google for experience with CRAN submission to see what people struggle with - CRAN is super strict about spelling, capitalization, use of " and ' and so on - if the checks give you a warning, fix it

Checklist for submission 

1. Update your R system (ideally)
2. Run unit tests and CRAN checks in Rstudio, fix all the issues
3. Advance version numbers, readme, vignette, date, etc. 
4. Run again local tests now including 
  * Unit and Check in RStudion
  * Reverse dependencies
  * [winbuilder](https://win-builder.r-project.org/) on stable and dev
  * Ubuntu (via Travis-CI)
5. Push new version to GH
6. Submit to CRAN
