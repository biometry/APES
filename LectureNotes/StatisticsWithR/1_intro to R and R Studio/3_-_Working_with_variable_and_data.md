# Working with variable and data


```r
# mtcars is one of many files that are available in the basic configuration of R
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
names(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

```r
#?mtcars to get more info
```

A data frame with 32 observations on 11 variables.
[, 1]   mpg	 Miles/(US) gallon
[, 2]	 cyl	 Number of cylinders
[, 3]	 disp	 Displacement (cu.in.)
[, 4]	 hp	 Gross horsepower
[, 5]	 drat	 Rear axle ratio
[, 6]	 wt	 Weight (lb/1000)
[, 7]	 qsec	 1/4 mile time
[, 8]	 vs	 V/S
[, 9]	 am	 Transmission (0 = automatic, 1 = manual)
[,10]	 gear	 Number of forward gears
[,11]	 carb	 Number of carburetors


```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
summary(mtcars)
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

```r
class(mtcars$am)
```

```
## [1] "numeric"
```

```r
mtcars$fam = factor(mtcars$am, levels = c(0,1), labels = c("automatic","manual")) #let's create a new column fam, where we store am as factor
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##                         fam
## Mazda RX4            manual
## Mazda RX4 Wag        manual
## Datsun 710           manual
## Hornet 4 Drive    automatic
## Hornet Sportabout automatic
## Valiant           automatic
```

```r
class(mtcars$fam)
```

```
## [1] "factor"
```


use of $ sign, attach, detach, with

```r
#let's compute the mean of hp. 3 options for you.

#option1
mean(mtcars$hp) 
```

```
## [1] 146.6875
```

```r
#option2
attach(mtcars)
mean(hp)
```

```
## [1] 146.6875
```

```r
search()
```

```
##  [1] ".GlobalEnv"        "mtcars"            "package:stats"    
##  [4] "package:graphics"  "package:grDevices" "package:utils"    
##  [7] "package:datasets"  "package:methods"   "Autoloads"        
## [10] "package:base"
```

```r
detach(mtcars)  ###### always remember to detach!!!!!!!!!!!
search()
```

```
## [1] ".GlobalEnv"        "package:stats"     "package:graphics" 
## [4] "package:grDevices" "package:utils"     "package:datasets" 
## [7] "package:methods"   "Autoloads"         "package:base"
```

```r
#option3
with(mtcars,mean(hp))
```

```
## [1] 146.6875
```



```r
attach(mtcars)
class(mtcars)
```

```
## [1] "data.frame"
```

```r
names(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb" "fam"
```

```r
class(mpg)
```

```
## [1] "numeric"
```

```r
class(fam)
```

```
## [1] "factor"
```

```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  12 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
##  $ fam : Factor w/ 2 levels "automatic","manual": 2 2 2 1 1 1 1 1 1 1 ...
```

```r
levels(fam)
```

```
## [1] "automatic" "manual"
```

```r
summary(mtcars)
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
##        am              gear            carb              fam    
##  Min.   :0.0000   Min.   :3.000   Min.   :1.000   automatic:19  
##  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000   manual   :13  
##  Median :0.0000   Median :4.000   Median :2.000                 
##  Mean   :0.4062   Mean   :3.688   Mean   :2.812                 
##  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000                 
##  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```

```r
length(mpg)
```

```
## [1] 32
```

```r
length(fam)
```

```
## [1] 32
```

```r
detach(mtcars)
```


```r
x = c(0,1,1,1,0,0,0,0,0,0)
class(x)
```

```
## [1] "numeric"
```

```r
summary(x)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00    0.00    0.00    0.30    0.75    1.00
```

```r
x = as.factor(x)
class(x)
```

```
## [1] "factor"
```

```r
summary(x) #it reports frequencies now
```

```
## 0 1 
## 7 3
```


Subsetting the mtcars data


```r
attach(mtcars)
mtcars[11:14,]
```

```
##              mpg cyl  disp  hp drat   wt qsec vs am gear carb       fam
## Merc 280C   17.8   6 167.6 123 3.92 3.44 18.9  1  0    4    4 automatic
## Merc 450SE  16.4   8 275.8 180 3.07 4.07 17.4  0  0    3    3 automatic
## Merc 450SL  17.3   8 275.8 180 3.07 3.73 17.6  0  0    3    3 automatic
## Merc 450SLC 15.2   8 275.8 180 3.07 3.78 18.0  0  0    3    3 automatic
```

```r
mean(hp)
```

```
## [1] 146.6875
```

```r
mean(hp[fam == "automatic"])  # - assigns values to objects; == means equality in mathematical sense 
```

```
## [1] 160.2632
```

```r
mean(hp[fam == "manual"])
```

```
## [1] 126.8462
```

```r
mean(hp[cyl > 7])
```

```
## [1] 209.2143
```

```r
automatic = mtcars[fam == "automatic",]  ## only rows automatic, all columns
manual = mtcars[fam == "manual",]

dim(mtcars)
```

```
## [1] 32 12
```

```r
dim(automatic)
```

```
## [1] 19 12
```

```r
dim(manual)
```

```
## [1] 13 12
```

```r
summary(fam)
```

```
## automatic    manual 
##        19        13
```



```r
aut = hp[fam == "automatic"] # - assigns values to objects; == means equality in mathematical sense 
man = hp[fam == "manual"]

autover6cyl = mtcars[fam == "automatic" & cyl > 5,]
summary(autover6cyl)
```

```
##       mpg             cyl           disp             hp       
##  Min.   :10.40   Min.   :6.0   Min.   :167.6   Min.   :105.0  
##  1st Qu.:14.60   1st Qu.:7.5   1st Qu.:271.4   1st Qu.:143.2  
##  Median :15.95   Median :8.0   Median :311.0   Median :177.5  
##  Mean   :16.07   Mean   :7.5   Mean   :319.4   Mean   :174.4  
##  3rd Qu.:18.25   3rd Qu.:8.0   3rd Qu.:370.0   3rd Qu.:207.5  
##  Max.   :21.40   Max.   :8.0   Max.   :472.0   Max.   :245.0  
##       drat             wt             qsec             vs      
##  Min.   :2.760   Min.   :3.215   Min.   :15.41   Min.   :0.00  
##  1st Qu.:3.053   1st Qu.:3.440   1st Qu.:17.04   1st Qu.:0.00  
##  Median :3.080   Median :3.650   Median :17.51   Median :0.00  
##  Mean   :3.196   Mean   :3.925   Mean   :17.66   Mean   :0.25  
##  3rd Qu.:3.215   3rd Qu.:3.901   3rd Qu.:18.07   3rd Qu.:0.25  
##  Max.   :3.920   Max.   :5.424   Max.   :20.22   Max.   :1.00  
##        am         gear            carb              fam    
##  Min.   :0   Min.   :3.000   Min.   :1.000   automatic:16  
##  1st Qu.:0   1st Qu.:3.000   1st Qu.:2.000   manual   : 0  
##  Median :0   Median :3.000   Median :3.000                 
##  Mean   :0   Mean   :3.125   Mean   :2.938                 
##  3rd Qu.:0   3rd Qu.:3.000   3rd Qu.:4.000                 
##  Max.   :0   Max.   :4.000   Max.   :4.000
```

```r
dim(autover6cyl)
```

```
## [1] 16 12
```

```r
autover6cyl[1:3,]
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##                         fam
## Hornet 4 Drive    automatic
## Hornet Sportabout automatic
## Valiant           automatic
```

```r
notautomatic = mtcars[!fam=="automatic" ,]
notautomatic
```

```
##                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb    fam
## Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4 manual
## Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4 manual
## Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1 manual
## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1 manual
## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2 manual
## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1 manual
## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1 manual
## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2 manual
## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2 manual
## Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4 manual
## Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6 manual
## Maserati Bora  15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8 manual
## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2 manual
```

use of logic commands
remember that "mtcars"" is still attached


```r
mtcars[1:5,]
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
##                         fam
## Mazda RX4            manual
## Mazda RX4 Wag        manual
## Datsun 710           manual
## Hornet 4 Drive    automatic
## Hornet Sportabout automatic
```

```r
#hp of the first five cars
hp[1:5]
```

```
## [1] 110 110  93 110 175
```

```r
temp = hp >100
temp[1:5]
```

```
## [1]  TRUE  TRUE FALSE  TRUE  TRUE
```


```r
temp2 = as.numeric(hp > 100)
temp2[1:5]
```

```
## [1] 1 1 0 1 1
```



```r
mtcars[1:5,]
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
##                         fam
## Mazda RX4            manual
## Mazda RX4 Wag        manual
## Datsun 710           manual
## Hornet 4 Drive    automatic
## Hornet Sportabout automatic
```

```r
gear4 = gear==4
gear4[1:5]
```

```
## [1]  TRUE  TRUE  TRUE FALSE FALSE
```

```r
gear4_manual= gear==4 & fam =="manual"
gear4_manual[1:5]
```

```
## [1]  TRUE  TRUE  TRUE FALSE FALSE
```

cbind


```r
newdata = cbind(mtcars,gear4_manual)
head(newdata)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##                         fam gear4_manual
## Mazda RX4            manual         TRUE
## Mazda RX4 Wag        manual         TRUE
## Datsun 710           manual         TRUE
## Hornet 4 Drive    automatic        FALSE
## Hornet Sportabout automatic        FALSE
## Valiant           automatic        FALSE
```

```r
detach(mtcars)
```


ifelse statement

```r
attach(newdata)
```

```
## The following object is masked _by_ .GlobalEnv:
## 
##     gear4_manual
```

```r
newdata$cyltest = ifelse(gear == 4,"four","nofour")
head(newdata)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
##                         fam gear4_manual cyltest
## Mazda RX4            manual         TRUE    four
## Mazda RX4 Wag        manual         TRUE    four
## Datsun 710           manual         TRUE    four
## Hornet 4 Drive    automatic        FALSE  nofour
## Hornet Sportabout automatic        FALSE  nofour
## Valiant           automatic        FALSE  nofour
```

```r
detach(newdata)
```






```r
rm(list = ls()) #this clean your workspace removing all the objects
```





-> IN CLASS EXERCISES  3_EXERCISES.txt



+++++++++++++++++
Edited by Simone Ciuti, University of Freiburg, 9/10/2014; 
Intended for the only purpose of teaching @ Freiburg University
+++++++++++++++++++++++++++++++++++++++++++++++++
