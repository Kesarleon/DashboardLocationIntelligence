{
  library(htmltools)
  library(htmlwidgets)
  library(shiny)
  library(tidyverse)
  library(magrittr)
  library(rgdal)
  library(leaflet)
  library(leaflet.extras)
  library(stringi)
  library(magrittr)
  library(purrr)
  library(DT)
  

} 

#clinicas <- read_csv("data/Ubicacion_Clinicas.csv") %>% as.data.frame()
#clinicas$Nombre %<>% stri_encode("latin1")
df <- readRDS("data/Base_Modelo.rds")

shp <- readRDS("data/shp_loc.rds") 
shp@data$NOM_ENT %<>% as.character() %>% stri_encode("UTF-8")
shp@data$NOM_MUN %<>% as.character() %>% stri_encode("UTF-8")
shp@data$NOM_LOC %<>% as.character() %>% stri_encode("UTF-8")

lng <- shp@data$LONGITUD %>% as.character() %>% as.numeric()
shp@data$LONGITUD <- lng/(-10000)
lat <- shp@data$LATITUD %>% as.character() %>% as.numeric()
shp@data$LATITUD <- lat/(10000)

data_loc <- shp@data

nombre_estados <- data_loc$NOM_ENT %>% unique()
nombre_municipios <- data_loc$NOM_MUN %>% unique() 
nombre_localidades <- data_loc$NOM_LOC %>% unique() 

data_geo <- data_loc[,2:4]

estudios <- c("Estudio A","Estudio B","Estudio C","Estudio D",
              "Estudio E", "Estudio F", "Estudio G", "Estudio H",
              "Estudio I", "Estudio J", "Estudio K")

negocio <- sort(c("Clínicas de consultorios", "Consultorios de medicina", 
                  "Consultorios de optometría","Hospitales","Laboratorios médicos","Otro:"))

modelos <- str_c("data/",list.files("data", pattern = "Ajuste")) %>% map(read_rds)
names(modelos) <- sort(estudios)[c(2,1,3:11)]

token<-"3169f103-2c0b-4882-b817-d26a276b16c6"

Icono <- makeAwesomeIcon(icon = "star", markerColor = "red")
Icono_Salud <- makeAwesomeIcon(icon = "star", markerColor = "green")

mapa <- leaflet() %>% addTiles(options = tileOptions(minZoom = 5, maxZoom = 18)) %>% 
  setView(-103.1331583, 22.3225194, zoom = 5) %>% 
  addProviderTiles(providers$OpenMapSurfer) %>%
  addScaleBar("bottomleft") %>% 
  addMeasure(primaryLengthUnit = "meters", primaryAreaUnit = "sqmeters", localization = "es") %>% 
  addEasyButton(easyButton(
    icon="fa-globe", title="Zoom a Nivel 1",
    onClick=JS("function(btn, map){map.setZoom(6);}"))) 

colores <- c("red","deepskyblue","green","purple","orange","gray")
names(colores) <- negocio
factpal <- colorFactor(colores, negocio)
