# This file contains the following functions:
#
# (1) extractAICc
# (2) dropterm.AICc
# (3) addterm.AICc
# (4) stepAICc
#
# Code originally written by B.D. Ripley and W.N. Venables
# with changes in the extractAICc function and others written
# by Christoph Scherber, 4th/5th May 2009.
#
# The function stepAICc may be used to perform AICc-based model selection
# if sample sizes are too small to use AIC.
#
# AICc is a version of AIC corrected for small sample sizes
# as defined in Burnham & Anderson, 2002.

extractAICc=function (fit, scale, k = 2, ...) 
{
    if (fit$method == "REML") # minor modification by CFD; was: " !="ML", but for any normal glm the method is "glm.fit" so it wouldn't work
        stop("AIC undefined for REML fit")
    res <- logLik(fit)
    edf <- attr(res, "df")
    n=length(residuals(fit))	
    c(edf,-2 * res + k * edf+2*edf*(edf+1)/(n-edf-1))	
}

dropterm.AICc=
function (object, scope, scale = 0, test = c("none", "Chisq"), 
    k = 2, sorted = FALSE, trace = FALSE, ...) 
{
    tl <- attr(terms(object), "term.labels")
    if (missing(scope)) 
        scope <- drop.scope(object)
    else {
        if (!is.character(scope)) 
            scope <- attr(terms(update.formula(object, scope)), 
                "term.labels")
        if (!all(match(scope, tl, 0L))) 
            stop("scope is not a subset of term labels")
    }
    ns <- length(scope)
    ans <- matrix(nrow = ns + 1L, ncol = 2L, dimnames = list(c("<none>", 
        scope), c("df", "AIC")))
    ans[1, ] <- extractAICc(object, scale, k = k, ...)
    env <- environment(formula(object))
    n0 <- length(object$residuals)
    for (i in seq(ns)) {
        tt <- scope[i]
        if (trace) {
            message("trying -", tt)
            utils::flush.console()
        }
        nfit <- update(object, as.formula(paste("~ . -", tt)), 
            evaluate = FALSE)
        nfit <- eval(nfit, envir = env)
        ans[i + 1, ] <- extractAICc(nfit, scale, k = k, ...)
        if (length(nfit$residuals) != n0) 
            stop("number of rows in use has changed: remove missing values?")
    }
    dfs <- ans[1L, 1L] - ans[, 1L]
    dfs[1L] <- NA
    aod <- data.frame(Df = dfs, AIC = ans[, 2])
    o <- if (sorted) 
        order(aod$AIC)
    else seq_along(aod$AIC)
    test <- match.arg(test)
    if (test == "Chisq") {
        dev <- ans[, 2L] - k * ans[, 1L]
        dev <- dev - dev[1L]
        dev[1L] <- NA
        nas <- !is.na(dev)
        P <- dev
        P[nas] <- safe_pchisq(dev[nas], dfs[nas], lower.tail = FALSE)
        aod[, c("LRT", "Pr(Chi)")] <- list(dev, P)
    }
    aod <- aod[o, ]
    head <- c("Single term deletions", "\nModel:", deparse(as.vector(formula(object))))
    if (scale > 0) 
        head <- c(head, paste("\nscale: ", format(scale), "\n"))
    class(aod) <- c("anova", "data.frame")
    attr(aod, "heading") <- head
    aod
}

##
addterm.AICc=function (object, scope, scale = 0, test = c("none", "Chisq"), 
    k = 2, sorted = FALSE, trace = FALSE, ...) 
{
    if (missing(scope) || is.null(scope)) 
        stop("no terms in scope")
    if (!is.character(scope)) 
        scope <- add.scope(object, update.formula(object, scope))
    if (!length(scope)) 
        stop("no terms in scope for adding to object")
    ns <- length(scope)
    ans <- matrix(nrow = ns + 1L, ncol = 2L, dimnames = list(c("<none>", 
        scope), c("df", "AIC")))
    ans[1L, ] <- extractAICc(object, scale, k = k, ...)
    n0 <- length(object$residuals)
    env <- environment(formula(object))
    for (i in seq(ns)) {
        tt <- scope[i]
        if (trace) {
            message("trying +", tt)
            utils::flush.console()
        }
        nfit <- update(object, as.formula(paste("~ . +", tt)), 
            evaluate = FALSE)
        nfit <- eval(nfit, envir = env)
        ans[i + 1L, ] <- extractAICc(nfit, scale, k = k, ...)
        if (length(nfit$residuals) != n0) 
            stop("number of rows in use has changed: remove missing values?")
    }
    dfs <- ans[, 1L] - ans[1L, 1L]
    dfs[1L] <- NA
    aod <- data.frame(Df = dfs, AIC = ans[, 2L])
    o <- if (sorted) 
        order(aod$AIC)
    else seq_along(aod$AIC)
    test <- match.arg(test)
    if (test == "Chisq") {
        dev <- ans[, 2L] - k * ans[, 1L]
        dev <- dev[1L] - dev
        dev[1L] <- NA
        nas <- !is.na(dev)
        P <- dev
        P[nas] <- safe_pchisq(dev[nas], dfs[nas], lower.tail = FALSE)
        aod[, c("LRT", "Pr(Chi)")] <- list(dev, P)
    }
    aod <- aod[o, ]
    head <- c("Single term additions", "\nModel:", deparse(as.vector(formula(object))))
    if (scale > 0) 
        head <- c(head, paste("\nscale: ", format(scale), "\n"))
    class(aod) <- c("anova", "data.frame")
    attr(aod, "heading") <- head
    aod
}

##
stepAICc=function (object, scope, scale = 0, direction = c("both", "backward", 
    "forward"), trace = 1, keep = NULL, steps = 1000, use.start = FALSE, 
    k = 2, ...) 
{
    mydeviance <- function(x, ...) {
        dev <- deviance(x)
        if (!is.null(dev)) 
            dev
        else extractAICc(x, k = 0)[2L]
    }
    cut.string <- function(string) {
        if (length(string) > 1L) 
            string[-1L] <- paste("\n", string[-1L], sep = "")
        string
    }
    re.arrange <- function(keep) {
        namr <- names(k1 <- keep[[1L]])
        namc <- names(keep)
        nc <- length(keep)
        nr <- length(k1)
        array(unlist(keep, recursive = FALSE), c(nr, nc), list(namr, 
            namc))
    }
    step.results <- function(models, fit, object, usingCp = FALSE) {
        change <- sapply(models, "[[", "change")
        rd <- sapply(models, "[[", "deviance")
        dd <- c(NA, abs(diff(rd)))
        rdf <- sapply(models, "[[", "df.resid")
        ddf <- c(NA, abs(diff(rdf)))
        AIC <- sapply(models, "[[", "AIC")
        heading <- c("Stepwise Model Path \nAnalysis of Deviance Table", 
            "\nInitial Model:", deparse(as.vector(formula(object))), 
            "\nFinal Model:", deparse(as.vector(formula(fit))), 
            "\n")
        aod <- if (usingCp) 
            data.frame(Step = change, Df = ddf, Deviance = dd, 
                `Resid. Df` = rdf, `Resid. Dev` = rd, Cp = AIC, 
                check.names = FALSE)
        else data.frame(Step = change, Df = ddf, Deviance = dd, 
            `Resid. Df` = rdf, `Resid. Dev` = rd, AIC = AIC, 
            check.names = FALSE)
        attr(aod, "heading") <- heading
        class(aod) <- c("Anova", "data.frame")
        fit$anova <- aod
        fit
    }
    Terms <- terms(object)
    object$formula <- Terms
    if (inherits(object, "lme")) 
        object$call$fixed <- Terms
    else if (inherits(object, "gls")) 
        object$call$model <- Terms
    else object$call$formula <- Terms
    if (use.start) 
        warning("'use.start' cannot be used with R's version of glm")
    md <- missing(direction)
    direction <- match.arg(direction)
    backward <- direction == "both" | direction == "backward"
    forward <- direction == "both" | direction == "forward"
    if (missing(scope)) {
        fdrop <- numeric(0)
        fadd <- attr(Terms, "factors")
        if (md) 
            forward <- FALSE
    }
    else {
        if (is.list(scope)) {
            fdrop <- if (!is.null(fdrop <- scope$lower)) 
                attr(terms(update.formula(object, fdrop)), "factors")
            else numeric(0)
            fadd <- if (!is.null(fadd <- scope$upper)) 
                attr(terms(update.formula(object, fadd)), "factors")
        }
        else {
            fadd <- if (!is.null(fadd <- scope)) 
                attr(terms(update.formula(object, scope)), "factors")
            fdrop <- numeric(0)
        }
    }
    models <- vector("list", steps)
    if (!is.null(keep)) 
        keep.list <- vector("list", steps)
    if (is.list(object) && (nmm <- match("nobs", names(object), 
        0)) > 0) 
        n <- object[[nmm]]
    else n <- length(residuals(object))
    fit <- object
    bAIC <- extractAICc(fit, scale, k = k, ...)
    edf <- bAIC[1L]
    bAIC <- bAIC[2L]
    if (is.na(bAIC)) 
        stop("AIC is not defined for this model, so stepAIC cannot proceed")
    nm <- 1
    Terms <- terms(fit)
    if (trace) {
        cat("Start:  AICc=", format(round(bAIC, 2)), "\n", cut.string(deparse(as.vector(formula(fit)))), 
            "\n\n", sep = "")
        utils::flush.console()
    }
    models[[nm]] <- list(deviance = mydeviance(fit), df.resid = n - 
        edf, change = "", AIC = bAIC)
    if (!is.null(keep)) 
        keep.list[[nm]] <- keep(fit, bAIC)
    usingCp <- FALSE
    while (steps > 0) {
        steps <- steps - 1
        AIC <- bAIC
        ffac <- attr(Terms, "factors")
        if (!is.null(sp <- attr(Terms, "specials")) && !is.null(st <- sp$strata)) 
            ffac <- ffac[-st, ]
        scope <- factor.scope(ffac, list(add = fadd, drop = fdrop))
        aod <- NULL
        change <- NULL
        if (backward && length(scope$drop)) {
            aod <- dropterm.AICc(fit, scope$drop, scale = scale, trace = max(0, 
                trace - 1), k = k, ...)
            rn <- row.names(aod)
            row.names(aod) <- c(rn[1L], paste("-", rn[-1L], sep = " "))
            if (any(aod$Df == 0, na.rm = TRUE)) {
                zdf <- aod$Df == 0 & !is.na(aod$Df)
                nc <- match(c("Cp", "AIC"), names(aod))
                nc <- nc[!is.na(nc)][1L]
                ch <- abs(aod[zdf, nc] - aod[1, nc]) > 0.01
                if (any(ch)) {
                  warning("0 df terms are changing AIC")
                  zdf <- zdf[!ch]
                }
                if (length(zdf) > 0L) 
                  change <- rev(rownames(aod)[zdf])[1L]
            }
        }
        if (is.null(change)) {
            if (forward && length(scope$add)) {
                aodf <- addterm.AICc(fit, scope$add, scale = scale, 
                  trace = max(0, trace - 1), k = k, ...)
                rn <- row.names(aodf)
                row.names(aodf) <- c(rn[1L], paste("+", rn[-1L], 
                  sep = " "))
                aod <- if (is.null(aod)) 
                  aodf
                else rbind(aod, aodf[-1, , drop = FALSE])
            }
            attr(aod, "heading") <- NULL
            if (is.null(aod) || ncol(aod) == 0) 
                break
            nzdf <- if (!is.null(aod$Df)) 
                aod$Df != 0 | is.na(aod$Df)
            aod <- aod[nzdf, ]
            if (is.null(aod) || ncol(aod) == 0) 
                break
            nc <- match(c("Cp", "AIC"), names(aod))
            nc <- nc[!is.na(nc)][1L]
            o <- order(aod[, nc])
            if (trace) {
                print(aod[o, ])
                utils::flush.console()
            }
            if (o[1L] == 1) 
                break
            change <- rownames(aod)[o[1L]]
        }
        usingCp <- match("Cp", names(aod), 0) > 0
        fit <- update(fit, paste("~ .", change), evaluate = FALSE)
        fit <- eval.parent(fit)
        if (is.list(fit) && (nmm <- match("nobs", names(fit), 
            0)) > 0) 
            nnew <- fit[[nmm]]
        else nnew <- length(residuals(fit))
        if (nnew != n) 
            stop("number of rows in use has changed: remove missing values?")
        Terms <- terms(fit)
        bAIC <- extractAICc(fit, scale, k = k, ...)
        edf <- bAIC[1L]
        bAIC <- bAIC[2L]
        if (trace) {
            cat("\nStep:  AICc=", format(round(bAIC, 2)), "\n", 
                cut.string(deparse(as.vector(formula(fit)))), 
                "\n\n", sep = "")
            utils::flush.console()
        }
        if (bAIC >= AIC + 1e-07) 
            break
        nm <- nm + 1
        models[[nm]] <- list(deviance = mydeviance(fit), df.resid = n - 
            edf, change = change, AIC = bAIC)
        if (!is.null(keep)) 
            keep.list[[nm]] <- keep(fit, bAIC)
    }
    if (!is.null(keep)) 
        fit$keep <- re.arrange(keep.list[seq(nm)])
    step.results(models = models[seq(nm)], fit, object, usingCp)
}