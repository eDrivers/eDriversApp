# Parameters & data
source('./code/param.R')

# User interface setup
ui <- bootstrapPage(
useShinyjs(),
withMathJax(),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CSS STYLE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "eDrivers.css")
),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INTERACTIVE MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Map output
leafletOutput(outputId = "map", width = '80%', height = '100%'),

# Check box output to select drivers to visualize
absolutePanel(id = 'checkPanel1',
              draggable = FALSE,
              left = '14',
              top = '130',
              height = '690px',

              # Collapse button
              HTML('<button data-toggle="collapse" data-target="#demo">&nbsp;&#8689;&nbsp;</button>'),

              # Check all button
              actionButton("CheckAll", label = '', icon = icon('check-square')),

              # Uncheck button
              actionButton("Uncheck", label = '', icon = icon('sync')),

              # Collapsable and selectable driver table
              tags$div(id = 'demo',  class="collapse in",
              absolutePanel(id = 'checkPanel2',
                            draggable = TRUE,
                            h5('Drivers'),
                            hr(),

                            # Raw vs transformed data choice
                            radioButtons(inputId = 'rawData',
                                         label = '',
                                         inline = T,
                                         choiceNames = c('Raw data','Transformed'),
                                         choiceValues = c('rawData','transformed'),
                                         selected = 'transformed'),

                            # Hotspots vs footprint choice
                            radioButtons(inputId = 'dataType',
                                         label = '',
                                         inline = T,
                                         choiceNames = c('Footprint','Hotspots'),
                                         choiceValues = c('footprint','hotspots'),
                                         selected = 'footprint'),

                            hr(),

                            # Drivers table
                            checkboxGroupInput(inputId = 'layersTable',
                                               label = '',
                                               choiceNames = layers$Drivers,
                                               choiceValues = layers$FileName,
                                               selected = '')

        ))),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~ INFORMATION PANEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
conditionalPanel(condition = 'input.layersTable.length < 1',
                 absolutePanel(id = 'infoPanel',
                               right = '0',
                               top = '0',
                               bottom = '0',
                               left = '80%',
                               htmlOutput('eDrivers'))),

conditionalPanel(condition = 'input.layersTable.length == 1',
                 absolutePanel(id = 'infoPanel',
                               right = '0',
                               top = '0',
                               bottom = '0',
                               left = '80%',
                               htmlOutput('dataDescription'),
                               div(plotOutput('singlePlot', width = '95%', height = '300px'),align = 'center'),
                               htmlOutput('dataOverview'))),
#
conditionalPanel(condition = 'input.layersTable.length > 1 && input.rawData == "transformed"',
                 absolutePanel(id = 'infoPanel',
                               right = '0',
                               top = '0',
                               bottom = '0',
                               left = '80%',
                               htmlOutput('multiDescription'),
                               div(plotOutput('multiPlot', width = '95%', height = '700px'),align = 'center'))),


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WARNING PANEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
conditionalPanel(condition = "length(input.layersTable) > 1 && input.rawData == 'rawData'",
                 absolutePanel(id = 'warningMessage',
                               top = '50%',
                               left = '50%',
                               right = '20%',
                               bottom = '20%',
                               htmlOutput('warningMSG')
                              ))

)
#
