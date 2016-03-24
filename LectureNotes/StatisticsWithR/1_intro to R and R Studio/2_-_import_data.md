# Import data from excel or similar editors
Most common file format people usually import are comma separated value .csv, tab delimited text file .txt.
However, there are not limits to it. Use GOOGLE if you want to import .xlsx, .dbf or data from other software (SPSS, SAS, Stata)

Let's make it simple this time, and let's learn from RStudio how to do it.

Import the file hospital_data_csvdel.csv and assing the file name data1 (top-right window of R studio -> Import Dataset -> follow the instructions properly).
Please note: make sure the final file visualized by Rstudio has "." and not "," for the decimals. 

Copy and paste the script that RStudio uses to import the file, it now is your script!


```r
data1 <- read.csv("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio/hospital_data_csvdel.csv") #this is the example of my laptop
# I can re-use the script to name the file in a different way
data2 = read.csv("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio/hospital_data_csvdel.csv")
```

By the way - when you create a new R script, always good habit to set the working directory


```r
#setting the directory is always handy (again, you learn the script from R Studio Session-> set working directory -> choose directory)
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio")
# data import now works without indicating the whole path.
data3 = read.csv("hospital_data_csvdel.csv")

#let's have a look to data summary
summary(data1)
```

```
##    Musclemass          Age            Height       Beer        Gender   
##  Min.   : 0.507   Min.   : 3.00   Min.   :45.30   no :648   female:358  
##  1st Qu.: 6.150   1st Qu.: 9.00   1st Qu.:59.90   yes: 77   male  :367  
##  Median : 8.000   Median :13.00   Median :65.40                         
##  Mean   : 7.863   Mean   :12.33   Mean   :64.84                         
##  3rd Qu.: 9.800   3rd Qu.:15.00   3rd Qu.:70.30                         
##  Max.   :14.675   Max.   :19.00   Max.   :81.80
```


```r
#import German_Example.csv. It may be problematic when we switch from computers with "." to computers with "," as decimanls indicators, and viceversa. No worries, just pay attention when you use the Import Dataset button in R studio

German_Example <- read.csv("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/1_intro to R and R Studio/German_Example.csv", dec=",")
```
In practive, as an additional benefit of using it, RStudio solves those issues for you with the Import dataset button. The dialog box that appears when 
you click it lets you choose separators, header line (yes/no) and whether there are quotes around fields, and shows a preview of what the table will 
look like. Then it builds the read.table command for you (CHECK THE SCRIPT AUTOMATICALLY GENERATED IN THE CONSOLE), so that you can copy it into your script. If you're not an RStudio user, just look at the actual file in a text editor, and add dec= and sep= instructions to your read.table as needed.

We can save our data as a R data file

```r
save(data1, file="data1.RData") ## THEY WILL BE STORED IN THE DIRECTORY YOU DID SET UP!
rm(data1)
#and can we easily reload it
load("data1.RData")
head(data1)
```

```
##   Musclemass Age Height Beer Gender
## 1      6.475   6   62.1   no   male
## 2     10.125  18   74.7  yes female
## 3      9.550  16   69.7   no female
## 4     11.125  14   71.0   no   male
## 5      4.800   5   56.9   no   male
## 6      6.225  11   58.7   no female
```


## Basic tools for data exploration

```r
summary(data1)
```

```
##    Musclemass          Age            Height       Beer        Gender   
##  Min.   : 0.507   Min.   : 3.00   Min.   :45.30   no :648   female:358  
##  1st Qu.: 6.150   1st Qu.: 9.00   1st Qu.:59.90   yes: 77   male  :367  
##  Median : 8.000   Median :13.00   Median :65.40                         
##  Mean   : 7.863   Mean   :12.33   Mean   :64.84                         
##  3rd Qu.: 9.800   3rd Qu.:15.00   3rd Qu.:70.30                         
##  Max.   :14.675   Max.   :19.00   Max.   :81.80
```

```r
head(data1)
```

```
##   Musclemass Age Height Beer Gender
## 1      6.475   6   62.1   no   male
## 2     10.125  18   74.7  yes female
## 3      9.550  16   69.7   no female
## 4     11.125  14   71.0   no   male
## 5      4.800   5   56.9   no   male
## 6      6.225  11   58.7   no female
```

```r
tail(data1)
```

```
##     Musclemass Age Height Beer Gender
## 720      7.325   9   66.3   no   male
## 721      5.725   9   56.0   no female
## 722      9.050  18   72.0  yes   male
## 723      3.850  11   60.5  yes female
## 724      9.825  15   64.9   no female
## 725      7.100  10   67.7   no   male
```

```r
dim(data1) # rows, column
```

```
## [1] 725   5
```

```r
class(data1)
```

```
## [1] "data.frame"
```

```r
data1[c(5,6,7),]
```

```
##   Musclemass Age Height Beer Gender
## 5      4.800   5   56.9   no   male
## 6      6.225  11   58.7   no female
## 7      4.950   8   63.3   no   male
```

```r
data1[5:9,]
```

```
##   Musclemass Age Height Beer Gender
## 5      4.800   5   56.9   no   male
## 6      6.225  11   58.7   no female
## 7      4.950   8   63.3   no   male
## 8      7.325  11   70.4   no   male
## 9      8.875  15   70.5   no   male
```

```r
data1[-(4:722),]
```

```
##     Musclemass Age Height Beer Gender
## 1        6.475   6   62.1   no   male
## 2       10.125  18   74.7  yes female
## 3        9.550  16   69.7   no female
## 723      3.850  11   60.5  yes female
## 724      9.825  15   64.9   no female
## 725      7.100  10   67.7   no   male
```

```r
names(data1)
```

```
## [1] "Musclemass" "Age"        "Height"     "Beer"       "Gender"
```

-> IN CLASS EXERCISES  2_EXERCISES.txt


+++++++++++++++++
Edited by Simone Ciuti, University of Freiburg, 9/10/2014; 
Intended for the only purpose of teaching @ Freiburg University
+++++++++++++++++++++++++++++++++++++++++++++++++
