# Parameters & data
source('./code/param.R')


server = function(input, output, session) {

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Loading raster
ras <- reactive({
  # Selected drivers
  sel <- input$layersTable

  # Selected type of data (footprint vs hotspot)
  type <- input$dataType

  # Select proper layer depending on user selection
  if (length(sel) == 0) {
    raster0
  } else if (length(sel) == 1){
  if(type == 'footprint') {
      drivers[[sel]]
    } else {
      hotspots[[sel]]
    }
  } else if (length(sel) > 1) {
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
  if(length(input$layersTable) > 0) {
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
    map <- leaflet(
      data = egslSimple
    ) %>%
    addProviderTiles(
      provider = providers$CartoDB.Positron
    ) %>%
    addPolygons(
      color = "#000000",
      weight = 0.5,
      opacity = 1.0,
      fillOpacity = 0,
      fillColor = "transparent"
    ) %>%
    setView(lng   = -65,
            lat   =  48.50,
            zoom  = 6
    ) %>%
    addEasyButton(
      easyButton(
        icon = "fa-globe",
        title = "Zoom to Level 1",
        onClick = JS(
          "function(btn, map){ map.setZoom(6); }"
        )
      )
    ) # %>%
    # addMiniMap(
    #   position = "bottomright",
    #   tiles = providers$CartoDB.PositronNoLabels,
    #   toggleDisplay = TRUE
    # )
})

# Update map
observe({
  leafletProxy(
    mapId = "map",
    data  = egslSimple) %>%
  clearShapes() %>%
  clearControls() %>%
  clearImages() %>%
  addRasterImage(
    x       = ras(),
    colors  = couleurs(),
    opacity = .75,
    project = FALSE
  ) %>%
  setView(lng   = -65,
          lat   =  48.50,
          zoom  = 6
  )

  leafletProxy(mapId = "map") %>%
  addLegend(
    position  = "bottomright",
    pal       = couleurs(),
    values    = vals(),
    title     = "Map legend",
    opacity   = 1,
    className = "info legend"
  )
  #  showNotification(raster_path())
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
