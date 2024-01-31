library(faraway)
data(wcgs)
head(wcgs)


fm <- glm(chd ~ age * height  + I(height^2) + weight + sdp + dbp + chol + behave + cigs, family=binomial, data=wcgs)
summary(fm)
anova(fm)

library(ranger)
fr <- ranger(chd ~ ., data=na.omit(wcgs[, -c(11, 12)]), importance="impurity", keep.inbag=T, probability=T)
sort(ranger::importance(fr), decreasing=T)


library(vivid)
viviRf  <- vivi(fit = fr, 
                data = na.omit(wcgs[, -c(11, 12)]), 
                response = "chd",
                gridSize = 50,
                importanceType = "agnostic",
                nmax = 500,
                reorder = TRUE,
                predictFun = NULL,
                numPerm = 4,
                showVimpError = FALSE)

viviHeatmap(mat=viviRf)

top5 <- colnames(viviRf)[1:5]
pdpVars(data = na.omit(wcgs),
        fit = fr,
        response = 'chd',
        vars = top5,
        nIce = 100,
        probability=T)



library(vip)
(firm <- vi_firm(fr, train=na.omit(wcgs[, -c(11, 12)])))

(shap <- vi_shap(fr, 
                 train=na.omit(wcgs[, -c(11, 12)]), 
                 pred_wrapper=function(object, newdata) ranger:::predict.ranger
                          (object=object, data=newdata)$prediction[,2]))

cor(firm[,2], shap[,2])


library(pdp)
?pdp
pd <- partial(fr, pred.var=c("chol", "age"), grid.resolution=20)
plotPartial(pd)
