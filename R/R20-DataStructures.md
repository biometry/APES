# Data in R

Data in R
===

Before we can work with data, we need to be able to read it in an represent it in R

## Reading in data

see here http://www.statmethods.net/input/importingdata.html

## Data structures

An overview and examples of the available data structures in R is here

[here](http://ecology.msu.montana.edu/labdsv/R/labs/R_ecology.html#recol)

[QuickR](http://www.statmethods.net/)

Read up this http://ecology.msu.montana.edu/labdsv/R/labs/R_ecology.html#recol

http://www.uni-kiel.de/psychologie/rexrepos/rerR_Basics.html

Important data structures are

* Atomic variables (numeric, char)
* Vectors (a sequence of atomic variables. For example c(1,2,3,4) is a vector of 4 numeric variables)
* Lists (like a vector, but unordered)
* A data frame (technically a list of vectors, untechnically think of it as a spreadsheat with collumns that can be of different atomic type)

Hint: you can find out the type and structure of an object in R with the class() and str() command

### Working with and manipulating data frames

The data frame is the most common choice to represent your field data, thefore it's important to know how to work with them and select data from them. 

http://www.uni-kiel.de/psychologie/rexrepos/rerData_Frames.html

## Working with big data 

http://blog.revolutionanalytics.com/2014/08/the-iris-data-set-for-big-data.html


"Text File Splitter": http://www.systemwidgets.com/Downloads/FreewareDownloads/TextFileSplitter/tabid/120/Default.aspx can split very larve (> several GB) textfiles 


# Basic operations

It is possible to assign a value to an object with the "=" or "->" symbols


```r
x = 55
x <- 55
```

and check the result with the "print" command


```r
print(x)
```

```
## [1] 55
```

```r
#or
x
```

```
## [1] 55
```

R is case sensitive, if we try to type X we got the following message: "Error: object 'X' not found"

A common mistake in R is to write an incomplete command. If we type "sqrt(x" we get an error. We gotta complete the script (or press ESC if the programm gets stuck)


It is possible to remove an object from our workspace with the "rm" command 

```r
rm(y)
```

```
## Warning: Objekt 'y' nicht gefunden
```

Object names can include numbers

```r
z1 = 15
z1
```

```
## [1] 15
```

But they cannot begin with numbers. "2z =15", for example, would create an error

We use quotation marks to assign characters to objects

```r
m1 = "Rclass"
m1
```

```
## [1] "Rclass"
```

```r
m2="25" #like this, 25 is not a number anymore, but a character
m2
```

```
## [1] "25"
```

## Some basic arithmetic functions


```r
#sum
2+2
```

```
## [1] 4
```

```r
#We can also perform operations with the object that we have previously defined
z1+x
```

```
## [1] 70
```

```r
#we store it into a new object
z=z1+x
z
```

```
## [1] 70
```

```r
#square
z^2
```

```
## [1] 4900
```

```r
#square root 
sqrt(z) 
```

```
## [1] 8.367
```

```r
#natural log
log(x)
```

```
## [1] 4.007
```

```r
#log base 3
log2(x)
```

```
## [1] 5.781
```

```r
#absolute value
f = -34
abs(f) 
```

```
## [1] 34
```

#Vectors

We can create a vector by using the concatenated command c()

```r
x1 = c(1,3,5,7,9)
x1
```

```
## [1] 1 3 5 7 9
```

```r
gender = c("male", "female")
gender
```

```
## [1] "male"   "female"
```

```r
2:7 # sequence from 2 to 7
```

```
## [1] 2 3 4 5 6 7
```

```r
seq(from=1, to=7, by=1) # sequence from 1 to 7 by 1
```

```
## [1] 1 2 3 4 5 6 7
```

```r
seq(from=1, to=7, by=1/3) # sequence from 1 to 7 by 0,333
```

```
##  [1] 1.000 1.333 1.667 2.000 2.333 2.667 3.000 3.333 3.667 4.000 4.333
## [12] 4.667 5.000 5.333 5.667 6.000 6.333 6.667 7.000
```

```r
seq(from=1, to=7, by=0.25) # sequence from 1 to 7 by 0,25
```

```
##  [1] 1.00 1.25 1.50 1.75 2.00 2.25 2.50 2.75 3.00 3.25 3.50 3.75 4.00 4.25
## [15] 4.50 4.75 5.00 5.25 5.50 5.75 6.00 6.25 6.50 6.75 7.00
```

Create a vector repeating something a certain number of times

```r
rep(1, times=10)
```

```
##  [1] 1 1 1 1 1 1 1 1 1 1
```

```r
rep("vector", times=10)
```

```
##  [1] "vector" "vector" "vector" "vector" "vector" "vector" "vector"
##  [8] "vector" "vector" "vector"
```

```r
rep(1:5, times=5)
```

```
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
```

```r
rep(seq(from=2, to=5,by=0.25), times =5)
```

```
##  [1] 2.00 2.25 2.50 2.75 3.00 3.25 3.50 3.75 4.00 4.25 4.50 4.75 5.00 2.00
## [15] 2.25 2.50 2.75 3.00 3.25 3.50 3.75 4.00 4.25 4.50 4.75 5.00 2.00 2.25
## [29] 2.50 2.75 3.00 3.25 3.50 3.75 4.00 4.25 4.50 4.75 5.00 2.00 2.25 2.50
## [43] 2.75 3.00 3.25 3.50 3.75 4.00 4.25 4.50 4.75 5.00 2.00 2.25 2.50 2.75
## [57] 3.00 3.25 3.50 3.75 4.00 4.25 4.50 4.75 5.00
```

```r
rep(c("m","f"),times=10)
```

```
##  [1] "m" "f" "m" "f" "m" "f" "m" "f" "m" "f" "m" "f" "m" "f" "m" "f" "m"
## [18] "f" "m" "f"
```

we can add a value to each element of the vector

```r
x = 1:5

x + 10
```

```
## [1] 11 12 13 14 15
```

```r
x-10
```

```
## [1] -9 -8 -7 -6 -5
```

```r
x*10
```

```
## [1] 10 20 30 40 50
```

We may add/subtract/mult/div but the vectors HAVE to be the same length

```r
y = c(1,3,5,7,9)
x = 1:5

x
```

```
## [1] 1 2 3 4 5
```

```r
y
```

```
## [1] 1 3 5 7 9
```

```r
x+y
```

```
## [1]  2  5  8 11 14
```

```r
x-y
```

```
## [1]  0 -1 -2 -3 -4
```

It is possible to extract elements of a vector by using squared brakets

```r
y
```

```
## [1] 1 3 5 7 9
```

```r
y[2]
```

```
## [1] 3
```

```r
#A negative sign indicates R to extract all the elements except that one
y[-2]
```

```
## [1] 1 5 7 9
```

```r
#extract the first and the third elements
y[c(1,3)]
```

```
## [1] 1 5
```

```r
#extract all the elemets except the first and the third
y[-c(1,3)]
```

```
## [1] 3 7 9
```

```r
#extract all the elements above the third one
y[y<3]
```

```
## [1] 1
```

##Matrices

We can create a matrix of values by using the matrix command

```r
matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=TRUE) #enter the elements rowwise
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

```r
matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=FALSE) #values entered columnwise
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
mat1= matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=TRUE) #enter the elements

mat1
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

Square brakets are used to grab elements from the matrix

```r
mat1[1,2]  #element in the first row and second column
```

```
## [1] 2
```

```r
mat1[c(1,3),2]
```

```
## [1] 2 8
```

```r
mat1[2,] #row 2nd and all the columns
```

```
## [1] 4 5 6
```

```r
mat1[,1]
```

```
## [1] 1 4 7
```

```r
mat1*10
```

```
##      [,1] [,2] [,3]
## [1,]   10   20   30
## [2,]   40   50   60
## [3,]   70   80   90
```


