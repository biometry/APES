Plotting in R
=== 

A lot more examples in the links here https://github.com/biometry/APES/blob/master/R/R10-gettingStarted.md#cookbooks--how-to

# Simple standard plots

## Scatter plot

### Simple Scatterplot

 ```{r}
attach(mtcars)	
plot(wt, mpg, main="Simple Scatterplot",xlab="Car Weight ", ylab="Miles Per Gallon " , 	
pch=22, col="red", bg="blue",cex=3, wd=2)
```

Where:	
•wt = x	
•mpg = y		
•main = Main title	
•xlab = title for the x axis	
•ylab = title for the y axis
•pch = type of symbol	
•col = color of pch	
•bg = background color of pch (from 21 to 25)	  
•lwd = size of pch	

![Simple Scatterplot](https://cloud.githubusercontent.com/assets/7631819/3041290/4e56331e-e0f3-11e3-99ee-1f188baabbef.png)

It is possible to add fitting lines:   

 1.Regresion line, where y is dependent of x (y~x).  
 ```{r}
 abline(lm(mpg~wt), col="red")  
 ```
 2.Lowess returns a list containing components x and y which give the coordinates of the smooth. 
 ```{r}
 lines(lowess(wt,mpg), col="blue")
 ```
 
![adding fit lines](https://cloud.githubusercontent.com/assets/7631819/3041488/f8edbd32-e0f4-11e3-8697-a30a81b5ebc9.png)

Downloading the car package we can use more enhanced features

```{r}
scatterplot(mpg ~ wt | cyl, data=mtcars, boxplots= "x,y",
            xlab="Car Weight", ylab="Miles Per Gallon", 
            main="Enhanced Scatter Plot", 
            labels=row.names(mtcars))
```

Where:   
•mpg ~ wt | cyl = the formula to plot by groups (x ~ y | z). It could also be a formula of the type x ~ y.
•data = dataframe  
•boxplots= boxplots for x and/or y   
•main = main title   
•xlab = title for the x axis	  
•ylab = title for the y axis   
•labels = labels for the points    

![enhanced scatterplot](https://cloud.githubusercontent.com/assets/7631819/3042487/eb965cbc-e0fd-11e3-9306-0e2f68631fbf.png)

Other enhanced features include: boxplots, regresion lines, jitter factors, legend options, etc.


###Scaterplott Matrices

```{r}
pairs(~disp+wt+drat+mpg,data=mtcars, 
   main="Simple Scatterplot Matrix")
```

Where:   
•~disp+wt+drat+mpg = numeric vectors that represent the variables in the plot  
•data = the data frame    
•main = main title   
 
![simpel scatterplot matrix](https://cloud.githubusercontent.com/assets/7631819/3042111/963adde0-e0fa-11e3-87e6-18a2b437444a.png)


### Three-dimensional


## Line plots

## Bar plots

## Pie charts

Don't do them! Use Bar plots instead. But if you really must know


# Others

## Box plots

### Normal box plot

### Notch plot

### Violin plots

## Density plots






