#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

geocodeAdddress <- function(address) {
    require(RJSONIO)
    source('./key.R')
    url <- 'http://api.positionstack.com/v1/forward?access_key='
    url <- URLencode(paste(url, key, '&query=', address, "&limit=1", sep = ""))
    x <- fromJSON(url, simplify = FALSE)
    if (length(x$data)) {
        out <- c(x$data[[1]]$longitude, x$data[[1]]$latitude)
    } else {
        out <- NA
    }
    out
}


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Geolocation Playground"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("address", "Address to Geolocate", "Example: 1600 Pennsylvania Ave NW, Washington DC"),
            sliderInput("lat",
                        "Latitude",
                        min = -90,
                        max = 90,
                        value = 0),
            sliderInput("long",
                        "Longitude",
                        min = -180,
                        max = 180,
                        value = 0)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
