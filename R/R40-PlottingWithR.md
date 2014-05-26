Plotting in R
=== 

A lot more examples in the links here https://github.com/biometry/APES/blob/master/R/R10-gettingStarted.md#cookbooks--how-to

# Simple standard plots

## Scatter plot

### Simple Scatterplot

 ```{r}
attach(iris)
head(iris)
plot(Petal.Length, Sepal.Length, main="Simple Scatterplot",xlab="Petal Length ",ylab="Sepal Length " , 
     pch=22, col="red", bg="blue",cex=3, lwd=2)
```

Where:	
•Petal.Length = x	   
•Sepal.Length = y		 
•main = Main title	
•xlab = title for the x axis	
•ylab = title for the y axis
•pch = type of symbol	
•col = color of pch	
•bg = background color of pch (from 21 to 25)	  
•lwd = size of pch	

![simple scatterplot](https://cloud.githubusercontent.com/assets/7631819/3052442/9745fa8a-e19a-11e3-9542-337ec7d2a541.png)

It is possible to add <b>fitting lines</b>:   

 1.Regresion line, where y is dependent of x (y~x).  
 ```{r}
abline(lm(Sepal.Length~Petal.Length), col="red")  
 ```
 2.Lowess returns a list containing components x and y which give the coordinates of the smooth. 
 ```{r}
lines(lowess(Petal.Length, Sepal.Length), col="blue")
 ```
 
![adding fit lines](https://cloud.githubusercontent.com/assets/7631819/3052450/a88a4cba-e19a-11e3-8ee2-5efd8fee70aa.png)

By downloading the <b>car</b> package we can use more enhanced features

```{r}
library(car)
scatterplot(Sepal.Length~Petal.Length | Species, data=iris, boxplots= "x,y",
            xlab="Petal Length ",ylab="Sepal Length ", 
            main="Enhanced Scatter Plot", labels=row.names(iris))
```

Where:   
•Sepal.Length~Petal.Length | Species = the formula to plot by groups (x ~ y | z). It could also be a formula of the type x ~ y.  
•data = dataframe   
•boxplots= boxplots for x and/or y   
•main = main title   
•xlab = title for the x axis	  
•ylab = title for the y axis   
•labels = labels for the points    

![enhanced scatterplot](https://cloud.githubusercontent.com/assets/7631819/3052452/b59a70ba-e19a-11e3-90d2-0cb81e162c5a.png)

Other enhanced features include: boxplots, regresion lines, jitter factors, legend options, etc.


###Scaterplott Matrices

```{r}
pairs(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,data=iris, 
      main="Simple Scatterplot Matrix")
```

Where:   
•~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width = Numeric vectors that represent the variables in the plot  
•data = the data frame    
•main = main title   
 
![simple scatterplot matrix](https://cloud.githubusercontent.com/assets/7631819/3052454/c4ec6fbe-e19a-11e3-82bf-ab7502be8f87.png)

With the <b>lattice</b> package it is possible to condicion our matrix on a factor (tree specie in this case)

```{r}
library(lattice)
super.sym <- trellis.par.get("superpose.symbol")  
splom(~iris[1:4], groups = Species, data = iris,  
      superpanel, key = list(title = "Varieties of Iris",  
                 columns = 3,   
                 points = list(pch = super.sym$pch[1:3],  
                               col = super.sym$col[1:3]),  
                 text = list(c("Setosa", "Versicolor", "Virginica"))))  
```  

Where:   
•~iris[1:4] = the object we want to analyse (columns 1 to 4)  
•groups = which variable is going to be evaluated  
•data = dataframe   
•superpanel = function that sets up the splom display, by default as a scatterplot matrix   
•key = legend   
•text = labels for levels of the grouping variable   


![lattice matrix](https://cloud.githubusercontent.com/assets/7631819/3052460/eb15378e-e19a-11e3-8079-cbb62cd8ae4c.png)


We can also condicion our matrix on a factor with the <b>car</b> package.   
The advantage of this package is that we can include lowess and linear best fit lines,  boxplots, densities, or histograms in the principal diagonal, as well as rug plots in the margins of the cells.

```{r}
scatterplot.matrix(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width|Species, data=iris,   
                   main="Three Species Options") 
```

![car matrix](https://cloud.githubusercontent.com/assets/7631819/3080975/b02d6b16-e4b8-11e3-9a8e-110528c2f736.png)  

With the <b>gclus</b> package we can rearrange the variables to represent those with higher correlations closer to the principal diagonal and to set up diferent colors depending of the correlation grade.  

```{r}
library(gclus)  
data <- iris[c(1,2,3,4)]    
data.corr <- abs(cor(data))  
data.color <- dmat.color(data.corr) 
# reorder variables so those with highest correlation  
# are closest to the diagonal  
data.order <- order.single(data.corr)   
cpairs(data, data.order, panel.colors=data.color, gap=.5,  
       main="Correlation Graph" )  
```
Where:   
•data = we get the data (columns 1,2,3,4 in this case)   
•data.corr = we get the correlations    
•data.color = get the colors depending of the correlation   
•data.order = to reorder the variables according to the correlation and proximity to the diagonal   
•cpairs = plotting the result     

![gclus matrix](https://cloud.githubusercontent.com/assets/7631819/3081072/70735268-e4ba-11e3-987c-1d00fec0da38.png)




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






