#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
require(leaflet)

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


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    p <- leaflet() %>% addTiles()

    output$map <- renderLeaflet({
        coord <- geocodeAdddress(input$address)
        
        output$lat <- renderText({paste('Longitude:', coord[1])})
        output$long <- renderText({paste('Latitude:', coord[2])})
        
        p <- p %>% addMarkers(lng = coord[1], lat = coord[2])
        
        if(input$circ) {
            p <- p %>% addCircleMarkers(lng = coord[1], lat = coord[2])
        }
        
        p
    })

})
