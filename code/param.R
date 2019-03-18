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


# ~~~~~~~~~~~~~~~~~~~~~~~~~   FONTS   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# font_add_google(name = 'Josefin Slab')
# bodyName <- 'Josefin Slab'


quantNorm <- function(x) {
  id <- x > 0
  x <- x / quantile(x[id], probs = .99, na.rm = T)
  x[x > 1] <- 1
  x[x < 0] <- 0
  x
}

for(i in 1:length(drivers)) values(drivers[[i]]) <- quantNorm(values(drivers[[i]]))
