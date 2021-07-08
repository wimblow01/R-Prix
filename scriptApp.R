library(shiny)

# Define UI
ui <- fluidPage(
  # App title
  titlePanel("Prix des batiments a Paris par m!"),
  # Input for square meters
  sidebarPanel(
    sliderInput(inputId = "squareMeters",
                label = "Square Meters",
                min = 1,
                max = 10000,
                value = 5000
    )
  ),
  # Price prediction
  mainPanel(
    tableOutput("predict")
  )
)

# Load saved model
load("model.Rdata")

# Define server
server <- function(input, output) {
  predictions <- reactive({
    preprocessInput = data.frame(squareMeters = as.integer(input$squareMeters))
    prediction <- predict(pricereg, preprocessInput)
    
    data.frame(
      Prediction = as.character(c(prediction))
    )
  })
  output$predict <- renderTable({
    predictions()
  })
}

# Launch the app
shinyApp(ui = ui, server = server)