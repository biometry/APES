---
layout: page
title: Programming with R
category: r
---

## Basic programming 

For learning more about programming in R, I suggest that you check out

* [Advanced Programming in R](http://adv-r.had.co.nz/)
* A "web book" (in html) called "[Ramarrow](http://www.quantide.com/R/ramarro/)" (the Italian name for Green Lizard/Smaragdeichse *Lacerta* spec.) on "R for Developers". A technical and example-rich introduction to programming with R, incl. S3/S4 classes, package production, debugging and alike.
* Ben Bolker's [Ecological models and data with R](http://ms.mcmaster.ca/~bolker/emdbook/)
* Pitfalls of the R language http://www.burns-stat.com/documents/books/the-r-inferno/
* For Germans - Ligges, U. (2008) Programmieren mit R. Springer. is a great book!


## Efficient R code

In a language that is compiled, such as C++, the compiler usually optimizes your code during the compilation process. R is not compiled, but interpreted. That means that one two options to write some code that produce the same output may have dramatically different runtimes. 

Basic laws are:

* Vectorize everything / i.e. avoid for loops
* Avoid reasignment or copying of large variables
* Prefer using in-built functions, particularly if they are compiled

For a more in-depth discussion, see [here](http://adv-r.had.co.nz/Performance.html)

If you have severe runtime problems, consider paralellization and or moving code to c/c++.

## Parallelization

* [parallel-basics](https://github.com/berkeley-scf/tutorial-parallel-basics/blob/master/parallel-basics.Rmd)

* [R-parallel-package-example](https://github.com/timchurches/smaRts/blob/master/parallel-package/R-parallel-package-example.md)




