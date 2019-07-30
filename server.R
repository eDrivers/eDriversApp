# Parameters & data
source('./code/param.R')


server = function(input, output, session) {

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
sel <- reactive(input$layersTable) # Selected drivers
nSel <- reactive(length(sel())) # Number of selected drivers
type <- reactive(input$dataType) # Selected type of data (footprint vs hotspot)
trans <- reactive(input$rawData) # Selected type of data (raw vs transformed data)
id <- reactive(which(driversList$FileName %in% sel())) # ID of selected drivers in data table


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Loading raster ----------------------------------------------------
ras <- reactive({
  # Select proper layer depending on user selection
  if (length(sel()) == 0) {
    raster0
  } else if (length(sel()) == 1 && trans() == 'rawData') {
    if(type() == 'footprint') {
      rawDrivers[[sel()]]
    } else {
      hotspots[[sel()]]
    }  } else if (length(sel()) == 1 && trans() == 'transformed') {
    if(type() == 'footprint') {
      drivers[[sel()]]
    } else {
      hotspots[[sel()]]
    }
  } else if (length(sel()) > 1 && trans() == 'rawData') {
    raster0
  } else if (length(sel()) > 1 && trans() == 'transformed') {
    if(type() == 'footprint') {
      sum(drivers[[sel()]], na.rm = T) %>%
      calc(function(x) ifelse(x == 0, NA, x))
    } else {
      sum(hotspots[[sel()]], na.rm = T) %>%
      calc(function(x) ifelse(x == 0, NA, x))
    }
  }
  # crs = "+init=epsg:3857")
})

# Raster values ----------------------------------------------------
vals <- reactive({
  if(nSel() > 0 && trans() == 'transformed') {
    val <- ras() %>%
            maxValue() %>%
            ceiling() %>%
            seq(0, ., by = ./10)
  } else if(nSel() == 1 && trans() == 'rawData') {
    val <- ras() %>%
            maxValue() %>%
            ceiling() %>%
            seq(0, ., by = ./10)
  } else {
    val <- seq(0, 1, by = .1)
  }
})

# Colors ----------------------------------------------------
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
  leaflet() %>%
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
                               choiceNames = `layers$Drivers`,
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

# ~~~~~~~~~~~~~~~ PLATFORM ~~~~~~~~~~~~~~~ #
output$eDrivers <- renderUI({
  HTML(eDrivers)
})

# ~~~~~~~~~~~~ SINGLE DRIVER ~~~~~~~~~~~~~ #
# To make reactivity better, but this is definitely not the most efficient way to do it!
# Need to figure out a better way at some point!

# Reactive object for data description
dataDescReactive <- reactive({
  if (nSel() == 1) HTML(dataDesc(id()))
})

# Reactive object for data overview
dataOverReactive <- reactive({
  if (nSel() == 1) HTML(dataOver(id()))
})

# Render data description
output$dataDescription <- renderUI(
  dataDescReactive()
)

# Render data overview
output$dataOverview <- renderUI(
  dataOverReactive()
)

# ~~~~~~~~~~~~~ MULTIPLE DRIVERS ~~~~~~~~~~~~~ #
output$multiDescription <- renderUI({
  HTML(multiDesc(type()))
})


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~ WARNING MESSAGE ~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
output$warningMSG <- renderUI({
# ~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~~ MESSAGE ~~~~~~~~~~~~~~~~~ #
if(nSel() > 1 && trans() == 'rawData') {
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
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PLOTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~ SINGLE DRIVER ~~~~~~~~~~~~~~ #
output$singlePlot <- renderPlot({
  if (nSel() == 1) {
    if (type() == 'footprint') histDriver(ras())
    if (type() == 'hotspots') histHotspot(ras())
  }
})

# ~~~~~~~~~~~~ MULTIPLE DRIVERS ~~~~~~~~~~~~ #
output$multiPlot <- renderPlot({
  if (nSel() > 1) {
    if (type() == 'footprint' && trans() == 'transformed') cumulIntensity(sel(), ras())
    if (type() == 'hotspots'  && trans() == 'transformed') cumulHotspots(sel(), ras())
  }
})

} # End
