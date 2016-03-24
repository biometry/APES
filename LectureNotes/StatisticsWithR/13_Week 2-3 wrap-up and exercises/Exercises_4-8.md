# Exercises

# Exercise # 4 - Quick revision of basic tasks in R

(1) Create a vector with numbers from 1 to 100 increasing by 0.12 (myvector is the name assigned to the vector); 
(2) how many numbers are stored in your vector?
(3) calculate the sqrt of the 50th value minus the log10 of the 10th value



(4) Create 2 samples (sample size = 184 in both cases) randomly drawn for 2 normal distributions. 
    One sample is randomly drawn from a standard normal distribution.
    The other sample is randomly drawn from a normal distribution with mean = 103 and sd = 12
(5) create a matrix (rowwise,92 rows) with the first sample, and another matrix (columnwise, 92 rows) with the second sample


(6) provided the following data (old experiment from the 40s)

```r
library(MASS); data(cats); attach(cats)
```
Is the variable Hwt (heart weight) normally distributed?


(7) Using the same dataset that it is still attached (cats), make a plot with x = Bwt (body weight in kg) and y = Hwt (heart weight in g). 
Add 2 simple linear fits (one for females, one for males). Make sure you use different colours for symbols depending on Sex. Add a proper legend and detach the dataset.






# Exercise # 5 - Airquality dataset
Daily air quality measurements in New York, May to September 1973
A data frame with 154 observations on 6 variables.

[,1]  Ozone	 numeric	 Ozone (ppb)
[,2]	Solar.R	 numeric	 Solar R (lang)
[,3]	Wind	 numeric	 Wind (mph)
[,4]	Temp	 numeric	 Temperature (degrees F)



```r
data(airquality)
#we remove 2 columns that are not the target of our analyses 
airquality$Month = NULL
airquality$Day = NULL
summary(airquality)
```

```
##      Ozone           Solar.R           Wind             Temp      
##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
##  NA's   :37       NA's   :7
```

```r
head(airquality)
```

```
##   Ozone Solar.R Wind Temp
## 1    41     190  7.4   67
## 2    36     118  8.0   72
## 3    12     149 12.6   74
## 4    18     313 11.5   62
## 5    NA      NA 14.3   56
## 6    28      NA 14.9   66
```

```r
attach(airquality)
```
You are interest on the effect of Solar.R, Wind, and Temp on Ozone concentrations. 
(1) are you allowed to use these 3 predictors in the same model?


 

(2) fit a multiple linear regression without any interaction terms or quadratic terms. Are the assumptions of the model met? Y/N? Why?











# Exercise # 6 Weights of American football players
load the provided dataset weights.txt



The  data represent weights (pounds) of a random sample of professional football players on the following teams.
X1 = weights of players for the Dallas Cowboys
X2 = weights of players for the Green Bay Packers
X3 = weights of players for the Denver Broncos
X4 = weights of players for the Miami Dolphins
X5 = weights of players for the San Francisco Forty Niners
Reference: The Sports Encyclopedia Pro Football

(1) Using a parametric procedure, can you detect any difference in player weights depending on the team? What is your null hypothesis? Can we reject the null hypothesis? Provide a plot and explain your results. 


  

(2) do we meet model assumptions of the parametric model? Y/N? why?



(3) run the non-parametric alternative. What is the null hypothesis here? Is the final conclusion you get from the non-parametric procedure different to that shown by the parametric one? Would you recommend using the parametric or the non-parametric test here?







# Exercise # 7 Poverty level
Load the dataset poverty.txt
In the following data pairs
first column: percentage of population below poverty level in 1998, as recorded in 51 randomly selected villages.
second column: percentage of population below poverty level in 1990 (same villages as the first column.
Reference: Statistical Abstract of the United States, 120th edition.



Did poverty levels change in 1998 compared to 1990?






# Exercise # 8  Admission at school 
Load the dataset provided



```r
load("mydata.Rdata")
head(mydata)
```

```
##   admit gre  gpa rank
## 1     0 380 3.61    3
## 2     1 660 3.67    3
## 3     1 800 4.00    1
## 4     1 640 3.19    4
## 5     0 520 2.93    4
## 6     1 760 3.00    2
```

```r
mydata$rank = as.factor(mydata$rank)
attach(mydata)
summary(mydata)
```

```
##      admit             gre             gpa        rank   
##  Min.   :0.0000   Min.   :220.0   Min.   :2.260   1: 61  
##  1st Qu.:0.0000   1st Qu.:520.0   1st Qu.:3.130   2:151  
##  Median :0.0000   Median :580.0   Median :3.395   3:121  
##  Mean   :0.3175   Mean   :587.7   Mean   :3.390   4: 67  
##  3rd Qu.:1.0000   3rd Qu.:660.0   3rd Qu.:3.670          
##  Max.   :1.0000   Max.   :800.0   Max.   :4.000
```
A researcher is interested in how variables, such as GRE (Graduate Record Exam scores), GPA (grade point average) and prestige of the undergraduate institution, effect admission into graduate school. The response variable, admit/don't admit, is a binary variable. 
The variable rank takes on the values 1 through 4. Institutions with a rank of 1 have the highest prestige, while those with a rank of 4 have the lowest. 

(1) Fit a regression in order to predict the students' probability of being admitted based on gre, gpa, and rank (for this exercise, you are NOT required to include quadratic and/or interaction terms)
How do you interpret the results? 


 

(2) Keeping gre to its median value, plot the predictions of the model (x = gpa, y = admit, 4 lines for the 4 ranks) including SEs 






