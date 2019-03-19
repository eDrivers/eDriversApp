# Load driver raster layers from eDrivers
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
prj <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"
for(i in dr) assign(i, raster::projectRaster(get(i), crs = prj))

# Normalize drivers (to remove later)
quantNorm <- function(x) {
  id <- x > 0
  x <- x / quantile(x[id], probs = .99, na.rm = T)
  x[x > 1] <- 1
  x[x < 0] <- 0
  x
}
for(i in dr) assign(i, quantNorm(get(i)))

# Embed drivers in a list
drivers <- mget(dr)

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

# Transform into raster stacks
drivers <- stack(drivers)
hotspots <- stack(hotspots)

# Round drivers data
drivers <- round(drivers, 2)

# Export drivers and hotspots list
save(drivers, file = './data/drivers.RData')
save(hotspots, file = './data/hotspots.RData')

# Get egslSimple from slmeta
library(slmeta)
data(egslSimple)
prj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
egslSimple <- st_transform(egslSimple, crs = prj)
save(egslSimple, file = './data/egslSimple.RData')
