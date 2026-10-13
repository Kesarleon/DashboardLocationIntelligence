library(inegiR)
library(httr)
library(jsonlite)

# La función del paquete inegiR consulta por default a la antigua página 
# (http://www3.inegi.org.mx/sistemas/api/denue/v1/consulta/buscar/)

# Corriendo la siguiente linea se puede ver todo el proceso que se tenía que
# seguir cuando consultabas la anterior página
inegi_denue

# En la nueva página a donde apunta la API del INEGI, el resultado de las consultas
# ya vienen en formato de lista. Entonces la forma de consultar se vuelve más sencilla

# Seguramente en la próxima actualización del paquete inegiR ya vendrá
# actualizada la función de consulta del DENUE, pero mientras, creamos esta función
# que es una adaptación de la función anterior

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

# Comparamos ambas funciones

token<-"3169f103-2c0b-4882-b817-d26a276b16c6"

lat_prueba<-"21.85717833"
long_prueba<-"-102.28487238"

key_prueba = "camiones"
met_prueba <- 250

x1 <- inegi_denue(latitud = lat_prueba,
                  longitud = long_prueba,
                  token = token, 
                  meters = met_prueba,
                  keyword = key_prueba)

x2 <- denue_cesar(latitud = lat_prueba,
                  longitud = long_prueba,
                  token = token, 
                  meters = met_prueba,
                  keyword = key_prueba)

# La primera función devuelve todos los negocios six excepción
# La segunda función sí respeta el filtro de la keyword
dim(x1)
dim(x2)

head(x1)
head(x2)


names(x2)
