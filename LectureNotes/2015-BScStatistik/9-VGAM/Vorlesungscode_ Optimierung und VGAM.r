schnapp <- read.table("schnaepper.txt")
attach(schnapp)
schnapp
m = 1
b = -log(2)
sum(dpois(stuecke, lambda=exp(m*attrakt + b), log=T))

#
dpois(stuecke, lambda=1)
plot(0:10, dpois(0:10, lambda=1), type="h", lwd=2)
points((0:10)+0.1, dpois(0:10, lambda=2), type="h", lwd=2, col="red")
abline(h=0.012)


b <- seq(0.1, 2, len=100)
m <- seq(0.01, 0.5, len=100)
llres <- matrix(NA, ncol=100, nrow=100)
for (i in 1:100){
  for (j in 1:100){
    llres[i, j] <- sum(dpois(stuecke, lambda=exp(m[j]*attrakt + b[i]), log=T))
    #print(j)
  }
  # print(paste("i:", i))
}
sum(dpois(stuecke, lambda=exp(m*attrakt + b), log=T))

image(llres)
persp(llres, phi=30, theta=90)
contour(b, m, llres, nlevels=50)
which(llres==max(llres), arr.ind=T)
b[73]; m[28]

coef(glm(stuecke ~ attrakt, poisson))



llfun <- function(parms){
  b <- parms[1]
  m <- parms[2]
  sum(dpois(stuecke, lambda=exp(m*attrakt + b), log=T))
}
llfun(c(1.4, 0.14))

ops <- optim(par=c(0,1), fn=llfun, control=list(fnscale=-1), hessian=T)
sqrt(diag(solve(-ops$hessian)))

summary(glm(stuecke ~ attrakt, poisson))


## Variation: nicht-lineare Regression:
library(nlstools)
data(vmkm)
attach(vmkm)
head(vmkm)
plot(v ~S)
# y = vmax*S/(Km+S)
jutta <- function(parms){
  vmax <- parms[1]
  Km <- parms[2]
  sigma <- parms[3]
  erwartet <- vmax*S/(Km+S)
  sum(dnorm(v, mean=erwartet, sd=exp(sigma), log=T))
}
jutta(c(1, 1.5, 1))
optim(par=c(1, 1.5, 1), fn=jutta, control=list(fnscale=-1))
curve(1.55*x/(2.59+x), add=T, lwd=2, col="blue")




library(VGAM)
summary(vglm(stuecke ~ attrakt, poissonff))
summary(vglm(stuecke ~ attrakt, negbinomial))
exp(71)
AIC(vglm(stuecke ~ attrakt, poissonff))
AIC(vglm(stuecke ~ attrakt, negbinomial))
