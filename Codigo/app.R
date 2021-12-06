library(shiny) #App web
library(shinydashboard) #Para formato dashboard
library(shinyjs) #Para usar entorno javascript
library(highcharter) #Para graficos interactivos
library(DT) #Para tablas
library(dplyr) #Para manipulacion de bases de datos
library(dashboardthemes) #Para modificar el theme de un shinydashboard

header <- dashboardHeader(
    title= a(href='https://www.vitricursos.cl/', 
             img(src='https://i.ibb.co/y6SJQrQ/Logo.png', 
                 width='175px',height='90px')), 
    titleWidth=300,
    tags$li(class = "dropdown",
            tags$style(".main-header {max-height: 100px}"),
            tags$style(".main-header .logo {height: 100px;}"))
)

## Menu de navegacion del dashboard:
sidebar <- dashboardSidebar(
    width = 300,
    tags$style(".left-side, .main-sidebar {padding-top: 150px}"),
    sidebarMenu(
        id='sidebar',
        menuItem('Cursos',
                 tabName = 'menu1'),
        menuItem('Test',
                 tabName = 'menu2'),
        menuItem('Estadisticas',
                 tabName = 'menu3')
    ))

## Cuerpo de cada vineta del menu
body <- dashboardBody()
ui <- dashboardPage(header, sidebar, body)
server <- function(input, output) {}
shinyApp(ui = ui, server = server)