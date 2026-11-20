# Selected verbatim functions from R/release_models.R, frozen playing-time v0.3.
# This excerpt calculates calibration scores and a finite-sample quantile.
# It does not fit a model or establish coverage on another population.

interval_scores <- function(actual,prediction,method) {
  switch(method,absolute=abs(actual-prediction),sqrt=abs(actual-prediction)/sqrt(prediction+100),
    log=abs(log1p(actual)-log1p(prediction)))
}
calibrate_release <- function(actual,prediction,method,level=.9) {
  s<-sort(interval_scores(actual,prediction,method));i<-ceiling((length(s)+1)*level)
  if(i>length(s))stop("Insufficient calibration sample")
  s[i]
}
