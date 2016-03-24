# Changing the look of your plots

## Changing the look of plots

```r
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/2_intro to very basic exploratory statistics")
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

```r
attach(data1)
```

chr size adjustements

```r
plot(Age, Height,main="My scatterplot")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-2-1.png) 

```r
#cex changes the size of plotting characters
plot(Age, Height,main="My scatterplot",cex=0.5) #half of size
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-2-2.png) 

```r
#cex.main adjusts the size of title
plot(Age, Height,main="My scatterplot",cex=0.5,cex.main=0.8)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-2-3.png) 

```r
#cex.lab for the size of axis lables
plot(Age, Height,main="My scatterplot",cex=0.5,cex.main=0.8,cex.lab=1.2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-2-4.png) 

```r
#size of x/y axis value cex.axis
plot(Age, Height,main="My scatterplot",cex=0.5,cex.main=0.8,cex.lab=1.2,cex.axis=1.2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-2-5.png) 

fonts adjustments

```r
plot(Age, Height,main="My scatterplot")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-3-1.png) 

```r
#font.main  (3 = italic; 4 = bold italic)
plot(Age, Height,main="My scatterplot",font.main=3)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-3-2.png) 

```r
plot(Age, Height,main="My scatterplot",font.main=4)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-3-3.png) 

```r
#font.lab
plot(Age, Height,main="My scatterplot",font.main=4,font.lab=2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-3-4.png) 

```r
#font.axis
plot(Age, Height,main="My scatterplot",font.main=4,font.lab=2, font.axis=2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-3-5.png) 

# changing colours

```r
plot(Age, Height,main="My scatterplot")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-1.png) 

```r
#col
plot(Age, Height,main="My scatterplot",col="red")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-2.png) 

```r
plot(Age, Height,main="My scatterplot",col="red",col.main="blue")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-3.png) 

```r
plot(Age, Height,main="My scatterplot",col="red",col.main="blue", col.axis=12)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-4.png) 

```r
plot(Age, Height,main="My scatterplot",col="red",col.main="blue", col.axis=12,col.lab="violet")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-5.png) 

```r
plot(Age, Height,main="My scatterplot",col="red",col.main="blue", col.axis=12,col.lab="violet")

x=1:25
plot(x,col=x,cex=2.5)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-4-6.png) 

# changing plotting chrs plus changing the look of the regression line

```r
plot(Age, Height,main="My scatterplot",pch=2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-5-1.png) 

```r
plot(Age, Height,main="My scatterplot",pch=4)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-5-2.png) 

```r
plot(Age, Height,main="My scatterplot",pch="w")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-5-3.png) 

```r
plot(Age, Height,main="My scatterplot",pch="a",cex=0.5)
 
abline(lm(Height~Age))
abline(lm(Height~Age),col="red",lty=3,lwd=5)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-5-4.png) 



```r
plot(Age[Gender == "male"],Height[Gender == "male"], col = 4, pch = "m",xlab = "Age",ylab = "Height",cex = 0.5,main = "Height vs Age")

#add females
points(Age[Gender == "female"],Height[Gender == "female"],col = 2, pch = "f",cex = 1.2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-6-1.png) 

```r
#we may want males and females appearing in different plots
par(mfrow=c(1,2)) #1 row, 2 columns

plot(Age[Gender=="male"],Height[Gender=="male"], col=4, pch="m",xlab="Age",ylab="Height",cex=0.5,main="Height vs Age for males",xlim=c(0,20), ylim=c(45,85))

plot(Age[Gender=="female"],Height[Gender=="female"], col=6, pch="f",xlab="Age",ylab="Height",cex=0.5,main="Height vs Age for females",xlim=c(0,20), ylim=c(45,85))
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-6-2.png) 

```r
par(mfrow=c(1,1)) #back to one plot / screen
```


#changing x y axis

```r
plot(Age, Height,main="My scatterplot")
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-7-1.png) 

```r
plot(Age, Height,main="My scatterplot",axes =F)
axis(side=1,at=c(7,12.3,15),labels=c("sev","mean","15"))
axis(side=2,at=c(55,65,75),labels=c(55,65,75))
box()

axis(side=4,at=c(50,60,70,80),labels=c(50,60,70,80),las=1)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-7-2.png) 

you may want to change the size of the margins, text allignement, explore ?par

## adding text to plots

text and mtext commands: explore them with the ?

```r
plot(Age, Musclemass,main="My scatterplot",las=1)
#Pearson
cor(Age,Musclemass)
```

```
## [1] 0.8196749
```

```r
plot(Age, Musclemass,main="My scatterplot",las=1)
text(x=5,y=13,label="r = 0.82",col=2) #text centered in 5,13
text(x=5,y=13,label="r = 0.82",col=2,adj=0) #text start @ 5,13.
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-8-1.png) 


```r
plot(Age, Musclemass,main="My scatterplot",las=1)
text(x=5,y=13,label="r = 0.82",col=4,cex=1.5,font=4)

#add line
abline(h=mean(Musclemass),col=2,lwd=4,lty=3)
text(2.5,8.5,adj=0,label="mean Musclemass",cex=0.7,col=2)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-9-1.png) 

add text @ the margins of the plot

```r
plot(Age, Musclemass,main="My scatterplot",las=1)
mtext(text ="r = 0.82",side=1)
mtext(text ="r = 0.82",side=3)
mtext(text ="r = 0.82",side=4)
mtext(text ="r = 0.82",side=1,adj=1)
mtext(text ="r = 0.82",side=1,adj=0.3)

mtext(text ="r = 0.82",side=3,adj=0.3,col=2,cex=2,font=4)
```

![](2_changing_the_look_of_your_plots_files/figure-html/unnamed-chunk-10-1.png) 



+++++++++++++++++
Edited by Simone Ciuti, University of Freiburg, 15/10/2015; 
Intended for the only purpose of teaching @ Freiburg University
source: Mike Marin Stat Tutorials, University of British Columbia (strongly edited and modified)
+++++++++++++++++++++++++++++++++++++++++++++++++
