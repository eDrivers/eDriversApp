# # ~~~~~~~~~~~~~~~~~~~~~~~~~   Libraries   ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# library(leaflet)
# library(shiny)
# library(shinyjs)
# library(raster)
# library(magrittr)
# library(sf)
# # load('./data/marimekkoFd.RData')
# # load('./data/drivers.RData')
# load('./data/dr.RData')
# load('./data/driversList.RData')
# # sel <- input$layersTable
# sel <- c('aquacultureInv','fisheriesDD')
# sel <- c('Aragonite','Hypoxia')
# sel <- colnames(hot)


cumulIntensity <- function(sel, ras) {
    # ~~~~~~~~~~~~~~~~~~~ DATA PREPARATION ~~~~~~~~~~~~~~~~~~~ #
  # Create vector of bins
  nBins <- 250 # Just because
  binData <- seq(0, 12, length.out = 251)
  bins <- data.frame(lower = binData[1:250],
                     upper = binData[2:251])
  bins <- (bins$upper + bins$lower) / 2

  # Extract data for marimekko graph
  binData <- dr[, sel] %>% # Select only selected variables
             replace(is.na(.), 0) %>% # Replace NAs by 0
             dplyr::mutate(fd = rowSums(., na.rm = T)) %>% # Calculate cumulative intensity
             dplyr::mutate(bins = cut(.$fd, breaks = seq(0,12*1000,length.out=250))) %>% # Split into bins
             na.omit() %>% # Remove NAs
             dplyr::group_by(bins) %>% # Group by bins
             dplyr::summarise_all(dplyr::funs(sum)) %>% # Calculate sum of intensity per driver per bin group
             dplyr::mutate_at(dplyr::vars(-fd, -bins), dplyr::funs(. / fd)) %>% # Divide by cumulative intensity to get proportion
             dplyr::select(-fd) %>% # Remove cumulative intensity
             dplyr::mutate(bins = as.numeric(bins)) # Identify which bin groups are left

  # Coordinates of bins
  bins <- bins[binData$bins]

  # Cumulative sum of rows
  binData <- apply(binData[,-1], 1, cumsum)

  # Add row filled with 0 to build first polygon
  binData <- rbind(numeric(length(bins)), binData)

  # Select only relevant names in names data.frame
  # drNames <- marimekkoFd$names[marimekkoFd$names$FileName %in% sel, ]


  # ~~~~~~~~~~~~~~~~~~~ LAYOUT ~~~~~~~~~~~~~~~~~~~ #
  # png('./figures/marimekko.png', width = 1800, height = 800, res = 200, pointsize = 8)
  mat <- matrix(ncol = 10, nrow = 24, data = 1)
  mat[5:13, ] <- 2
  mat[13:24, ] <- 3
  layout(mat)
  # layout.show(3)

  # ~~~~~~~~~~~~~~~~~~~ HISTOGRAM ~~~~~~~~~~~~~~~~~~~ #
  col1 <- '#424242'
  par(mar = c(0,4.5,.5,0),
      # family = 'Josefin Slab',
      bg = 'transparent',
      col.lab = col1,
      col.axis = col1,
      fg = col1)

    hist(ras[ras > 0],
         prob = T,
         main = '',
         axes = FALSE,
         xlab = '',
         ylab = '',
         col = cols[6],
         border = paste0(cols[4], '44'),
         breaks = 100,
         xlim = c(0,12))
    # axis(1, at = 0:12, cex.axis = .9)
    axis(2, cex.axis = .9, las = 2)
    mtext(text = 'Frequency', side = 2, line = 3.25, cex = .9)

  # ~~~~~~~~~~~~~~~~~~~ MARIMEKKO ~~~~~~~~~~~~~~~~~~~ #
  par(mar = c(4,4.5,0,0),
  bg = 'transparent',
  col.lab = col1,
  col.axis = col1,
  fg = col1)

  # Empty plot
  plot(0, ann = FALSE, axes = FALSE, type = "n",
        xlim = c(0, 12),
        ylim = c(0, 1))

  # Plot elements
  axis(1, at = 0:12, cex.axis = .9)
  axis(2, cex.axis = .9, las = 2)
  mtext(text = 'Cumulative intensity', side = 1, line = 2.25, cex = .9)
  mtext(text = 'Relative contribution (%)', side = 2, line = 3.25, cex = .9)

  # Polygons
  for(i in 1:(nrow(binData)-1)) {
    y1 <- binData[i, ]
    y2 <- binData[i+1, ]
    polygon(x = c(bins, rev(bins), bins[1]),
            y = c(y1, rev(y2), y1[1]),
            col = driversList$col[driversList$FileName == sel[i]],
            border = 'transparent')
  }

  # ~~~~~~~~~~~~~~~~~~~ LEGEND ~~~~~~~~~~~~~~~~~~~ #
  # Param
  nDr <- nrow(driversList)
  y <- seq(.1,.9, length.out = nDr+1)

  y <- data.frame(y1 = y[1:nDr],
                  y2 = y[2:(nDr+1)])
  x1 <- 0
  x2 <- .1
  y$mid <- (y$y1+y$y2)/2
  ygap <- .005

  # Par
  par(mar = c(4,0,0,0))

  # Empty plot
  plot(0, ann = FALSE, axes = FALSE, type = "n",
        xlim = c(-.3, 1.1),
        ylim = c(0, 1))

  # Polygons
  for(i in 1:nDr) {
    y1 <- y$y1[i]+ygap
    y2 <- y$y2[i]-ygap
    polygon(x = c(x1, x2, x2, x1, x1),
            y = c(y1, y1, y2, y2, y1),
            col = driversList$col[i],
            border = '#000000')
  }

  # Text
  text(x = rep(.15, ncol(dr)), y = y$mid, labels = driversList$Drivers, adj = c(0,.5), cex = 1.15)

  # Groups
  for(i in levels(factor(driversList$Groups))) {
    id <- driversList$Groups == i
    Y <- sum(range(y$mid[id])) / 2
    text(x = -.35, y = Y, labels = i, adj = c(0,.5), font = 2, cex = 1.15)
  }
}
