---
title       : US Mortality Rate Predictor
subtitle    : Based on CDC 2013 Mortality Rates
author      : ibinado / July 2015
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Mortality Rate Predictor

* What is it?
  * A predictor of mortality rate of US population based on demographics and age.
* What's the point?
  * You can check the probability that someone in a given population
    subgroup will die within the selected time period.
  * Some of the questions it might help answer are:
      * How much money should you put in your nest egg?
      * Is that life insurance a good deal?
      * Is it worth retiring early with a smaller pension, or wait to be
        fully vested?

--- 

## Underlying Mortality Rate Data

Mortality rates are based on data from the
[CDC WONDER Online Database](http://wonder.cdc.gov/wonder/help/ucd.html).

The graph below shows the overall yearly mortality rate by age across all population groups.

<img src="assets/fig/mortality-rate-plot-1.png" title="plot of chunk mortality-rate-plot" alt="plot of chunk mortality-rate-plot" style="display: block; margin: auto;" />

---

## Prediction Algorithm

From the yearly mortality rate data we predict the mortality rate over the prediction time range with the following formula:

$$overall\_mortality\_rate = 1 - \displaystyle\prod_{age=start}^{end} (1 - mortality\_rate_{age})$$

* CDC data only covers mortality rates until 85 years of age
* predictor reuses the 85-year mortality rate for greater ages
* leads to underestimation of mortality rate for older ages

---

## Go try it out for yourself

It's easy.
* Select your demographic and prediction time range.
* Get a result instantly.
* Enjoy your life!

[Try it out now](https://ibinado.shinyapps.io/mortality)
