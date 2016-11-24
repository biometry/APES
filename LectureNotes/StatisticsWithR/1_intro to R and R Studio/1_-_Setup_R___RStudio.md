# 1 - Setup R & RStudio

R & R Studio are open source. 
http://www.r-project.org/
http://www.rstudio.com/

## Basic operations, objects, vectors and matrices.

Open R Studio which runs R

Let's create and save an R studio (very simple) script (on the RStudio command bar: File -> New File -> R script) 
Remember! You can use the symbol # to add comments that will not be processed by R as codes. 
Use of "Run" to run your script in the R console (otherwise, shortcut: Ctrl + enter)

Let's start with assigning values to objects in R, doing basic arithmetic functions, and performing a few other handy tasks in R.



```r
# assign a value to an object
x = 55
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

```r
#remember R is case sensitive - try to type X
#Error: object 'X' not found

# R does not care about SPACING, although it is good habit to put some space in your codes because they will be more readable eventually
a = 1
b=1

# use of arrow instead of "=". Remember, the arrow is directional (you can use both ways), while "=" assigns a value (on the rigth of =) to the object name (on the left of =)

z = 55 # assing 55 to z
# 55 = z does not work - try it out in your console

y <- 14
23 -> zz
```

Check the top righ window to verify what we just stored in the workspace memory.


or use the ls command

```r
ls()
```

```
## [1] "a"  "b"  "x"  "y"  "z"  "zz"
```

you can remove an object

```r
rm(y)
```


Object names can include numbers

```r
z1 = 15
z1
```

```
## [1] 15
```

```r
#but cannot begin with numbers
# try to type 2z =15
```

Quotaion marks to assign character to objects

```r
m1 = "Rclass"
m1
```

```
## [1] "Rclass"
```

```r
m2="25" #this is a character, not a number!
m2
```

```
## [1] "25"
```


```r
2 + 2
```

```
## [1] 4
```

```r
#but also with our objects
z1+x
```

```
## [1] 70
```

```r
#we store it in a new object
z = z1 + x
z
```

```
## [1] 70
```

```r
#we can square z
z^2
```

```
## [1] 4900
```

```r
sqrt(z) + x^2
```

```
## [1] 3033.367
```

```r
#natural log
log(x)
```

```
## [1] 4.007333
```

```r
#log base 2
log2(x)
```

```
## [1] 5.78136
```

```r
f = -34
abs(f)
```

```
## [1] 34
```

common mistake in R (incomplete command)

```r
# try to type sqrt(x
# you gotta complete the script!  (or press ESC if you are stuck)
```

- few shorcuts
In the R consol, try the arrow up key command


let's create a vector using the concatenate command

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
#sequence
2:7
```

```
## [1] 2 3 4 5 6 7
```

```r
seq(from = 1, to = 7, by = 1)
```

```
## [1] 1 2 3 4 5 6 7
```

```r
seq(from = 1, to = 7, by = 1/3)
```

```
##  [1] 1.000000 1.333333 1.666667 2.000000 2.333333 2.666667 3.000000
##  [8] 3.333333 3.666667 4.000000 4.333333 4.666667 5.000000 5.333333
## [15] 5.666667 6.000000 6.333333 6.666667 7.000000
```

```r
seq(from = 1, to = 7, by = 0.25)
```

```
##  [1] 1.00 1.25 1.50 1.75 2.00 2.25 2.50 2.75 3.00 3.25 3.50 3.75 4.00 4.25
## [15] 4.50 4.75 5.00 5.25 5.50 5.75 6.00 6.25 6.50 6.75 7.00
```

Let's create a vector repeating something for a certain number of times


```r
rep(1, times = 10)
```

```
##  [1] 1 1 1 1 1 1 1 1 1 1
```

```r
rep("simone", times = 10)
```

```
##  [1] "simone" "simone" "simone" "simone" "simone" "simone" "simone"
##  [8] "simone" "simone" "simone"
```

```r
rep(1:5, times=5)
```

```
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
```

```r
rep(seq(from = 2, to = 5,by = 0.25), times = 5)
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




```r
x = 1:5
y = c(1, 3, 5, 7, 9)
```

we can add a value to each element of the vector

```r
x + 10
```

```
## [1] 11 12 13 14 15
```

```r
x - 10
```

```
## [1] -9 -8 -7 -6 -5
```

```r
x * 10
```

```
## [1] 10 20 30 40 50
```

if 2 vectors are of the same length
we may add/subtract/mult/div corresponding elements

```r
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
x + y
```

```
## [1]  2  5  8 11 14
```

```r
x - y
```

```
## [1]  0 -1 -2 -3 -4
```

We can extract elements of a vector using squared brakets

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
#negative sign extract all except that element
y[-2]
```

```
## [1] 1 5 7 9
```

```r
y[1:3]
```

```
## [1] 1 3 5
```

```r
#extract the first anf the third
y[c(1,3)]
```

```
## [1] 1 5
```

```r
#all except them
y[-c(1,3)]
```

```
## [1] 3 7 9
```

```r
# you can include a conditional query
y[y < 3]
```

```
## [1] 1
```

```r
y[y < 20]
```

```
## [1] 1 3 5 7 9
```

we can create a matrix of value using the matrix command


```r
matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = TRUE) #enter the elements rowwise
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

```r
matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = FALSE)#values entered columnwise
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
mat1 = matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, byrow=TRUE) #enter the elements

mat1
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

square brakets used to grab elements from the matrix


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
mat1[2,] #row 2 and all columns
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

```r
# convert the matrix into a dataframe
mat1 = data.frame(mat1)
names(mat1) = c("column1", "column2", "column3")
mat1
```

```
##   column1 column2 column3
## 1       1       2       3
## 2       4       5       6
## 3       7       8       9
```

```r
mat1[,3] # selecting data on column3, all rows
```

```
## [1] 3 6 9
```

```r
# shortcut R studion Ctrl + L to clean up your console (only visualization, object are not deleted!)
```

-> browse the HTLM versione produced by Knitting this MarkDown file.
-> IN CLASS EXERCISES 1.EXERCISES.txt

+++++++++++++++++
Edited by Simone Ciuti, University of Freiburg, 14/10/2015; 
Intended for the only purpose of teaching @ Freiburg University.
+++++++++++++++++++++++++++++++++++++++++++++++++
