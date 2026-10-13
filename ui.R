{
  library(shiny)
  library(tidyverse)
  library(magrittr)
  library(rgdal)
  library(leaflet)
  library(leaflet.extras)
  library(DT)
  library(shinythemes)
}

shinyUI(fluidPage(
  
  theme = shinytheme("flatly"),
  
  titlePanel(title = div(#img(src="Salud-Digna.jpeg", height="125px", width="233px"),
                         "Modelo Geoanalítico"), windowTitle = "Modelo Geoanalítico"),
  
  sidebarLayout(
    sidebarPanel(
      
      h4("Zona:"),
        selectInput("edo", "Estado:", nombre_estados, multiple = T),
        uiOutput("mun1"),
        uiOutput("loc1"),
      
#      checkboxInput("clin", "Mostrar clínicas Salud Digna",F),
      
      h4("Estudios:"),
        checkboxGroupInput("est", NULL, sort(estudios), sort(estudios)),
      
      h4("Radio de alcance:"),
        sliderInput("metros", NULL, min = 100, max = 5000, value = 500, step = 100,post = " m."),
       
      h4("Tipo de Negocio:"),
        checkboxGroupInput("neg", NULL, negocio, negocio[-6]),
      
      conditionalPanel(condition = 'input.neg.indexOf("Otro:") > -1',
                       textInput("TipoNegocio", NULL, placeholder = "Ejemplo: farmacia")),
      
      actionButton("inicio", "Buscar",
                   icon = icon(name = "search")),
      
      width = 2, draggable = T
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Mapa",leafletOutput("mapa", width="112.5%", height=700)),
        tabPanel("Modelo", 
                 h3("Promedio esperado de estudios mensuales por localidad"),
                 dataTableOutput("predictions"))
      )
    )
  )
))
