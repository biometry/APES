# Few more R Studio tips

Working directory: how to save your working directory [usually not recommended -> it is always good habit to re-run the scripts at the beginning of each session. If certain operations require long processing time, then always better to save the files / models and load them, rather than saving the working directory. (very personal choice though)
each project = 1 working directory




```r
mtcars -> mtcars #this is just to add the object to our workspace


getwd() # to know our current working directory
```

```
## [1] "C:/Users/sciuti/Documents/GitHub/toInclude/1_intro to R and R Studio"
```

```r
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio") # to set my current wd
```




```r
meanhp = mean(mtcars$hp)
y=c(1,2,3)
z=15
objectsum = summary(mtcars)
objectsum
```

```
##       mpg             cyl             disp             hp       
##  Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
##  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
##  Median :19.20   Median :6.000   Median :196.3   Median :123.0  
##  Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
##  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
##  Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
##       drat             wt             qsec             vs        
##  Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
##  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
##  Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
##  Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
##  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
##  Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
##        am              gear            carb      
##  Min.   :0.0000   Min.   :3.000   Min.   :1.000  
##  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
##  Median :0.0000   Median :4.000   Median :2.000  
##  Mean   :0.4062   Mean   :3.688   Mean   :2.812  
##  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
##  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```


OK, say you want to quit here. You may want to save the workspace to be able to continue exactly from where you left.

```r
#option 1
save.image("myfirstproject.Rdata")

#option 2 Session menu -> save workspace as

#option 3
#when you quit R studio, you'll be asked whether you wish to save the workspace
```


```r
#clean the workspace
rm(list=ls())    #or, menu -> session -> clear workspace

#quit R studio
```

Reopen R studio

```r
# set the directory with the script or the scroll menu
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio") 
load("myfirstproject.Rdata")

#alternative menu -> Session -> load workspace
```




tab key... you start to type an R command (e.g. summary)
also to recall an object name (e.g. obj)


##install packages
packages are add-ons that can extend R's functionality and perform specific tasks covering a wide range of modern statistic


```r
#install.packages("epiR")

#but see the menu bar -> Tools -> install packages
library(epiR)
```

```
## Loading required package: survival
## Package epiR 0.9-69 is loaded
## Type help(epi.about) for summary information
```

```r
library(effects)
```

-> END OF TOPIC.

+++++++++++++++++
Edited by Simone Ciuti, University of Freiburg, 9/10/2014; 
Intended for the only purpose of teaching @ Freiburg University
+++++++++++++++++++++++++++++++++++++++++++++++++
