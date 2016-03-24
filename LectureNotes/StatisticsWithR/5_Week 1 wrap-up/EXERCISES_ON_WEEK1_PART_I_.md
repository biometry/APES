# Simone Ciuti
# Exercise # 1 - Quick revision of basic tasks in R

(1) Create a vector with numbers from 1 to 100 increasing by 0.12 (myvector is the name assigned to the vector); 
(2) how many numbers are stored in your vector?
(3) calculate the sqrt of the 50th value minus the log10 of the 10th value of the vector



(4) Create 2 samples (sample size = 184 in both cases) randomly drawn for 2 normal distributions. 
    Set the seed with the number 10 to make your results comparable to your colleagues
    One sample is randomly drawn from a standard normal distribution.
    The other sample is randomly drawn from a normal distribution with mean = 103 and sd = 12
(5) create a matrix (rowwise, 92 rows) with the first sample, and another matrix (columnwise, 92 rows) with the second sample


(6) provided the following data (old experiment from the 40s)

```r
library(MASS)
data(cats)
attach(cats)
head(cats)
```

```
##   Sex Bwt Hwt
## 1   F 2.0 7.0
## 2   F 2.0 7.4
## 3   F 2.0 9.5
## 4   F 2.1 7.2
## 5   F 2.1 7.3
## 6   F 2.1 7.6
```
Is the variable Hwt (heart weight) normally distributed?


(7) Using the same dataset that it is still attached (cats), make a plot with x= Bwt (body weight in kg) and y= Hwt (heart weight in g). 
Add 2 simple linear fits (one for females, one for males). Make sure you use different colours for symbols depending on Sex. Add a proper legend and detach the dataset.





# Exercise # 2 Poverty level
Load the dataset poverty.txt
In the following data pairs
first column: percentage of population below poverty level in 1998, as recorded in 51 randomly selected villages
second column: percentage of population below poverty level in 1990 (same villages as the first column
Reference: Statistical Abstract of the United States, 120th edition



Did poverty levels change in 1998 compared to 1990?








