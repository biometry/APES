---
layout: page
title: Creating Reports and Presentations with R
category: r
---


A norm R script (typically with file ending .r) can contain comments that explain what you are doing and why. It's fine to give the reader some hints, but for many case it would be nice to have some option to have a mix of 

* R code
* Text for comments 
* Ideally also the R output and figures produced 

in one file. There are several options to 

## RStudio built-in solutions

### R Markdown

Rmarkdown combines R and markdown. You created a new .Rmd file from Rstudio, new file menu. This will automatically past some example code in there, it's quite self-explenatory. Basically, you have text, and inbetween there is some "chunks", special text elemnts that contain the R code. From Rstudio, you can then render the text together with the exected R code and any result that is produced by that into an md, and from there automatically into either html, pdf or a word file. For details, see [here](http://shiny.rstudio.com/articles/rmarkdown.html)

For examples, note that most of the material on the Apes website is produced from Rmd. If you are on the html page, click on the link that brings you to the GitHub source, and you'll find the Rmd files.

### R Press 

Rpres works very similar to .Rmd, with the difference that a html5 presentation is produces instead of a single file. For examples have a look at our [mixed model material](https://github.com/biometry/APES/tree/master/LectureNotes/MixedEffectModels), lecture 4-6.

## knitR

http://yihui.name/knitr/

## Sweave

Sweave is around for a while and works outside RStudio. Basically, it's combining R with LaTeX code. See detailed explanation [here](http://www.statistik.lmu.de/~leisch/Sweave/)

