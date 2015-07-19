library(shiny)

# Read mortality rate input data.
load('mortality.data')

# Compute predicted mortality rate based on demographics.
computeMortality <- function(start.age, gender, race, outlook) {
  m <- mortality
  # Subset data by gender, if requested.
  if (gender != '') {
    m <- m[m$Gender == gender,]
  }
  # Subset data by race, if requested.
  if (race != '') {
    m <- m[m$Race == race,]
  }
  # Reduce data to survival rate for each year.
  m <- split(m[, c('Deaths', 'Population')], m$Age)
  m <- lapply(m, function(x) { colSums(x) })
  survivalRate.PerYear <- sapply(m, function(x) {
    1 - (x['Deaths'] / x['Population'])
  })
  # Compute cumulative survival rate over prediction period.
  survivalRate <- 1.0
  end.age <- start.age + outlook - 1
  for (age in start.age:end.age) {
    # First data point is for '0' years of age but has index 1; adjust index.
    # If we run out of data, reuse last year's values for following years.
    index <- min(age + 1, length(survivalRate.PerYear))
    survivalRate <- survivalRate * survivalRate.PerYear[index]
  }
  mortalityOutlook <- 100 * (1 - survivalRate)
  as.character(format(mortalityOutlook, digits=2))
}

shinyServer(
  function(input, output) {
    output$start.age <- reactive(input$age)
    output$end.age <- reactive(input$age + input$outlook)
    output$mortality <- reactive(
      computeMortality(input$age, input$gender, input$race, input$outlook))
  }
)
