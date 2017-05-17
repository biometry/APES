stepAIC <- function (object, scope, scale = 0, direction = c("both", "backward", "forward"), trace = 1, steps = 1000, use.start = FALSE, k =2, bandwidth = 10, marginal = NULL, AICc = TRUE, delta = 2, joint =
NULL, positive.definite = FALSE, ...){
	# https://stat.ethz.ch/pipermail/r-help/2009-April/196918.html
	# by Thierry ONKELINX
    mydeviance <- function(x, ...) {
        dev <- deviance(x)
        if (!is.null(dev)){
            dev
        } else {
            extractAIC(x, k = 0)[2]
        }
    }
    cut.string <- function(string) {
        if (length(string) > 1){
            string[-1] <- paste("\n", string[-1], sep = "")
        }
        string
    }
    Terms <- terms(object)
    object$formula <- Terms
    if (inherits(object, "lme")){
        object$call$fixed <- Terms
    } else {
        if (inherits(object, "gls")){
            object$call$model <- Terms
        } else {
            object$call$formula <- Terms
        }
    }
    if (use.start){
        warning("'use.start' cannot be used with R's version of glm")
    }
    md <- missing(direction)
    direction <- match.arg(direction)
    backward <- direction == "both" | direction == "backward"
    forward <- direction == "both" | direction == "forward"
    if (missing(scope)) {
        fdrop <- numeric(0)
        fadd <- attr(Terms, "factors")
        if (md){
            forward <- FALSE
        }
    } else {
        if (is.list(scope)) {
            if(!is.null(fdrop <- scope$lower)){
                fdrop <- attr(terms(update.formula(object, fdrop)),
"factors")
                colnames(fdrop) <- sapply(strsplit(colnames(fdrop), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":"))
                fdrop <- fdrop[, order(colnames(fdrop))]
            } else {
              fdrop <- numeric(0)
            }
            if (!is.null(fadd <- scope$upper)){
                fadd <- attr(terms(update.formula(object, fadd)),
"factors")
                colnames(fadd) <- sapply(strsplit(colnames(fadd), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":"))
                fadd <- fadd[, order(colnames(fadd))]
            }
        } else {
            if (!is.null(fadd <- scope)){
                fadd <- attr(terms(update.formula(object, scope)),
"factors")
                colnames(fadd) <- sapply(strsplit(colnames(fadd), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":"))
                fadd <- fadd[, order(colnames(fadd))]
            }
            fdrop <- numeric(0)
        }
    }
    models <- vector("list", steps)
    if (is.list(object) && (nmm <- match("nobs", names(object), 0)) > 0)
{
        n <- object[[nmm]]
    } else {
        n <- length(residuals(object))
    }
    fit <- object
	bAIC <- extractAIC(fit, scale, k = k, ...)
#	bAIC <- extractAIC(fit, scale, k = k)
	edf <- bAIC[1]
    if(AICc){
        bAIC <- bAIC[2] + (2 * edf + (edf * 1)) / (n - edf - 1)
    } else {
        bAIC <- bAIC[2]
    }
    if (is.na(bAIC)){
        stop("AIC is not defined for this model, so stepAIC cannot
proceed")
    }
    Terms <- terms(fit)
# reorder the covariates in alphabetical order
    response <- as.list(attr(Terms, "variables"))[[attr(Terms,
"response") + 1]]
    if(length(attr(Terms, "factors")) > 0){
        fixed <- sort(sapply(strsplit(colnames(attr(Terms, "factors")),
":", fixed = TRUE), function(x) paste(sort(x), collapse = ":")))
        fixed <- paste(c(rownames(attr(Terms, "factors"))[attr(Terms,
"offset")], fixed), collapse = " + ")
        fit <- update(fit, as.formula(paste(response, fixed, sep = " ~
")), evaluate = FALSE)
        fit <- eval.parent(fit)
    } else {
        fixed <- "1"
    }
    Terms <- terms(fit)
    nm <- 1
#append the basic model to the list of the results
    models[[nm]] <- list(deviance = mydeviance(fit), df.resid = n - edf,
AIC = bAIC, formula = paste(response, fixed, sep = " ~ "), expanded =
FALSE, object = fit)
    bestAIC <- bAIC
    selection <- 1
    while (nm < steps & length(selection) > 0) {
#create a list of formulas which have to be expanded
        formulas <- sapply(models[selection], function(x){x$formula})
#create a vector with AIC values of the model to be expanded.
        cAIC <- sapply(models[selection], function(x){x$AIC})
        if(trace >= 1){
            cat("\n")
            cat(nm, "models tested.\n")
            if(length(cAIC) > 1){
                cat(length(cAIC), "models to expand. AIC range:",
round(range(cAIC[is.finite(cAIC)], na.rm = TRUE), 3), "\n\n")
            } else {
                cat("1 model to expand.\n\n")
            }
        }
#set the expanded flag on the models selected to expand
        models[selection] <- lapply(models[selection], function(x){
            x$expanded <- TRUE
            if(is.infinite(x$AIC)){
                x$AIC <- NA
            }
            x
        })
#expand each selected model
        for(i in seq_along(formulas)){
            form <- formulas[i]
            if(trace >= 2){
                cat("Expand model", i, "\n",
cut.string(deparse(as.vector(formula(form)))), "\nAIC:",
round(cAIC[[i]], 3), " Best AIC:", round(bestAIC, 3), "AIC range:",
round(range(cAIC[is.finite(cAIC)], na.rm = TRUE), 3), "\n\n")
                utils::flush.console()
            }
#select the terms which can be added of dropped
            Terms <- terms(as.formula(form))
            ffac <- attr(Terms, "factors")
            if (!is.null(sp <- attr(Terms, "specials")) && !is.null(st
<- sp$strata)){
                ffac <- ffac[-st, ]
            }
            scope <- factor.scope(ffac, list(add = fadd, drop = fdrop),
marginal = marginal, joint = joint)
#to backward selection
            if (backward && length(scope$drop)) {
#create all formulas of smaller models
                rhs <- sapply(scope$drop, function(x){
                    newForm <- update.formula(form, as.formula(paste(".
~ . ", x, sep = "-")))
					if(length(attr(terms(newForm),
"factors")) == 0){
						paste(response,
paste(c(rownames(attr(Terms, "factors"))[attr(Terms, "offset")], 1),
collapse = " + "), sep = " ~ ")
					} else {
	                    if(ncol(attr(terms(newForm), "factors")) >
1){
	                        fixed <-
paste(sort(sapply(strsplit(colnames(attr(terms(newForm), "factors")),
":", fixed = TRUE), function(x) paste(sort(x), collapse = ":"))),
collapse = " + ")
	                        paste(response,
paste(c(rownames(attr(Terms, "factors"))[attr(Terms, "offset")], fixed),
collapse = " + "), sep = " ~ ")
	                    } else {
	                        paste(response,
paste(c(rownames(attr(Terms, "factors"))[attr(Terms, "offset")], 1),
collapse = " + "), sep = " ~ ")
	                    }
					}
                })
#ignor smaller models which have allready been calculated
                scope$drop <- scope$drop[sapply(rhs, function(rhst){
                    all(sapply(models[seq_len(nm)], function(x){
                        x$formula != rhst
                    }))
                })]
#drop all suitable terms one by one
                if(all(!is.na(scope$drop)) & length(scope$drop)){
                    for(sdrop in scope$drop){
                        newForm <- update.formula(form,
as.formula(paste(". ~ . ", sdrop, sep = "-")))
                        newObject <- update(fit, newForm, evaluate =
FALSE)
                        newObject <- try(eval.parent(newObject))
#check if the model gave an error or not
                        if(class(newObject) != "try-error"){
                            bAIC <- extractAIC(newObject, scale, k = k,
...)
#                            bAIC <- extractAIC(newObject, scale, k = k)
                            edf <- bAIC[1]
                            if(AICc){
                                bAIC <- bAIC[2] + (2 * edf + (edf * 1)) / (n - edf - 1)
                            } else {
                                bAIC <- bAIC[2]
                            }
                            deviance <- mydeviance(newObject)
                            if(positive.definite &&
class(try(intervals(newObject))) == "try-error"){
                                bAIC <- ifelse(is.infinite(cAIC[i]), NA,
-Inf)
                            } else {                           
                                if(bestAIC > bAIC){
                                    bestAIC <- bAIC
                                }
                            }
                        } else {
#set the AIC temporary to -Inf if the model gave an error. This will be reset later on to NA. It is set to -Inf so the model will have the lowest AIC and will be expanded.
                            edf <- n
                            bAIC <- ifelse(is.infinite(cAIC[i]), NA,
-Inf)
                            newObject <- NULL
                            deviance <- NA
                        }
                        if(ncol(attr(terms(newForm), "factors")) > 1){
#sort the terms in the model alphabetical or make the NULL model
                            newFixed <-
sort(sapply(strsplit(colnames(attr(terms(newForm), "factors")), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":")))
                            newFixed <- paste(c(rownames(attr(Terms,
"factors"))[attr(Terms, "offset")], newFixed), collapse = " + ")
                            expanded <- FALSE
                        } else {
                            newFixed <- paste(c(rownames(attr(Terms,
"factors"))[attr(Terms, "offset")], 1), collapse = " + ")
                            expanded <- TRUE
                            bAIC <- ifelse(is.infinite(bAIC), NA, bAIC)
                        }
                        nm <- nm + 1
                        models[[nm]] <- list(deviance = deviance,
df.resid = n - edf, AIC = bAIC, formula = paste(response,
paste(newFixed, collapse = " + "), sep = " ~ "), expanded = expanded,
object = newObject)
                        if(trace >= 3){
                            cat("Model", nm, "Drop: ", sdrop, "\n",
cut.string(deparse(as.vector(as.formula(paste(response, newFixed, sep =
" ~ "))))), "\nAIC: ", round(bAIC, 3), " Best AIC: ", round(bestAIC, 3),
"\n\n")
                            utils::flush.console()
                        }
                    }
                }
            }
            if (forward && length(scope$add)) {
                rhs <- sapply(scope$add, function(x){
                    selection <- which(colnames(attr(Terms, "factors"))
== x)
                    fixed <-
paste(sort(sapply(strsplit(c(colnames(attr(Terms, "factors")), x), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":"))), collapse =
" + ")
                    paste(response, paste(c(rownames(attr(Terms,
"factors"))[attr(Terms, "offset")], fixed), collapse = " + "), sep = " ~
")
                })
                scope$add <- scope$add[sapply(rhs, function(rhst){
                    all(sapply(models[seq_len(nm)], function(x){
                        x$formula != rhst
                    }))
                })]
                if(all(!is.na(scope$add)) & length(scope$add)){
                    for(sadd in scope$add){
                        newForm <- update.formula(form,
as.formula(paste(". ~ . ", sadd, sep = "+")))
                        newObject <- update(fit, newForm, evaluate =
FALSE)
                        newObject <- try(eval.parent(newObject))
                        if(class(newObject) != "try-error"){
                            bAIC <- extractAIC(newObject, scale, k = k,
...)
#                            bAIC <- extractAIC(newObject, scale, k = k)
                            edf <- bAIC[1]
                            if(AICc){
                                bAIC <- bAIC[2] + (2 * edf + (edf * 1)) / (n - edf - 1)
                            } else {
                                bAIC <- bAIC[2]
                            }
                            deviance <- mydeviance(newObject)
                            if(positive.definite &&
class(try(intervals(newObject))) == "try-error"){
                                bAIC <- ifelse(is.infinite(cAIC[i]), NA,
-Inf)
                            } else {                           
                                if(bestAIC > bAIC){
                                    bestAIC <- bAIC
                                }
                            }
                        } else {
                            edf <- NA
                            deviance <- NA
                            bAIC <- ifelse(is.infinite(cAIC[i]), NA,
-Inf)
                            newObject <- NULL
                        }
                        newFixed <-
sort(sapply(strsplit(colnames(attr(terms(newForm), "factors")), ":",
fixed = TRUE), function(x) paste(sort(x), collapse = ":")))
                        newFixed <- paste(c(rownames(attr(terms(fit),
"factors"))[attr(terms(fit), "offset")], newFixed), collapse = " + ")
                        nm <- nm + 1
                        models[[nm]] <- list(deviance = deviance,
df.resid = n - edf, AIC = bAIC, formula = paste(response, newFixed, sep
= " ~ "), expanded = FALSE, object = newObject)
                        if(trace >= 3){
                            cat("Model", nm, "Add: ", sadd, "\n",
cut.string(deparse(as.vector(as.formula(paste(response, newFixed, sep =
" ~ "))))), "\nAIC: ", round(bAIC, 3), " Best AIC: ", round(bestAIC, 3),
"\n\n")
                            utils::flush.console()
                        }
                    }
                }
            }
        }
        models[seq_len(nm)] <-
models[seq_len(nm)][order(sapply(models[seq_len(nm)],
function(x){x$AIC}))]
        selection <- which(sapply(models[seq_len(nm)], function(x){
            (x$AIC - bestAIC < delta) | is.infinite(x$AIC)
        }) == TRUE)
        if(length(selection) < bandwidth){
            selection <- seq_len(min(c(nm, bandwidth)))
        }
        unselect <- seq_len(nm)[!seq_len(nm) %in% selection]
        models[unselect] <- lapply(models[unselect], function(x){
            x$object <- NULL
            x
        })
        selection <- selection[sapply(models[selection],
function(x){!x$expanded})]
    }
	if(nm > steps){
		cat("Warning: algorithm did not converge")
		models[[1]]$Converged <- FALSE
	} else {
		models[[1]]$Converged <- TRUE
	}
    models[sapply(models, function(x){
        !is.null(x)
    })]
}


factor.scope <- function (factor, scope, marginal = NULL, joint = NULL)
{
    drop <- scope$drop
    add <- scope$add
    if (length(factor) && !is.null(drop)) {
        facs <- factor
        if (length(drop)) {
            nmdrop <- colnames(drop)
            nmfac <- colnames(factor)
            nmfac0 <- sapply(strsplit(nmfac, ":", fixed = TRUE),
function(x) paste(sort(x), collapse = ":"))
            nmdrop0 <- sapply(strsplit(nmdrop, ":", fixed = TRUE),
function(x) paste(sort(x), collapse = ":"))
            where <- match(nmdrop0, nmfac0, 0)
            if (any(!where)){
                stop(gettextf("lower scope has term(s) %s not included
in model",  paste(sQuote(nmdrop[where == 0]), collapse = ", ")), domain
= NA)
            }
            facs <- factor[, -where, drop = FALSE]
            nmdrop <- nmfac[-where]
        } else { 
            nmdrop <- colnames(factor)
        }
        if (ncol(facs) > 1) {
            keep <- rep.int(TRUE, ncol(facs))
            f <- crossprod(facs > 0)
            for (i in seq(keep)){
                keep[i] <- max(f[i, -i]) != f[i, i]
            }
            nmdrop <- nmdrop[keep]
        }
        keep <- unique(unlist(lapply(strsplit(nmdrop, ":", fixed =
TRUE), function(x){
            whereMarginal <- match(x, names(marginal))
            if(!all(is.na(whereMarginal))){
                if(length(x) == 1){
                    marginal[[whereMarginal]]
                } else {
                    lowerOrderTerms <- lapply(seq_along(whereMarginal),
function(z){
                        if(is.na(whereMarginal[z])){
                           x[z]
                        } else {
                            c(x[z], marginal[[whereMarginal[z]]])
                        }
                    })
                    lowerOrder <- apply(expand.grid(lowerOrderTerms), 1,
function(z){
                        paste(sort(z), collapse = ":")
                    })
                    lowerOrder[!lowerOrder %in% paste(sort(x), collapse
= ":")]
                }
            }
        })))
        nmdrop <- nmdrop[!nmdrop %in% keep]
        if(length(joint) & length(nmdrop)){
            nmdrop <- sapply(strsplit(nmdrop, ":", fixed = TRUE),
function(sdrop){
                whereJoint <- sapply(joint, function(x){
                    !all(!sdrop %in% x)
                })
                if(sum(whereJoint) > 0){
                    if(length(sdrop) == 1){
                        paste(unlist(joint[whereJoint]), collapse = "-")
                    } else {
                        whichJoint <- !sdrop %in%
unlist(joint[whereJoint])
                        paste(sdrop[whichJoint],
unlist(joint[whereJoint]), sep = ":", collapse = "-")
                    }
                } else {
                    paste(sdrop, collapse = ":")
                }
            })
            nmdrop <- unique(nmdrop)
        }
    } else {
        nmdrop <- character(0)
    }
    if (!length(add)){
        nmadd <- character(0)
    } else {
        nmfac <- colnames(factor)
        nmadd <- colnames(add)
        if (!is.null(nmfac)) {
            nmfac0 <- sapply(strsplit(nmfac, ":", fixed = TRUE),
function(x) paste(sort(x), collapse = ":"))
            nmadd0 <- sapply(strsplit(nmadd, ":", fixed = TRUE),
function(x) paste(sort(x), collapse = ":"))
            where <- match(nmfac0, nmadd0, 0)
            if (any(!where)){
                stop(gettextf("upper scope does not include model
term(s) %s", paste(sQuote(nmfac[where == 0]), collapse = ", ")), domain
= NA)
            }
            nmadd <- nmadd[-where]
            add <- add[, -where, drop = FALSE]
        }
        if (ncol(add) > 1) {
            keep <- rep.int(TRUE, ncol(add))
            f <- crossprod(add > 0)
            for (i in seq(keep)){
                keep[-i] <- keep[-i] & (f[i, -i] < f[i, i])
            }
            nmadd <- nmadd[keep]
        }
        if(length(nmadd)){
            keep <- sapply(strsplit(nmadd, ":", fixed = TRUE),
function(x){
                whereMarginal <- match(x, names(marginal))
                if(!all(is.na(whereMarginal))){
                    if(length(x) == 1){
                        all(!marginal[[whereMarginal]] %in% nmadd)
                    } else {
                        lowerOrderTerms <-
lapply(seq_along(whereMarginal), function(z){
                            if(is.na(whereMarginal[z])){
                               x[z]
                            } else {
                                c(x[z], marginal[[whereMarginal[z]]])
                            }
                        })
                        lowerOrder <-
apply(expand.grid(lowerOrderTerms), 1, function(z){
                            paste(sort(z), collapse = ":")
                        })
                        lowerOrder <- lowerOrder[!lowerOrder %in%
paste(sort(x), collapse = ":")]
                        all(!lowerOrder %in% nmadd)
                    }
                } else {
                    TRUE
                }
            })
            nmadd <- nmadd[keep]
        }
        if(length(nmadd) & length(joint)){
            nmadd <- sapply(strsplit(nmadd, ":", fixed = TRUE),
function(sadd){
                whereJoint <- sapply(joint, function(x){
                    !all(!sadd %in% x)
                })
                if(sum(whereJoint) > 0){
                    whichJoint <- !sadd %in% unlist(joint[whereJoint])
                    if(length(sadd) == 1){
                        paste(unlist(joint[whereJoint]), collapse = "+")
                    } else {
                        paste(sadd[whichJoint],
unlist(joint[whereJoint]), sep = ":", collapse = "+")
                    }
                } else {
                    paste(sadd, collapse = ":")
                }
            })
            nmadd <- unique(nmadd)
            
        }
    }
    list(drop = nmdrop, add = nmadd)
}