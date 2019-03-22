# Parameters & data
source('./code/param.R')


server = function(input, output, session) {

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Loading raster
ras <- reactive({
  sel <- input$layersTable # Selected drivers
  type <- input$dataType # Selected type of data (footprint vs hotspot)
  trans <- input$rawData # Selected type of data (raw vs transformed data)

  # Select proper layer depending on user selection
  if (length(sel) == 0) {
    raster0
  } else if (length(sel) == 1 && trans == 'rawData') {
    if(type == 'footprint') {
      rawDrivers[[sel]]
    } else {
      hotspots[[sel]]
    }  } else if (length(sel) == 1 && trans == 'transformed') {
    if(type == 'footprint') {
      drivers[[sel]]
    } else {
      hotspots[[sel]]
    }
  } else if (length(sel) > 1 && trans == 'rawData') {
    raster0
  } else if (length(sel) > 1 && trans == 'transformed') {
    if(type == 'footprint') {
      sum(drivers[[sel]], na.rm = T) %>%
      calc(function(x) ifelse(x == 0, NA, x))
    } else {
      sum(hotspots[[sel]], na.rm = T) %>%
      calc(function(x) ifelse(x == 0, NA, x))
    }
  }
  # crs = "+init=epsg:3857")
})

# Raster values
vals <- reactive({
  if(length(input$layersTable) > 0 && input$rawData == 'transformed') {
    val <- ras() %>%
            maxValue() %>%
            ceiling() %>%
            seq(0, ., by = ./10)
  } else if(length(input$layersTable) == 1 && input$rawData == 'rawData') {
    val <- ras() %>%
            maxValue() %>%
            ceiling() %>%
            seq(0, ., by = ./10)
  } else {
    val <- seq(0, 1, by = .1)
  }
})

# Colors
couleurs <- reactive({
  colorBin(
    palette  = colorRampPalette(cols)(11),
    domain   = values(ras()),
    bin      = vals(),
    na.color = "transparent"
  )
})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INTERACTIVE MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Leaflet
output$map <- renderLeaflet({
  map <- leaflet() %>%
         addProviderTiles(provider = providers$CartoDB.Positron) %>%
         setView(lng   = -65, lat   =  48.50, zoom  = 6) %>%
         addEasyButton(
           easyButton(icon = "fa-globe",
                      title = "Zoom to Level 1",
                      onClick = JS("function(btn, map){ map.setZoom(6); }")))
})

# Update map
observe({
# Map
  leafletProxy(mapId = "map") %>%
  clearShapes() %>%
  clearControls() %>%
  clearImages() %>%
  addRasterImage(x       = ras(),
                 colors  = couleurs(),
                 opacity = .75,
                 project = FALSE) #%>%
  # setView(lng   = -65, lat   =  48.50, zoom  = 6)

# Legend
  leafletProxy(mapId = "map") %>%
  addLegend(position  = "bottomright",
            pal       = couleurs(),
            values    = vals(),
            title     = "Map legend",
            opacity   = 1,
            className = "info legend")
})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ACTION BUTTONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Action button to reset choices
observe({
   if (input$Uncheck > 0) {
      updateCheckboxGroupInput(session = session,
                               inputId = 'layersTable',
                               label = '',
                               choiceNames = layers$Drivers,
                               choiceValues = layers$FileName)
   }
 })

# Action button to select all choices
observe({
   if (input$CheckAll > 0) {
      updateCheckboxGroupInput(session = session,
                               inputId = 'layersTable',
                               label = '',
                               selected = layers$FileName,
                               choiceNames = layers$Drivers,
                               choiceValues = layers$FileName)
   }
 })


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CONDITIONAL PANELS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~ DATA DESCRIPTION ~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
output$descrData <- renderUI({
# ~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~ #
sel <- input$layersTable
nSel <- length(sel)
trans <- input$rawData
id <- which(driversList$FileName %in% sel)

# ~~~~~~~~~~~~~~~ NO DRIVER ~~~~~~~~~~~~~~~~ #
if (nSel == 0) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<h1>','eDrivers','<h1/>',
    '<br/>',
    '<hr /><div class="pad">',
    '<br/>',
    '<h3>Context<h3/>',
    '<h4>', eDrivers$context,'<h4/>',
    '<br/>',
    '<h3>Guiding principles<h3/>',
    '<h4>', eDrivers$guiding,'<h4/>'

  )
})

# ~~~~~~~~~~~~~ SINGLE DRIVER ~~~~~~~~~~~~~~ #
} else if(nSel == 1) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<h1>',driversList$Drivers[id],'<h1/>',
    # '<h1>',driversList$Groups[id],'<h1/>',
    # '<h2>',driversList$Drivers[id],'<h2/>',
    '<br/>',
    '<hr /><div class="pad">',
    '<br/>',
    '<h3>Data description<h3/>',
    '<h4><b>Spatial resolution</b>: ',driversList$SpatRes[id],'<h4/>',
    '<h4><b>Temporal resolution</b>: ',driversList$TempRes[id],'<h4/>',
    '<h4><b>Years</b>: ',driversList$Years[id],'<h4/>',
    '<h4><b>Units</b>: ',withMathJax(driversList$Units[id]),'<h4/>',
    '<h4><b>Transformations</b>: ',driversList$DataTrans[id],'<h4/>',
    '<br/>',
    '<h3>Source ', ifelse(driversList$SourceLink[id] != '',
                          paste0('<a href="',driversList$SourceLink[id],'" target="_blank"><i class="fa fa-globe" aria-hidden="true"></i></a><h3/>'),
                          '<h3/>'),
    '<h4>',driversList$Source[id],'<h4/>',
    '<br/>'

  )
})

# ~~~~~~~~~~ MULTIPLE DRIVERS RAW ~~~~~~~~~~ #
} else if(nSel > 1 && trans == 'rawData') {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<h1>','Driver footprint','<h1/>',
    '<br/>',
    '<hr /><div class="pad">',
    '<br/>',
    '<h3><h3/>'
  )
})

# ~~~~~~ MULTIPLE DRIVERS TRANSFORMED ~~~~~~ #
} else if(nSel > 1 && trans == 'transformed') {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<h1>','Driver footprint','<h1/>',
    '<br/>',
    '<hr/><div class="pad">',
    '<br/>'
  )
})
}
})


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~ DATA OVERVIEW ~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
output$dataOverview <- renderUI({
# ~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~ #
sel <- input$layersTable
nSel <- length(sel)
id <- which(driversList$FileName %in% sel)

# ~~~~~~~~~~~~~ SINGLE DRIVER ~~~~~~~~~~~~~~ #
if (nSel == 1) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<br/>',
    '<h3>Overview<h3/>',
    '<h4>',driversList$Overview[id],'<h4/>',
    '<br/>'
  )
})
}
})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~ WARNING MESSAGE ~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
output$warningMSG <- renderUI({
# ~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~ #
nSel <- length(input$layersTable)
trans <- input$rawData

# ~~~~~~~~~~~~~~~~ MESSAGE ~~~~~~~~~~~~~~~~~ #
if(nSel > 1 && trans == 'rawData') {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
HTML({
  paste(
    '<div style="background-color:#4e4e4eCC;
                 background: radial-gradient(#4e4e4e, #4e4e4e66);
                 margin-left: -5%;
                 margin-right: -5%;
                 padding-top:25%;
                 padding-bottom:25%;
                 padding-left:35%;
                 padding-right:35%;
                 text-align:center;">',
    '<h6>Driver data must be transformed to allow cumulative intensity visualization<h6/></div>'
  )
})
}
})


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CONDITIONAL PLOTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
output$condPlot <- renderPlot({

# ~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~ #
sel <- input$layersTable # Selected drivers
type <- input$dataType # Selected data types between footprint and hotspots
trans <- input$rawData # Raw or transformed data
nSel <- length(sel) # Number of selections
id <- which(driversList$FileName %in% sel) # Id of selections in data table

# ~~~~~~~~~~~~~~~ NO DRIVER ~~~~~~~~~~~~~~~~ #
if (nSel == 0) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~ SINGLE DRIVER ~~~~~~~~~~~~~~ #
} else if(nSel == 1) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  if (type == 'footprint') histDriver(ras())
# ~~~~~~~~~~~~ MULTIPLE DRIVERS ~~~~~~~~~~~~ #
} else if(nSel > 1) {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  if (type == 'footprint' && trans == 'transformed') histFd(ras())
}
})





# # plot latitudinal trends
#   output$trendLat1 <- renderPlot({
#       if (!'raster0' %in% sel_layers()) {
#         cisl::plotTrend(as.matrix(ras()),
#                         type = "lat",
#                         colLine = "#C77F20",
#                         colPoly = "#C77F2033",
#                         maxValue = length(sel_layers()),
#                         font = 'Josefin Slab')
#       }
#   }, bg='transparent')

# # plot longitudinal trends
#   output$trendLat2 <- renderPlot({
#       if (!'raster0' %in% sel_layers()) {
#         cisl::plotTrend(as.matrix(ras()),
#                         type = "lon",
#                         colLine = "#C77F20",
#                         colPoly = "#C77F2033",
#                         maxValue = length(sel_layers()),
#                         font = 'Josefin Slab')
#       }
#   }, bg='transparent')

  # output$density <- renderPlot({
  #   if (!'raster0' %in% sel_layers()) {
  #     par(mar = c(2,2,1,0), family = 'Josefin Slab')
  #     density(ras(), bty = "n",xaxt = 'n', yaxt = "n",bg = 'transparent', col = "#C77F20", lwd = 2)
  #     mtext('Density', side = 3, line = 0)
  #     axis(side = 1, line = 0, at = seq(0, length(sel_layers()), by = (length(sel_layers()) / 5)), label = seq(0, length(sel_layers()), by = (length(sel_layers()) / 5)))
  #   }
  # }, bg='transparent')

  # # See conditionalPanel
  #   output$descrData <- renderUI({
  #     if (!'raster0' %in% sel_layers() & length(sel_layers()) == 1) {
  #     HTML({
  #       paste(
  #         '<h2>',sel_layers(),'<h2/>',
  #         '<hr /><div class="pad">',
  #         '<h3> Methodology <h3/>',
  #         '<h5>', layers[which(layers$Drivers == sel_layers()), 'method'], '<h5/>',
  #         '<h3> Reference <h3/>',
  #         '<h5>', layers[which(layers$Drivers == sel_layers()), 'reference'], '<h5/>')
  #       })
  #     }
  #   })
}
