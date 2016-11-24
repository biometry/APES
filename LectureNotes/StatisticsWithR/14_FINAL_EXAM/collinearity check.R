#Library files for courses provided by: Highland Statistics Ltd.
#To cite these functions, use:
#Mixed effects models and extensions in ecology with R. (2009).
#Zuur, AF, Ieno, EN, Walker, N, Saveliev, AA, and Smith, GM. Springer.

#Copyright Highland Statistics LTD.

#####################################################################
#VIF FUNCTION.
#To use:  corvif(YourDataFile)
corvif <- function(dataz) {
  dataz <- as.data.frame(dataz)
  #correlation part
  #cat("Correlations of the variables\n\n")
  #tmp_cor <- cor(dataz,use="complete.obs")
  #print(tmp_cor)
  
  #vif part
  form    <- formula(paste("fooy ~ ",paste(strsplit(names(dataz)," "),collapse=" + ")))
  dataz   <- data.frame(fooy=1,dataz)
  lm_mod  <- lm(form,dataz)
  
  cat("\n\nVariance inflation factors\n\n")
  print(myvif(lm_mod))
}


#Support function for corvif. Will not be called by the user
myvif <- function(mod) {
  v <- vcov(mod)
  assign <- attributes(model.matrix(mod))$assign
  if (names(coefficients(mod)[1]) == "(Intercept)") {
    v <- v[-1, -1]
    assign <- assign[-1]
  } else warning("No intercept: vifs may not be sensible.")
  terms <- labels(terms(mod))
  n.terms <- length(terms)
  if (n.terms < 2) stop("The model contains fewer than 2 terms")
  if (length(assign) > dim(v)[1] ) {
    diag(tmp_cor)<-0
    if (any(tmp_cor==1.0)){
      return("Sample size is too small, 100% collinearity is present")
    } else {
      return("Sample size is too small")
    }
  }
  R <- cov2cor(v)
  detR <- det(R)
  result <- matrix(0, n.terms, 3)
  rownames(result) <- terms
  colnames(result) <- c("GVIF", "Df", "GVIF^(1/2Df)")
  for (term in 1:n.terms) {
    subs <- which(assign == term)
    result[term, 1] <- det(as.matrix(R[subs, subs])) * det(as.matrix(R[-subs, -subs])) / detR
    result[term, 2] <- length(subs)
  }
  if (all(result[, 2] == 1)) {
    result <- data.frame(GVIF=result[, 1])
  } else {
    result[, 3] <- result[, 1]^(1/(2 * result[, 2]))
  }
  invisible(result)
}
#END VIF FUNCTIONS





##################################################################
##################################################################
#Here are some functions that we took from the pairs help file and
#modified, or wrote ourselves. To cite these, use the r citation: citation()

panel.cor <- function(x, y, digits=1, prefix="", cex.cor = 6)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r1=cor(x,y,use="pairwise.complete.obs")
  r <- abs(cor(x, y,use="pairwise.complete.obs"))
  txt <- format(c(r1, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) { cex <- 0.9/strwidth(txt) } else {
    cex = cex.cor}
  text(0.5, 0.5, txt, cex = cex * r)
}

##################################################################
panel.smooth2=function (x, y, col = par("col"), bg = NA, pch = par("pch"),
                        cex = 1, col.smooth = "black", span = 2/3, iter = 3, ...)
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok))
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter),
          col = 1, ...)
}

##################################################################
panel.lines2=function (x, y, col = par("col"), bg = NA, pch = par("pch"),
                       cex = 1, ...)
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)){
    tmp=lm(y[ok]~x[ok])
    abline(tmp)}
}

##################################################################
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="white", ...)
}
##################################################################
##################################################################



##################################################################
##################################################################
#Functions for variograms
#To cite these functions, use:
#Mixed effects models and extensions in ecology with R. (2009).
#Zuur, AF, Ieno, EN, Walker, N, Saveliev, AA, and Smith, GM. Springer.
#Make a variogram for one variable
#To use, type:  MyVariogram(XUTM, YUTM, E , MyDistance=10)
# XUTM is x coordinates
# XUTM is y coordinates
# E is variable used in sample variogram
# MyDistance is the cutoff value for the distances

MyVariogram <- function(x,y,z, MyDistance) {
  library(gstat)
  mydata      <- data.frame(z, x, y)
  coordinates(mydata)    <- c("x", "y")  
  Var <- variogram(z ~ 1, mydata, cutoff = MyDistance)
  data.frame(Var$np, Var$dist, Var$gamma)
}

#Function for making multiple variograms in an xyplot
#To use, type:  MultiVariogram(Z, MyVar,XUTM, YUTM, MyDistance=10)
# Z is a data frame with all the data 
# Character string with variable names that will be used in the xyplot
# XUTM is x coordinates
# XUTM is y coordinates
# MyDistance is the cutoff value for the distances

MultiVariogram <- function(Z, MyVar, x, y, MyDistance) {
  #Z is the data frame with data
  #MyVar is a list of variables for for which variograms are calculated
  #x, y: spatial coordinates
  #MyDistance: limit for distances in the variogram
  
  library(lattice)
  VarAll<- c(NA,NA,NA,NA)
  for (i in MyVar){
    vi <- MyVariogram(x,y,Z[,i], MyDistance)
    vii <- cbind(vi, i)
    VarAll <- rbind(VarAll,vii)
  }
  VarAll <- VarAll[-1,]
  
  P <- xyplot(Var.gamma ~ Var.dist | factor(i), col = 1, type = "p", pch = 16,
              data = VarAll,
              xlab = "Distance",
              ylab = "Semi-variogram",
              strip = function(bg='white', ...)
                strip.default(bg='white', ...),
              scales = list(alternating = T,
                            x = list(relation = "same"),
                            y = list(relation = "same"))
  )
  
  print(P)
}
#End variogram code
##########################################################
