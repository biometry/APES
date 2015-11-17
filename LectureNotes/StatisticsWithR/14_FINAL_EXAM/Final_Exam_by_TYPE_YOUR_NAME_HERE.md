# FINAL EXAM - TYPE YOUR NAME HERE

Set your working directory here

```r
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/14_FINAL_EXAM")
```








## Exercise 1 - Fungi yields in 4 habitat types

Load Fungi.txt


These data are from a researcher who measured yield in 40 fungi randomly selected in 4 different habitat types. Habitat types have been defined based on the main tree species occurring within a 10 meter buffer around the sampled fungi. 
Based on these info, which variable is depedent and which one is independent?




Plot the data in a meaningful way (putting the response variable on the y-axis). 
Fit the proper statistical procedure to test the effect of the response variable on the indipendent one.
Verify whether you meet the assumptions of the statistical procedure you use. 
Briefly describe your final results.













## Exercise 2 - Daphnia dataset
Data from a freshwater experiment carried out in the lab.
Growth rate measured in the lab on 36 daphnia sampled from 2 rivers of England (Tyne river and Wear river). The researcher who took the measurements wants to know whether Daphnia growth rate differs depending on which river they come from. 

Load the data, make a proper plot depicting the experiment, fit a statistical procedure and breifly describe your final results to the researcher. 



```r
daphnia <- read.delim("daphnia.txt")
head(daphnia)
```

```
##   Growth.rate Water
## 1    2.919086  Tyne
## 2    2.492904  Tyne
## 3    3.021804  Tyne
## 4    2.350874  Tyne
## 5    3.148174  Tyne
## 6    4.423853  Tyne
```















## Exercise 3 - Mule Deer population survey from North Dakota badlands, USA (part I)

Load the file Mule Deer.txt

```r
MD <- read.delim("Mule Deer.txt")
```

Data details:

1) study_site: 51 survey units spread across SW North Dakota. The size of each site is the same (50 km2).

2) md_spring: number of mule deer counted in spring.

3) md_fall: number of mule deer counted in fall.

4) fall_recruit: number of fawns per female (ratio) recorded in fall. 

5) coyote_density: number of coyotes per 100 km2 (ratio) recorded in spring.            

In simple words, researchers collected data on population size (md_spring) and predator presence (coyote_density) during the spring, then they collected population size (md_fall) and recruitment (fall_recruit) in the fall (autumn). 

Additionally, during the winter prior to the spring survey, the researcher gathered weather data that are proxies of winter severity

6) WSI: winter severity index.                     
7) Average_preci_winter (precipitation)     
8) Average_snowfall_winter  
9) Average_snowdepth_winter
10) Average_maxtemp_winter   
11) Average_mintemp_winter   
12) Average_NP_winter (north pacific index)       
13) Average_PDO_winter (pacific decadal oscillation)      
14) Average_MEI_winter (el nino multivariate index)    

Now. 
Reclassify study sites based on coyote density. In practice, add a column 'coyote' and assign 'low' to coyote densities lower than the median of coyote density, while assign 'high' to coyote densities equal or higher than the median of coyote density. Whatever procedure you use to get the new column 'coyote', make sure that eventually it is a factor column.

Make a plot of fall_recruit depending on Average_mintemp_winter. Data points should look different depending on the value of the column 'coyote', meaning that in the given study site - depending on the colour - there is a high or low coyote density. Add 2 linear fits to the plotted relationship: one for low coyote densities and one for high coyote densities. Include a proper legend 




Fit a simple linear model taking the following structure: 

fall_recruit ~ (md_spring + Average_mintemp_winter + coyote_density)^2 + I(md_spring^2) + I(Average_mintemp_winter^2) + I(coyote_density^2)

Select the best model structure using the step function. 
Plot the effects of the best model using the library effects.
What is your interpretation of the interaction term in this model?
Does the best model meet the assumptions of linear models?















## Exercise 4 - Mule Deer population survey from North Dakota badlands, USA (part II)

Same MD dataset introduced in exercise 3.

Response variable: fall_recruit.
All the others: potential predictors. 

Check and test for collinearity in the predictors.




Run a Principal Component Analysis for the winter weather predictors:
["WSI", "Average_preci_winter", "Average_snowfall_winter", "Average_snowdepth_winter", "Average_maxtemp_winter", "Average_mintemp_winter"]


What variables have positive loadings on the first axis (PC1), and which ones negative loadings?

How many PC axes you would need to explain at least 90% of the variability of these 6 winter weather predictors? 

Add 2 columns to the MD dataset corresponding to the values of the first and the second axes (PC1 and PC2).












## Exercise 5 - Mule Deer population survey from North Dakota badlands, USA (part III) 
Same dataset introduced in exercise 3. MD


Response variable: md_fall (population size in autumn).

Predictors: coyote_density, Average_mintemp_winter.


Fit the proper model to explain the variability of population size in autumn (number of mule deer counted in autumn) with the 2 predictors provided. Include quadratic effects and interactions. Use the dredge from MuMIn to select the best model.




Does this model have problems? do we meet the assumptions?







## Exercise 6 - Students' awards (OPTIONAL)

Our response variable here is the number of awards earned by students at one high school. Predictors of the number of awards earned include the type of program (prog) in which the student was enrolled (e.g., vocational, general or academic: prog is a categorical predictor variable with three levels indicating the type of program in which the students were enrolled) and the score on their final exam in math.

Run the script to get the data.


```r
load("p.RData")
head(p)
```

```
##    id num_awards prog math
## 1  45          0    3   41
## 2 108          0    1   41
## 3  15          0    3   44
## 4  67          0    3   42
## 5 153          0    3   40
## 6  51          0    1   42
```

```r
p$id = factor(p$id)
p$prog = factor(p$prog, levels=1:3, labels=c("General", "Academic", "Vocational"))
head(p)
```

```
##    id num_awards       prog math
## 1  45          0 Vocational   41
## 2 108          0    General   41
## 3  15          0 Vocational   44
## 4  67          0 Vocational   42
## 5 153          0 Vocational   40
## 6  51          0    General   42
```

```r
summary(p)
```

```
##        id        num_awards           prog          math      
##  1      :  1   Min.   :0.00   General   : 45   Min.   :33.00  
##  2      :  1   1st Qu.:0.00   Academic  :105   1st Qu.:45.00  
##  3      :  1   Median :0.00   Vocational: 50   Median :52.00  
##  4      :  1   Mean   :0.63                    Mean   :52.65  
##  5      :  1   3rd Qu.:1.00                    3rd Qu.:59.00  
##  6      :  1   Max.   :6.00                    Max.   :75.00  
##  (Other):194
```

Plot the data and fit the proper model with prog, math, and the interaction prog*math as predictors and num_awards as response variable. Based on a backward stepwise selection procedure, remove model terms accordingly. 
Do you meet model assumptions?




what is the amount of variability explained by this model?



Plot maually the predictions of the model. 
math score on the x-axis, number of awards on the y axis, and predictions for the 3 different programs.




Briefly explain your final results. 



















