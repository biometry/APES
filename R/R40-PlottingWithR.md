Plotting in R
=== 

A lot more examples in the links here https://github.com/biometry/APES/blob/master/R/R10-gettingStarted.md#cookbooks--how-to

# Simple standard plots

## Scatter plot

### Simple Scatterplot

 ```{r}
attach(Orange)
head(Orange)
plot(age, circumference, main="Simple Scatterplot",xlab="Tree age ",ylab="Tree Diameter " , 
     pch=22, col="red", bg="blue",cex=3, lwd=2)
```

Where:	
•age = x	
•circumference = y		
•main = Main title	
•xlab = title for the x axis	
•ylab = title for the y axis
•pch = type of symbol	
•col = color of pch	
•bg = background color of pch (from 21 to 25)	  
•lwd = size of pch	

![simple scatterplot](https://cloud.githubusercontent.com/assets/7631819/3052076/3ce4d098-e195-11e3-829c-da209213bd67.png)

It is possible to add fitting lines:   

 1.Regresion line, where y is dependent of x (y~x).  
 ```{r}
 abline(lm(circumference~age), col="red")   
 ```
 2.Lowess returns a list containing components x and y which give the coordinates of the smooth. 
 ```{r}
 lines(lowess(age, circumference), col="blue")
 ```
 
![adding fit lines](https://cloud.githubusercontent.com/assets/7631819/3052082/5217030a-e195-11e3-838e-6edef50f9eca.png)

Downloading the car package we can use more enhanced features

```{r}
library(car)
scatterplot(circumference~age | Tree, data=Orange, boxplots= "x,y",
            xlab="Tree age", ylab="Tree Diameter", 
            main="Enhanced Scatter Plot", labels=row.names(Orange))
```

Where:   
•circumference~age | Tree = the formula to plot by groups (x ~ y | z). It could also be a formula of the type x ~ y.
•data = dataframe  
•boxplots= boxplots for x and/or y   
•main = main title   
•xlab = title for the x axis	  
•ylab = title for the y axis   
•labels = labels for the points    

![enhanced scatterplot](https://cloud.githubusercontent.com/assets/7631819/3052083/607884b4-e195-11e3-8087-6f01ae49af64.png)

Other enhanced features include: boxplots, regresion lines, jitter factors, legend options, etc.


###Scaterplott Matrices

```{r}
pairs(~age+circumference+Tree,data=Orange, 
      main="Simple Scatterplot Matrix")
```

Where:   
•~age+circumference+Tree = numeric vectors that represent the variables in the plot  
•data = the data frame    
•main = main title   
 
![simple scatterplot matrix](https://cloud.githubusercontent.com/assets/7631819/3052104/bc66ca74-e195-11e3-89b4-d5b387a2e630.png)


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






