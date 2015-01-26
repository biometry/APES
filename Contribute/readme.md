Overview for contributors
===

We need your help to fill the stats help with content and remove problems. Below we explain how you can contribute

## How to report a problem

If you see a problem or if you have a suggestion, log in to GitHub and report the issue at https://github.com/biometry/APES/issues

## How to contribute content

Ordered with increasing technical demands, and decreasing work for us. Please choose the highest number you're comfortable with, this will reduce our workload

1. Write your text as .txt or .rtf and send it to http://www.biom.uni-freiburg.de/mitarbeiter/hartig or to https://www.biom.uni-freiburg.de/mitarbeiter/janeiro
2. Write your text in R markdown (see help below) and send it to http://www.biom.uni-freiburg.de/mitarbeiter/hartig or to https://www.biom.uni-freiburg.de/mitarbeiter/janeiro
3. If you know how to use GitHub, clone our repository, change the text, and issue a pull request so that we can include your changes 

## Getting started with R markdown

We use R markdown to write the text for this site. 

"R Markdown is an authoring format that enables easy creation of dynamic documents, presentations, and reports from R. It combines the core syntax of markdown (an easy-to-write plain text format) with embedded R code chunks that are run so their output can be included in the final document. R Markdown documents are fully reproducible (they can be automatically regenerated whenever underlying R code or data changes)." ( http://rmarkdown.rstudio.com/ )

If you start working with R markdown, you will see that it's extremely simple and very similar to wiki syntax you might be used to. Have a look at 

* http://jeromyanglim.blogspot.de/2012/05/getting-started-with-r-markdown-knitr.html
* https://support.rstudio.com/hc/en-us/articles/200552086-Using-R-Markdown

## Special tasks

### Code

We use chunks to display our codes. The chunks can be manually added by writting ```{r} code ``` or inserted automaticly by clicking on the chunk button at the top right corner of the script window.
Some extra info about R Code Chunks:

* http://rmarkdown.rstudio.com/authoring_rcodechunks.html

### Images 

By default, images should be in the folder /img/ and labeled according to the file in which they are first used. If the file is R50-plotting.md , the image should be callded R50-ScatterPlot.png.



### Linking Videos 

```
<a href="http://www.youtube.com/watch?v=q1RD5ECsSB0" target="_blank">
![Video](http://img.youtube.com/vi/q1RD5ECsSB0/0.jpg)<br/ >
Video demonstrating multiple linear regresssion in R
</a>
```

# Developers / Admins

Shifting changes from md to the page is easy, just merge the main branch in the gh-pages branch. 

If you want to change css and other elements in the gh-pages branch, you need to install a local Jekyll version, you can't really debug problems by commiting to GitHub and see how things change. See https://help.github.com/articles/using-jekyll-with-pages/#installing-jekyll for a tutorial on installing Jekyll

Create site from terminal with bundle exec jekyll serve

