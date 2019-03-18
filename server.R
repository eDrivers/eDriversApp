# Parameters & data
source('./code/param.R')

# pos <- sapply(layers$Drivers, function(i) input[[i]]) %>%
#        unlist() %>%
#        as.numeric(paste()) %>%
#        layers$FileName[.]


server = function(input, output, session) {

  # --------------- Functions --------------- #
  # Reactive object to get selection from user
  sel_layers <- reactive({
    pos <- input$layersTable
    if (length(pos) > 0){
      pos
    } else {
      'raster0'
    }
  })

  # Loading raster
  ras <- reactive({
    sel <- sel_layers()
    if (length(sel) > 1) {
      Reduce("+",drivers[sel])
    } else {
      drivers[sel][[1]]
    }
    # crs = "+init=epsg:3857")
  })





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
      setView(lng   = -63.50,
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
      ) %>%
      addMiniMap(
        position = "bottomright",
        tiles = providers$CartoDB.PositronNoLabels,
        toggleDisplay = TRUE
      )
  })

  couleurs <- reactive({
    cols <- c('#C7CBCE','#96A3A3','#687677','#222D3D','#25364A','#C77F20','#E69831','#E3AF16','#E4BE29','#F2EA8B')
    colorBin(
      palette  = colorRampPalette(cols)(11),
      domain   = values(ras()),
      bin      = seq(0, length(sel_layers()), by = (length(sel_layers()) / 10)),
      # bin      = seq(0, ceiling(max(values(ras()))), by = (max(values(ras())) / 10)),
      # bin      = seq(0, 1, by = .1),
      na.color = "transparent"
    )
  })

  observe({
    ### Update map
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
    # addPolygons(
    #   color       = "#000000",
    #   weight      = 1.1,
    #   opacity     = 1.0,
    #   fillOpacity = 0,
    #   fillColor   = "transparent"
    # ) %>%
    setView(lng   = -63.50,
            lat   =  48.50,
            zoom  = 6
    )

    leafletProxy(mapId = "map") %>%
    addLegend(
      position  = "bottomright",
      pal       = couleurs(),
      values    = seq(0, 1, by = .1),
      # values    =  seq(0, max(values(ras())), by = (max(values(ras()))/10)),
      title     = "Map legend",
      opacity   = 1,
      className = "info legend"
    )
    #  showNotification(raster_path())
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
