# Load driver raster layers from eDrivers
# Those are the untransformed data
library(eDrivers)
library(magrittr)
library(raster)

# Get list of data
# use eDrivers::fetchList() once implemented
data(driversList)
dr <- driversList$FileName

# Load all driver layers
data(list = dr)

# Transform raster projections
# This is the projection for the leaflet map I am working with
prj <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"
for(i in dr) assign(i, raster::projectRaster(get(i), crs = prj))

# Embed drivers in a list
drivers <- mget(dr)

# Round data to the 4th decimal
for(i in 1:length(drivers)) drivers[[i]] <- round(drivers[[i]], 4)

# Create object with raw data to export and allow user to visualize untransformed data
rawDrivers <- drivers

# Log-transform drivers that should be transformed
# Name of drivers to transform
drTrans <- c('coastDev','dirHumImpact','fisheriesDD', 'fisheriesDNH','fisheriesDNL',
             'fisheriesPHB','fisheriesPLB','Hypoxia','inorgPol','invasives',
             'nutrientInput','orgPol','negSBT','posSBT','shipping')

# Log transform
id <- which(names(drivers) %in% drTrans)
for(i in id) drivers[[i]] <- log(drivers[[i]] + 1)

# Scale drivers between 0 and 1 using the 99th quantile
# Function
quantNorm <- function(x) {
  id <- x != 0
  x <- x / quantile(x[id], probs = .99, na.rm = T)
  x[x > 1] <- 1
  x[x < 0] <- 0
  x
}

# Scaling
for(i in 1:length(drivers)) drivers[[i]] <- quantNorm(drivers[[i]])

# Extract hotspots
hotspots <- drivers
for(i in 1:length(hotspots)) {
  # Raster values
  vals <- values(hotspots[[i]])

  # Identify values over 0
  id0 <- vals > 0

  # Evaluate hotspot threshold value
  th <- quantile(vals[id0], probs = .8, na.rm = T)

  # Transform raster as binary hotspot data
  hotspots[[i]] <- calc(hotspots[[i]], fun = function(x) ifelse(x > th, 1, NA))
}

# Set values <= 0 to NA
for(i in 1:length(drivers)) {
  rawDrivers[[i]][] <- ifelse(rawDrivers[[i]][] <= 0, NA, rawDrivers[[i]][])
  drivers[[i]][] <- ifelse(drivers[[i]][] <= 0, NA, drivers[[i]][])
}


# Aggregate data to reduce resolution and increase speed of app
for(i in 1:length(drivers)) {
  rawDrivers[[i]] <- aggregate(rawDrivers[[i]], fact = 1.5)
  drivers[[i]] <- aggregate(drivers[[i]], fact = 1.5)
  hotspots[[i]] <- aggregate(hotspots[[i]], fact = 1.5)
}

# # Transform data to remove decimals (multiply by 100)
# for(i in 1:length(drivers)) {
#   rawDrivers[[i]] <- rawDrivers[[i]]*100 %>% round(0)
#   drivers[[i]] <- drivers[[i]]*100 %>% round(0)
#   hotspots[[i]] <- hotspots[[i]]*100 %>% round(0)
# }
#
# Transform into raster stacks
rawDrivers <- stack(rawDrivers)
drivers <- stack(drivers)
hotspots <- stack(hotspots)

# Export drivers and hotspots list
save(rawDrivers, file = './data/rawDrivers.RData')
save(drivers, file = './data/drivers.RData')
save(hotspots, file = './data/hotspots.RData')

# # Get egslSimple from slmeta
# library(slmeta)
# data(egslSimple)
# prj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
# egslSimple <- st_transform(egslSimple, crs = prj)
# save(egslSimple, file = './data/egslSimple.RData')
