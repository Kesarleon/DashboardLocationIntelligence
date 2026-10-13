{
  library(shiny)
  library(tidyverse)
  library(magrittr)
  library(rgdal)
  library(leaflet)
  library(leaflet.extras)
  library(rgeos)
  library(purrr)
  library(inegiR)
  library(htmltools)
  library(htmlwidgets)
  library(DT)
  

}

shinyServer(function(input, output) {

  source('./denue_cesar.R')
     
  output$mun1 <- renderUI({
    muni <- data_geo[data_geo$NOM_ENT %in% input$edo,]$NOM_MUN %>% unique() %>% sort()
    selectInput("mun", "Municipio:", muni, multiple = T)
  })
  
  output$loc1 <- renderUI({
    loc <- data_geo[data_geo$NOM_MUN %in% input$mun,]$NOM_LOC %>% unique() %>% sort()
    selectInput("loc", "Localidad:", loc, multiple = T)
  })
  
  data <- reactive({
    
    data_loc %<>% select(CVEGEO,NOM_ENT,NOM_MUN,NOM_LOC, LONGITUD, LATITUD)
    
    if(!is.null(input$edo)){
      data_loc %<>% filter(NOM_ENT %in% input$edo)
    }
    if(!is.null(input$mun)){
      data_loc %<>% filter(NOM_MUN %in% input$mun)
    }
    if(!is.null(input$loc)){
      data_loc %<>% filter(NOM_LOC %in% input$loc)
    }
    return(data_loc)
  })
  
  Centroides_loc <- reactive({
    shp[shp@data$CVEGEO %in% data()$CVEGEO,] %>% gCentroid(byid = T)
  })
  
  keyword <- reactive({
    
    input$inicio
    
    isolate({
      kw <- c(input$neg, input$TipoNegocio)
      kw <- unique(kw[!kw %in% c("","Otro:")])
    })
  })
  
  query_inegi <- reactive({

    input$inicio

    isolate({
      Centroides <- Centroides_loc()
      k <- 1
      query <- list()
      for(i in 1:nrow(Centroides@coords)){
        for(j in seq_along(keyword())){
          tryCatch({
            query[[k]] <- denue_cesar(latitud = as.character(Centroides@coords[i,2]),
                                      longitud = as.character(Centroides@coords[i,1]),
                                      token,
                                      meters = input$metros,
                                      keyword = tolower(keyword()[j])) %>%
              mutate(Negocio = keyword()[j])
          }, error = function(e){})
          k <- k +1
        }
      }
      return(bind_rows(query))
    })
  })
  
  output$mapa <- renderLeaflet({
    
#    if(input$clin){
#      mapa %<>% addAwesomeMarkers(lng = clinicas$Lng, lat = clinicas$Lat,
#                                  icon = Icono_Salud, popup = clinicas$Nombre)
#    }
    
    if(input$inicio == 0){
      return(mapa)
    }
    
    else({
      input$inicio
      
      isolate({
        
        if(any(input$neg %in% "Otro:")){
          names(colores)[6] <- input$TipoNegocio
        }
        
        Centroides <- Centroides_loc()
        mapa %<>% addCircles(lng = Centroides@coords[,1], lat = Centroides@coords[,2],
                             radius = input$metros, color = "red",
                             popup = paste("Localidad:",data()$NOM_LOC)) %>% 
          addAwesomeMarkers(lng = Centroides@coords[,1], lat = Centroides@coords[,2],
                            icon = Icono, popup = paste("Localidad:",data()$NOM_LOC))
        
        consulta_inegi_split <- split(query_inegi(), query_inegi()$Negocio)

        names(consulta_inegi_split) %>%
          purrr::walk(function(tipo) {
            mapa <<- mapa %>%
              addCircles(data = consulta_inegi_split[[tipo]],
                         lng =~ as.numeric(Longitud), lat =~ as.numeric(Latitud),
                         radius = 15, popup =~ Nombre, weight = 1,
                         color = "black", fillColor =~ factpal(Negocio),
                         opacity = 0.6, fillOpacity = 0.6, group = tipo)
          })

        mapa %<>% addLayersControl(
          overlayGroups = names(consulta_inegi_split),
          options = layersControlOptions(collapsed = T)) %>%
          addLegend("bottomright", color = colores[keyword()],
                    labels = names(colores[keyword()]), title = "Tipos de negocio")
        
        return(mapa)
      })
    })
    
  })
  
  models <- reactive({

    input$inicio

    isolate({
      New_Data <- shp[shp@data$CVEGEO %in% data()$CVEGEO,]@data

      predicciones <- list()
      for(i in seq_along(input$est)){
        
#        predicciones[[i]] <- predict(modelos[[input$est[i]]], New_Data)
        predicciones[[i]] <- rnorm(dim(New_Data)[1],10000, 2000)
      }
      pred <- bind_cols(predicciones)
      names(pred) <- input$est
      pred <- bind_cols(Localidad = New_Data$NOM_LOC, ceiling(pred))
      pred[pred<0]<-1
      return(pred)

    })
  })
  
  output$predictions <- renderDataTable({
    
    input$inicio
    
    isolate({
      tabla_M <- datatable(models(), rownames = F, filter="bottom", extensions = 'Buttons',  
                           options= list(pageLength = 15,
                                         autoWidth=T ,
                                         dom='Bfrtip',
                                         buttons = c('copy', 'csv', 'excel', 'pdf'),#, 'print'),
                                         initComplete = JS(
                                           "function(settings, json) {",
                                           "$(this.api().table().header()).css({'background-color': 'blue', 'color': 'white'});",
                                           "}"))) %>% 
        formatStyle(names(models()), color = "black") 

      for(k in seq_along(names(models())[-1])){
        tabla_M %<>% formatStyle(names(models())[-1][k],
                     background = styleColorBar(c(0,pull(models()[,names(models())[-1][k]])), 'steelblue'),
                     backgroundSize = '90% 85%', backgroundRepeat = 'no-repeat', backgroundPosition = 'right')
        }
      
      return(tabla_M)
    })
  }) 
  
})
