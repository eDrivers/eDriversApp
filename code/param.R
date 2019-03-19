# ~~~~~~~~~~~~~~~~~~~~~~~~~   Libraries   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
library(leaflet)
library(shiny)
library(shinyjs)
# library(sp)
library(raster)
# library(rgdal)
# library(RColorBrewer)
# library(slmeta)
library(magrittr)
# library(showtext)
# library(curl)
library(eDrivers)
# library(matrixStats)



# ~~~~~~~~~~~~~~~~~~~~~~~~~   DATA   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
load('./data/drivers.RData')
load('./data/hotspots.RData')
load('./data/egslSimple.RData')
data(driversList)

# ~~~~~~~~~~~~~~~~~~~~~~~~~   FUNCTIONS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
source('./code/histDriver.R')
source('./code/histFd.R')

# ~~~~~~~~~~~~~~~~~~~~~~~~~   TEXTS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
source('./code/eDrivers.R')

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
