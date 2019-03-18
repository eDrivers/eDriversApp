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

# Normalize drivers
quantNorm <- function(x) {
  id <- x > 0
  x <- x / quantile(x[id], probs = .99, na.rm = T)
  x[x > 1] <- 1
  x[x < 0] <- 0
  x
}

for(i in dr) assign(i, quantNorm(get(i)))

# Transform raster projections
prj <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"
for(i in dr) assign(i, raster::projectRaster(get(i), crs = prj))

# Make raster0
raster0 <- raster(vals = NA,
                  nrow = 1,
                  ncol = 1,
                  ext = extent(get(dr[1])),
                  crs = prj)


# Embed drivers and raster0 in a list
drivers <- mget(dr)
drivers$raster0 <- raster0

# Export drivers list
save(drivers, file = './data/drivers.RData')

# Get egslSimple from slmeta
library(slmeta)
data(egslSimple)
prj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
egslSimple <- st_transform(egslSimple, crs = prj)
save(egslSimple, file = './data/egslSimple.RData')
