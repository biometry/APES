library(locfit)
data(co2)
co2
co2$monthyear <- with(co2, year + month/12)

plot(co2 ~ monthyear, data=co2, type="l")





























flm <- lm(co2 ~ poly(month, 3) + year, data=co2)
summary(flm)
lines(co2$monthyear, predict(flm), col="red")


flm2 <- lm(co2 ~ poly(month, 3) + poly(year, 2), data=co2)
summary(flm2)
lines(co2$monthyear, predict(flm2), col="orange")

library(mgcv)
fgam <- gam(co2 ~ s(month, k=12, bs="cc") + s(year), data=co2)
summary(fgam)
lines(co2$monthyear, predict(fgam), col="green")

residsgam <- predict(fgam, newdata=data.frame("month"=co2$month, "year"=1975))
co2$co2residuals <- as.vector(co2$co2 - residsgam)

# start over with data corrected for seasonal effect:
plot(co2residuals ~ monthyear, data=co2, type="l")

flm <- lm(co2residuals ~ monthyear, data=co2)
summary(flm)
lines(co2$monthyear, predict(flm), col="red")

flm2 <- lm(co2residuals ~ poly(monthyear, 2), data=co2) # oder 3 virtually identical
summary(flm2)
lines(co2$monthyear, predict(flm2), col="orange")

fgam <- gam(co2residuals ~ s(monthyear), data=co2) 
summary(fgam)
lines(co2$monthyear, predict(fgam), col="green") # same as poly 2

library(segmented)
fsegreg <- segreg(co2residuals ~ seg(monthyear, npsi=1), data=co2)
summary(fsegreg)
lines(co2$monthyear, predict(fsegreg), col="blue")

fsegreg2 <- segreg(co2residuals ~ seg(monthyear, npsi=2), data=co2)
summary(fsegreg2)
lines(co2$monthyear, predict(fsegreg2), col="pink", lwd=3)

library(rpart)
fr <- rpart(co2residuals ~ monthyear, data=co2, cp=.7) 
fr
lines(co2$monthyear, predict(fr), col="green", lwd=3)



# example from here:
# https://stackoverflow.com/questions/14337439/piece-wise-linear-and-non-linear-regression-in-r

x<-c(1e-08, 1.1e-08, 1.2e-08, 1.3e-08, 1.4e-08, 1.6e-08, 1.7e-08, 
     1.9e-08, 2.1e-08, 2.3e-08, 2.6e-08, 2.8e-08, 3.1e-08, 3.5e-08, 
     4.2e-08, 4.7e-08, 5.2e-08, 5.8e-08, 6.4e-08, 7.1e-08, 7.9e-08, 
     8.8e-08, 9.8e-08, 1.1e-07, 1.23e-07, 1.38e-07, 1.55e-07, 1.76e-07, 
     1.98e-07, 2.26e-07, 2.58e-07, 2.95e-07, 3.25e-07, 3.75e-07, 4.25e-07, 
     4.75e-07, 5.4e-07, 6.15e-07, 6.75e-07, 7.5e-07, 9e-07, 1.15e-06, 
     1.45e-06, 1.8e-06, 2.25e-06, 2.75e-06, 3.25e-06, 3.75e-06, 4.5e-06, 
     5.75e-06, 7e-06, 8e-06, 9.25e-06, 1.125e-05, 1.375e-05, 1.625e-05, 
     1.875e-05, 2.25e-05, 2.75e-05, 3.1e-05)

y<-c(-0.169718017273307, 7.28508517630734, 71.6802510299446, 164.637259265704, 
      322.02901173786, 522.719633360006, 631.977073772459, 792.321270345847, 
      971.810607095548, 1132.27551798986, 1321.01923840546, 1445.33152600664, 
      1568.14204073109, 1724.30089942149, 1866.79717333592, 1960.12465709003, 
      2028.46548012508, 2103.16027631327, 2184.10965255236, 2297.53360080873, 
      2406.98288043262, 2502.95194879366, 2565.31085776325, 2542.7485752473, 
      2499.42610084412, 2257.31567571328, 2150.92120390084, 1998.13356362596, 
      1990.25434682546, 2101.21333152526, 2211.08405955931, 1335.27559108724, 
      381.326449703455, 430.9020598199, 291.370887491989, 219.580548355043, 
      238.708972427248, 175.583544448326, 106.057481792519, 59.8876372379487, 
      26.965143266819, 10.2965349811467, 5.07812046132922, 3.19125838983254, 
      0.788251933518549, 1.67980552001939, 1.97695007279929, 0.770663673279958, 
      0.209216903989619, 0.0117903221723813, 0.000974437796492681, 
      0.000668823762763647, 0.000545308757270207, 0.000490042305650751, 
      0.000468780182460397, 0.000322977916070751, 0.000195423690538495, 
      0.000175847622407421, 0.000135771259866332, 9.15607623591363e-05)

plot(log(x), y, ylim=c(0, 2800))
fgam <- gam(y ~ s(log(x)))
summary(fgam)
lines(log(x), predict(fgam))

fseg <- segreg(y ~ seg(log(x), npsi=2))
summary(fseg)
slope(fseg)
lines(log(x), predict(fseg), col="green")




data(mcycle)
plot(mcycle)
head(mcycle)
frm <- rpart(accel ~ times, data=mcycle)
lines(mcycle$times, predict(frm))

fgamm <- gam(accel ~ s(times), data=mcycle)
lines(mcycle$times, predict(fgamm), col="red")

fsegm <- segreg(accel ~ seg(times, npsi=4), data=mcycle)
lines(mcycle$times, predict(fsegm), col="green", lwd=2)
