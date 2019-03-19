# ~~~~~~~~~~~~~~~~~~~~~~~~~   Libraries   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
library(leaflet)
library(shiny)
library(shinyjs)
# library(sp)
library(raster)
# library(rgdal)
library(RColorBrewer)
# library(slmeta)
library(magrittr)
library(showtext)
library(curl)
library(eDrivers)
# library(matrixStats)



# ~~~~~~~~~~~~~~~~~~~~~~~~~   Data   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
load('./data/drivers.RData')
load('./data/egslSimple.RData')
data(driversList)

# ~~~~~~~~~~~~~~~~~~~~~~~~~   PARAMETERS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
layers <- driversList
nDr <- nrow(layers)

# Insert checkboxes in table
layers$checkbox <- sprintf('<input type="checkbox" name="%s" value="%s"/>',
                           layers$FileName,
                           1:nDr)

# Colors
cols <- c('#C7CBCE','#96A3A3','#687677','#222D3D','#25364A','#C77F20','#E69831','#E3AF16','#E4BE29','#F2EA8B')


# ~~~~~~~~~~~~~~~~~~~~~~~~~   FONTS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# font_add_google(name = 'Josefin Slab')
# bodyName <- 'Josefin Slab'
