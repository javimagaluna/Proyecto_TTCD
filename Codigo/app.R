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
body <- dashboardBody( 
    fluidRow(
        box(
            title = strong("Test curso ideal"), status = "warning",
            solidHeader = TRUE, "Encuentra el curso para ti!"
        ),
        box(title = strong("Búsqueda por filtro"), status = "warning",
            solidHeader = TRUE, "Área", br(), "Modalidad")
    ),
    fluidRow(
        box(width=12,
            title = "Nuevas plataformas:", status = "info",
            strong("ACADEMIA TarapaTech")
            ,br(), 
            solidHeader = TRUE, "Para más información ingresar al link", br(),href='https://www.acamedia.cl/tdigital')
    ),
    fluidRow(
        box(width=4,
            title = "Crece Turismo Chile", background = "purple",
            solidHeader = TRUE, "Postulación hasta el 13/12/2021"),
        box(width=4,
            title = "Programacion Con Javascrip", background = "teal",
            solidHeader = TRUE, "Postulación hasta el 21/01/2022"),
        box(width=4,
            title = "Habilidades para el Empleo", background = "purple",
            solidHeader = TRUE, "Postulación hasta el 17/01/2022")
    )
)

ui <- dashboardPage(header, sidebar, body)
server <- function(input, output) {}
shinyApp(ui = ui, server = server)