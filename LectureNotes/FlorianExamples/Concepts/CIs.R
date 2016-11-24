true = 0.35
x = rbinom(100,50, prob = true)
hist(x, main = "Observed survivors", breaks = 50)

hist(x/50, main = "Distribution of best estimates", breaks = 50)

plot(NULL, ylim = c(0,1), xlim = c(0,100))
abline(h=true)

for (i in 1:100){

  lines(c(i,i), as.vector(binom.test(x[i],50,p=0.2)$conf.int))
  
  
}


