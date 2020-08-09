#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

require(shiny)
require(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Geolocation Playground"),
    
    # Documentation
    h4('Enter an address and click geolocate to access the approximate latitude and longitude coordinates and the point map. If you want to add a circle to the point on the map, activate the option "Add Circle"'),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("address", "Address to Geolocate", "1600 Pennsylvania Ave NW, Washington DC"),
            textOutput("lat"),
            textOutput("long"),
            checkboxInput("circ", "Add Circle?"),
            submitButton('Geolocate')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            leafletOutput("map", height = 550)
        )
    )
))
