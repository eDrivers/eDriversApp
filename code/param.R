# ~~~~~~~~~~~~~~~~~~~~~~~~~   Libraries   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
library(raster)
library(leaflet)
library(shiny)
library(shinyjs)
library(magrittr)
library(sf)
library(dplyr)
library(tidyr)

# ~~~~~~~~~~~~~~~~~~~~~~~~~   DATA   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
load('./data/rawDrivers.RData')
load('./data/drivers.RData')
load('./data/hotspots.RData')
load('./data/dr.RData')
load('./data/hot.RData')

# ~~~~~~~~~~~~~~~~~~~~~~~~~   FUNCTIONS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
source('./code/histDriver.R')
source('./code/histHotspot.R')
source('./code/cumulIntensity.R')
source('./code/cumulHotspots.R')

# ~~~~~~~~~~~~~~~~~~~~~~~~~   TEXTS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# load('./data/driversList.RData')
source('./texts/driversList.R')
source('./texts/eDrivers.R')
source('./texts/dataDescription.R')
source('./texts/multiDescription.R')

# ~~~~~~~~~~~~~~~~~~~~~~~~~   RASTER0   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
prj <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"
raster0 <- raster(vals = NA,
                  nrow = 1,
                  ncol = 1,
                  ext = extent(drivers),
                  crs = prj)


# ~~~~~~~~~~~~~~~~~~~~~~~~~   PARAMETERS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
layers <- driversList
nDr <- nrow(layers)

# # Insert checkboxes in table
# layers$checkbox <- sprintf('<input type="checkbox" name="%s" value="%s"/>',
#                            layers$FileName,
#                            1:nDr)

# Colors
cols <- c('#C7CBCE','#96A3A3','#687677','#222D3D','#25364A','#C77F20','#E69831','#E3AF16','#E4BE29','#F2EA8B')


# ~~~~~~~~~~~~~~~~~~~~~~~~~   FONTS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Font
# showtext_auto()
# font_add(family = 'Playfair', regular = 'PlayfairDisplay-Italic.ttf')
# font_add(family = 'Playfair2', regular = 'PlayfairDisplay-BoldItalic.ttf')
# font_add(family = 'Josefin', regular = 'JosefinSla-BoldItalic.ttf')
# font_add_google(name = 'Josefin Slab')
