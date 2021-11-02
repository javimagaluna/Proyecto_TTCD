install.packages("shiny")
library(shiny)



ui<-fluidPage(
  sidebarLayout(
    sidebarPanel(selectInput("Modalidad", label = h3("Seleccion de Modalidad del Curso"), 
                             choices = list("Blended: Semi-Presencial" = 1, "E-learning: Online" = 2, "Presencial" = 3))),
    mainPanel()
  )
)

  server<-function(input, output){}

shinyApp(ui = ui, server = server)




