# Parameters & data
source('./code/param.R')

# User interface setup
ui <- bootstrapPage(

  useShinyjs(),

  tags$style(
    type = "text/css",
    "
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
    #checkPanel2 {
      border:           2px solid #888;
      background-color: #ffffff;
      padding:          1%;
      opacity:          0.8;
      border-radius:    5px;
      margin-left:      0%;
      margin-top:       20%;
      height:           100%;
    }
    #layersTable {
      font-size:    12px;
      margin-top: -11%;
      margin-left: 4%;
      background-color: #ffffff00;
      font-family: 'Josefin Slab', serif;
    }
    #infoPanel {
      background-color: #ffffff;
    }
    .legend {
      width: 150px;
      font-family: 'Josefin Slab', serif;
    }
    h1 {
      font-family: 'Source Sans Pro';
      font-weight: 300;
      color:       #C77F20;
      text-align:  center;
    }
    h2 {
      font-family: 'Playfair Display', serif;
      color:          #C77F20;
      text-align:     left;
      font-size:      20px;
      margin-top:     2%;
      margin-bottom:  2%;
    }
    h3 {
      font-family: 'Josefin Slab', serif;
      font-weight:    bold;
      color:          #5f5f5f;
      text-align:     left;
      font-size:      14px;
      margin-top:     2%;
      margin-bottom:  2%;
    }
    h4 {
      font-family: 'Josefin Slab', serif;
      text-align: center;
      color:      #555;
      font-size:  16px;
    }
    h5 {
      font-family: 'Josefin Slab', serif;
      color:          #000000;
      text-align:     left;
      font-weight:    100;
      font-size:      16px;
      font-weight:    bold;
      margin-top:     5%;
      margin-left:    5%;
    }
    hr {
      color: #4e4e4e99;
      border: 1px solid;
      margin-top: 0%;
      margin-bottom:  0%;
      margin-left:  10%;
      margin-right:  10%;
    }

    label.control-label,
    .selectize-input,
    .selectize-dropdown,


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


    .control-label {
      padding-top:    10px;
      padding-bottom: 10px;
    }

    div.radio {
      margin-top:     0px;
      margin-bottom:  0px;
      padding-bottom: 5px;
    }
    button {
        background-color: #ffffff;
        border: #8c8c8c;
        color: black;
        padding: 3.25px 3.25px;
        display: inline-block;
        box-shadow: 0.5px 0.5px 0.5px 1px #bbbbbb;
    }
    #Uncheck {
      background-color: #ffffff;
      border: #8c8c8c;
      color: black;
      padding: 3px 6px;
      display: inline-block;
      border-radius: 0px;
      margin-top:-5%
    }

    "
  ),
# fluidRow(
#   column(9,
#
#   ),
#   column(3,
#
#   )
# )
# Map output
leafletOutput(outputId = "map", width = '80%', height = '100%'),

# Check box output to select drivers to visualize
absolutePanel(id        = 'checkPanel1',
              draggable = FALSE,
              left      = '14',
              top       = '130',
              height    = '610px',
              HTML('<button data-toggle="collapse" data-target="#demo">&nbsp;&#8689;&nbsp;</button>'),
              actionButton("Uncheck", label = '', icon = icon('sync')),
              tags$div(id = 'demo',  class="collapse in",
              absolutePanel(id = 'checkPanel2',
                            draggable = TRUE,
                            h5('Drivers'),
                            hr(),
                            checkboxGroupInput(inputId = 'layersTable',
                                               label = '',
                                               choiceNames = layers$Drivers,
                                               choiceValues = layers$FileName)
        ))),
absolutePanel(id = 'infoPanel',
              right = '0',
              top = '0',
              bottom = '0',
              left = '80%')


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
