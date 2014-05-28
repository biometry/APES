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

![Simple Scatterplot](https://raw.githubusercontent.com/biometry/APES/master/images/Simple%20Scatterplot.png)

It is possible to add <b>fitting lines</b>:   

 1.Regresion line, where y is dependent of x (y~x).  
 ```{r}
abline(lm(Sepal.Length~Petal.Length), col="red")  
 ```
 2.Lowess returns a list containing components x and y which give the coordinates of the smooth. 
 ```{r}
lines(lowess(Petal.Length, Sepal.Length), col="blue")
 ```
 
![adding fit lines](https://raw.githubusercontent.com/biometry/APES/master/images/Adding%20fit%20lines.png)
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

![enhanced scatterplot](https://raw.githubusercontent.com/biometry/APES/master/images/Enhanced%20Scatterplot.png)

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
 
![simple scatterplot matrix](https://raw.githubusercontent.com/biometry/APES/master/images/Simple%20Scatterplot%20Matrix.png)

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


![lattice matrix](https://raw.githubusercontent.com/biometry/APES/master/images/Lattice%20matrix.png)


We can also condicion our matrix on a factor with the <b>car</b> package.   
The advantage of this package is that we can include lowess and linear best fit lines,  boxplots, densities, or histograms in the principal diagonal, as well as rug plots in the margins of the cells.

```{r}
scatterplot.matrix(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width|Species, data=iris,   
                   main="Three Species Options") 
```

![car matrix](https://raw.githubusercontent.com/biometry/APES/master/images/car%20matrix.png)  

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

![gclus matrix](https://raw.githubusercontent.com/biometry/APES/master/images/gclus%20matrix.png)


### High Density Scatterplot

There are 2 options to plot whenever we are working with too many data points that overlap.  
The <b>hexbin</b> package creates a group of hexagonal cells and a count of points falling in each occupied cell. 
```{r}
library(hexbin)  
bin<-hexbin(Petal.Width ~ Petal.Length, xbins=100, xlab="Petal.Width",ylab="Petal.Length")  
plot(bin, main="Hexagonal Binning") 
```
Where:  
•xbins = number of hexagons across the x axis  

![hexagonal binning](https://raw.githubusercontent.com/biometry/APES/master/images/Hexagonal%20binning.png)

The other option is the <b>sunflowerplot</b> function.

```{r}
sunflowerplot(Petal.Width ~ Petal.Length, data = iris,  
              cex = .5, cex.fact = .8, size = .15,   
              xlab="Petal.Width",ylab="Petal.Length", main= "Sunflower Plot")  
```
Where:   
•cex = size of the center points  
•cex.fact = size of the center points where there are flower leaves   
•size = size of the flower leaves  

![sunflower plot](https://raw.githubusercontent.com/biometry/APES/master/images/sunflower%20plot.png)



### Three-dimensional

we need the <b>scatterplot3d</b> package to represent 3D scatterplots.

```{r}
library(scatterplot3d)  
iris3d<-scatterplot3d(Sepal.Length,Sepal.Width,Petal.Length, pch=18, highlight.3d=TRUE,  
              type="h", main="3D Iris")  
reg.plane <- lm(Petal.Length ~ Sepal.Length+Sepal.Width)   
iris3d$plane3d(reg.plane)  
```
Where:   
•pch = type of symbol   
•highlight.3d = the points will are colored according to the y coordinates     
•type = "p" for points, "l" for lines, "h" for vertical lines   
•plane3d = we draw a regression plane


![3d scatterplot](https://raw.githubusercontent.com/biometry/APES/master/images/3D%20scatterplot.png)

It is possible to spin our 3d model with the mouse using the <b>rgl</b> package or the <b>Rcmdr</b> package.  

```{r}
library(rgl)   
plot3d(Sepal.Length,Sepal.Width,Petal.Length, col="blue", size=4)  
```
![spinning scatterplot](https://raw.githubusercontent.com/biometry/APES/master/images/Spinning%20Scatterplot.JPG)

```{r}
library(Rcmdr)  
scatter3d(Sepal.Length,Sepal.Width,Petal.Length)  
```
![spinning scatterplot2](https://raw.githubusercontent.com/biometry/APES/master/images/Spinning%20Scatterplot2.JPG)


## Line plots

```{r}
attach(iris)  
par(pch=18, col="blue",mfrow=c(2,4))  
opts = c("p","l","o","b","c","s","S","h")   
for(i in 1:length(opts)){   
  heading = paste("type=",opts[i])   
  plot(Sepal.Length, Sepal.Width, type="n", main=heading)   
  lines(Sepal.Length, Sepal.Width, type=opts[i])}  
```
Where:   
•mfrow = with this option we represent all the plots in the same page  
* types
  * p = points  
  * l = lines  
  * o = points & lines overplotted  
  * b = points linked by lines  
  * c = intermittent lines  
  * s, S = stair steps  
  * h = vertical lines  
  * n = nothing   
* plot = we create a plot where we will add the lines  
* lines = lines to add to the created plot  







## Bar plots

## Pie charts

Don't do them! Use Bar plots instead. But if you really must know


# Others

## Box plots

### Normal box plot

### Notch plot

### Violin plots

## Density plots






