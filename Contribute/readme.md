Overview for contributors
===

We need your help to fill the stats help with content and remove problems. Below we explain how you can contribute

##How to report a problem

If you see a problem or if you have a suggestion, log in to GitHub and report the issue at https://github.com/florianhartig/APES/issues

##How to contribute content

Ordered with increasing technical demands, and decreasing work for us. Please choose the highest number you're comfortable with, this will reduce our workload

1. Write your text as .txt or .rtf and send it to http://www.biom.uni-freiburg.de/mitarbeiter/hartig
2. Write your text in markdown (see help below) and send it to http://www.biom.uni-freiburg.de/mitarbeiter/hartig
3. If you know how to use GitHub, clone our repository, change the text, and issue a pull request so that we can include your changes 

##Getting started with markdown

We use markdown to write the text for this site. 

"Markdown is a plain text formatting syntax designed so that it can optionally be converted to HTML using a tool by the same name. Markdown is popularly used as format for readme files, or for writing messages in online discussion forums, or in text editors for the quick creation of rich text documents." ( http://en.wikipedia.org/wiki/Markdown )

If you start working with markdown, you will see that it's extremely simple and very similar to wiki syntax you might be used to. Have a look at 

* https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
* https://help.github.com/articles/github-flavored-markdown

##Special tasks

### Code


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

