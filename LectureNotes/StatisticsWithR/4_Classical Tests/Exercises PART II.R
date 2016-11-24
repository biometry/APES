# Exercise # 1  -----------------------------------------------------------
#Import fallow.txt in R (make sure you write the script that sets the working directory 
#and import the file) 

# these are the weights (kg) of 85 male fallow deer from Israel and 100
# male fallow deer from Tuscany.

#All males have been weigthed the last days of August, all males are adult (age > 4 years old)

# You expect that males living in Israel (harsh mediterranean environment
#, less food available compared to Tuscany) 
# are lighter than males living in Tuscany. 

# Is this difference statistically significant?

# Solutions # 1 -----------------------------------------------------------
setwd("~/TEACHING IN FREIBURG/11 - Statistics with R fall 2015/4_Classical Tests")
fallow <- read.delim("fallow.txt")
attach(fallow)
boxplot(weight ~ studysite)
# these are 2 indipendent populations. so we likely need a t-test for independent samples
# the t test is one sided, because we a priori assume that deer in Israel are lighter. 
# however, are we allowed to run a t-test? 
qqnorm(weight[studysite=="Tuscany"])
qqline(weight[studysite=="Tuscany"])

qqnorm(weight[studysite=="Israel"])
qqline(weight[studysite=="Israel"])

shapiro.test(weight[studysite=="Tuscany"])
shapiro.test(weight[studysite=="Israel"])
# normality does not bother us TOO MUCH. However, we are clearly worried of different variance (spread) in the 2 populations. There is no chance we assume equal variances here.
library(car)
leveneTest(weight ~ studysite) #we reject equal variances
t.test(weight ~ studysite, mu=0 ,alt = "less", conf = 0.95, var.eq = F, paired = F)
# answer: fallow deer in Israel are significantly lighter than fallow deer in tuscany: T-test for indipendent samples, t = -6.8713, df = 103.824, p-value = 2.426e-10




# well, maybe you decided to go for a non-parametric test (although the 2 populations are normally distributed, so we can make assumptions about them, and we should go parametric) 
wilcox.test(weight ~ studysite, mu = 0, alt = "less", conf.int = T, conf.level = 0.95, paired = F,exact = F)
# if this is the case, fallow deer in Israel are significantly lighter than fallow deer in tuscany: Mann Whitney U test for indipendent samples, W = 1996, p-value = 2.676e-10
# however, such unequal variances could affect the Mann-Whitney U test as well. The T-test controlling for unequal variances is definitely preferred here.
#BETTER BEING A BIT WEEK ON THE NORMALITY SIDE THAN BEING VERY WEAK ON THE HETEROGENEITY SIDE.
detach(fallow)



