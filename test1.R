library(shiny)

ui <- fluidPage(
  titlePanel("Interactive R Code Execution"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("code_input", "Enter R Code:"),
      actionButton("run_button", "Run Code")
    ),
    
    mainPanel(
      verbatimTextOutput("output_text")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$run_button, {
    code <- input$code_input
    result <- try(eval(parse(text = code)), silent = TRUE)
    
    if (inherits(result, "try-error")) {
      output$output_text <- renderText(paste("Error:", result$message))
    } else {
      output$output_text <- renderText(result)
    }
  })
}

shinyApp(ui, server)
