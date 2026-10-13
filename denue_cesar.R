library(inegiR)
library(httr)
library(jsonlite)


denue_cesar <- function (latitud, longitud, token, meters = 250, keyword = "todos") 
{
  .EstaEnMexico <- function(latitud, longitud) {
    if (as.numeric(latitud) < 14.559507 | as.numeric(latitud) > 
        32.75712 | as.numeric(longitud) > -86.708301 | as.numeric(longitud) < 
        -118.312155) {
      FALSE
    }
    else {
      TRUE
    }
  }
  if (.EstaEnMexico(latitud, longitud)) {
  }
  else {
    stop("Coordinates are not in Mexico")
  }
  url <- "https://www.inegi.org.mx/app/api/denue/v1/consulta/Buscar/"
  coordenadas <- paste0(latitud, ",", longitud)
  consulta <- paste0(url, keyword, "/", coordenadas, "/", meters, 
                     "/", token)
  datos <- httr::GET(consulta)
  datos.raw.content <- rawToChar(datos$content)
  df <- fromJSON(datos.raw.content)
  return(df)
}
