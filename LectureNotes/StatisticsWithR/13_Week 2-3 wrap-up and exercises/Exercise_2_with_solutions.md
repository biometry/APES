# Exercise 2

Questions / answers with no data analyses involved. 

You measure the number of deer crossing roads in the black forest. Actually, you have 15 random points located along different roads, you go there and count deer crossing at dawn from 4 am to 8 am. While you are there counting deer, you also measure traffic on these roads (number of cars per hour) and forest density along roads (number of trees per 100 meter of road).

Q1. You collected 3 variables. Correlation or causation?


```r
#Causation.
```


Q2. If causation, can you identify the response variable and 2 predictors?


```r
# Response: number of deer crossing
# Predictors: vehicle traffic and forest density

# Deer are supposed to avoid roads with heavy traffic, and maybe cross roads when they can get some protection from forest. You do not expect the opposite, i.e., for given a road and a given day, vehicle traffic would increase as there are less deer crossing it.  
```


Q3. what kind of statistical procedure would you fit to model the variability of the response variable?


```r
# Deer crossings are count data. 
# the starting model would be a glm with family = poisson
# glm(deer crossing ~ forest + traffic, family = poisson)

# regarding the model structure, I would start by including a quadratic effect for forest density and traffic, and an interaction forest*traffic as well. Model selection would tell us the final model structure. 
```






