# Parameters & data
source('./code/param.R')

# User interface setup
ui <- bootstrapPage(
useShinyjs(),
withMathJax(),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CSS STYLE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
tags$style(
type = "text/css",
"
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GENERAL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
html, body {
  width:   100%;
  height:  100%;
  margin:  0%;
  padding: 0%;
}
.pad {
  margin-top:    0px;
  margin-bottom: 0px;
}

label.control-label,
.selectize-input,
.selectize-dropdown,

.control-label {
  padding-top:    10px;
  padding-bottom: 10px;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LINKS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

a {
  color: #C77F20;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FONTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

h1 {
  font-family:    'Source Sans Pro';
  font-weight:    300;
  color:          #C77F20;
  text-align:     left;
  font-size:      30px;
  font-style:     italic;
  margin-top:     2%;
  margin-bottom:  2%;
}
h2 {
  font-family:    'Playfair Display', serif;
  color:          #5f5f5f;
  text-align:     left;
  font-size:      20px;
  margin-top:     2%;
  margin-bottom:  2%;
}
h3 {
  font-family:    'Josefin Slab', serif;
  font-weight:    bold;
  color:          #5f5f5f;
  text-align:     left;
  font-size:      18px;
  margin-top:     2%;
  margin-bottom:  2%;
}
h4 {
  font-family:    'Josefin Slab', serif;
  text-align:     justify;
  color:          #555;
  font-size:      14px;
  margin-left:    4%;
}
h5 {
  font-family:    'Josefin Slab', serif;
  color:          #C77F20;
  text-align:     left;
  font-weight:    100;
  font-size:      16px;
  font-weight:    bold;
  font-style:     italic;
  margin-top:     5%;
  margin-left:    5%;
}
h6 {
  font-family:    'Josefin Slab', serif;
  font-style:     italic;
  color:          #C77F20;
  text-align:     center;
  font-size:      24px;
  margin-top:     2%;
  margin-bottom:  2%;
}
hr {
  color:          #4e4e4e99;
  border:         1px solid;
  margin-top:     0%;
  margin-bottom:  0%;
  margin-left:    10%;
  margin-right:   10%;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INTERACTIVE MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#map {
  margin:        0;
  margin-left:   0%;
  margin-right:  0%;
  margin-top:    0%;
  margin-bottom; 0%;
  border:        0px solid #888;
  border-radius: 0px;
  z-index:       0;
}
.legend {
  width:       155px;
  font-family: 'Josefin Slab', serif;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PANELS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#checkPanel2 {
  border:           2px solid #888;
  background-color: #ffffff;
  padding:          1%;
  opacity:          0.8;
  border-radius:    5px;
  margin-left:      0%;
  margin-top:       10%;
  height:           100%;
}

#infoPanel {
  background-color: #ffffff;
  margin-left:      1%;
  margin-right:     1.5%;
  margin-top:       1%;
  overflow-y:       scroll;
}

#warningMSG {
  pointer-events:   none;
  position:         absolute;
  transform:        translate(-50%, -50%);
}


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
table {
  text-align: center;
  width: 95%;
  height: 100px;
  border-bottom: 1px solid #4e4e4e99;
}

th {
  text-align: center;
  border-bottom: 1px solid #4e4e4e99;
  border-top: 1px solid #4e4e4e99;
}

#rawData {
  font-size:        12px;
  margin-top:       -5%;
  margin-left:      4%;
  font-weight:      200;
  background-color: #ffffff00;
  font-family:      'Josefin Slab', serif;
}

#dataType {
  font-size:        12px;
  margin-top:       -10%;
  margin-left:      4%;
  font-weight:      200;
  background-color: #ffffff00;
  font-family:      'Josefin Slab', serif;
}

#layersTable {
  font-size:        12px;
  margin-top:       -5%;
  margin-left:      4%;
  background-color: #ffffff00;
  font-family:      'Josefin Slab', serif;
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BUTTONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
button {
  background-color: #ffffff;
  border:           #8c8c8c;
  color:            black;
  padding:          3px 3.1px;
  display:          inline-block;
  box-shadow:       0.5px 0.5px 0.5px 1px #bbbbbb;
}
#Uncheck {
  background-color: #ffffff;
  border:           #8c8c8c;
  color:            black;
  padding:          3px 7px;
  display:          inline-block;
  border-radius:    0px;
  margin-top:       -4%
}
#CheckAll {
  background-color: #ffffff;
  border: #8c8c8c;
  color: black;
  padding: 3px 7px;
  display: inline-block;
  border-radius: 0px;
  margin-top:-4%
}
div.radio {
  margin-top:     0px;
  margin-bottom:  0px;
  padding-bottom: 5px;
}


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PLOTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#trendLat1 {
  font-family: 'Josefin Slab', serif;
  margin-top:     3%;
  margin-bottom:  3%;
}
#trendLat2 {
  margin-top:    3%;
  margin-bottom: 3%;
}
#density {
  margin-top:    3%;
  margin-bottom: 3%;
}





"
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
                                         selected = 'rawData'),

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
                                               selected = layers$FileName)

        ))),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~ INFORMATION PANEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

absolutePanel(id = 'infoPanel',
              right = '0',
              top = '0',
              bottom = '0',
              left = '80%',
              htmlOutput('descrData'),
              div(plotOutput('condPlot',  width = '90%', height = '300px'), align = 'center'),
              htmlOutput('dataOverview')
            ),

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WARNING PANEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# absolutePanel(id = 'warningPanel',
#               right = '35%',
#               top = '30%',
#               bottom = '30%',
#               left = '25%',
#               absolutePanel(id = 'msg',
#                             top = '50%',
#                             left = '50%',
#                             right = '25%',
#                             bottom = '25%',
#                             htmlOutput('warningMSG')
#                             )
#               )
conditionalPanel(condition = "length(input.layersTable) > 1 && input.rawData == 'rawData'",
                 absolutePanel(id = 'warningMessage',
                               top = '50%',
                               left = '50%',
                               right = '20%',
                               bottom = '20%',
                               htmlOutput('warningMSG')
                              ))



#
# absolutePanel(
#   id        = 'panel2',
#   style     = 'background-color:"#ffffff";padding:1%;opacity:1;border-radius:5px;', #border:2px solid #888;
#   left      = '60.50%', #71.5
#   top       = '62.50%', #4.5
#   draggable = TRUE,
#   height    = '33%',
#   width     = '25%',
#   plotOutput(outputId = 'trendLat1', width = '100%', height = '33%'),
#   plotOutput(outputId = 'trendLat2', width = '100%', height = '33%'),
#   plotOutput(outputId = 'density', width = '100%', height = '33%')),

  # absolutePanel(id = 'panel4',
  #               style = 'background-color:"#ffffff00";',
  #               left      = '74%',
  #               top       = '4.5%',
  #               draggable = TRUE,
  #               height    = '33%',
  #               width     = '22.5%',
  #               HTML('<button data-toggle="collapse"      data-target="#demo2">&nbsp;&#8689;&nbsp;</button>'),
  #               tags$div(id = 'demo2',  class="collapse in",
  #                 absolutePanel(
  #                   id        = 'panel5',
  #                   style     = 'background-color:#ffffff00;padding:1%;opacity:1;overflow-y:scroll; max-height: 600px;',
  #                   left      = '10%',
  #                   top       = '0%',
  #                   draggable = TRUE,
  #                   height    = '100%',
  #                   width     = '85%',
  #                   htmlOutput('descrData')
  #                 )
  #               )
  #             )
)
#
