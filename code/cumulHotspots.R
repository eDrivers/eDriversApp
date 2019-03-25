cumulHotspots <- function(sel, ras) {
  # Create vector of bins
  nBins <- 13
  binData <- 0:13
  bins <- data.frame(lower = binData[1:250],
                     upper = binData[2:251])
  bins <- (bins$upper + bins$lower) / 2
  bins <- 1:13

  # Extract data for graph
  binData <- hot[, sel] %>% # Select only selected variables
             replace(is.na(.), 0) %>% # Replace NAs by 0
             dplyr::mutate(hot = rowSums(., na.rm = T)) %>% # Calculate cumulative hotspots
             dplyr::mutate(bins = cut(.$hot, breaks = 0:13)) %>% # Split into bins
             na.omit() %>% # Remove NAs
             dplyr::group_by(bins) %>% # Group by bins
             dplyr::summarise_all(dplyr::funs(sum)) %>% # Calculate sum of intensity per driver per bin group
             {. ->> freqData} %>% # Save as intermediate object
             dplyr::mutate_at(dplyr::vars(-hot, -bins), dplyr::funs(. / hot)) %>% # Divide by cumulative intensity to get proportion
             dplyr::select(-hot) %>% # Remove cumulative intensity
             dplyr::mutate(bins = as.numeric(bins)) # Identify which bin groups are left

  # Coordinates of bins
  bins <- bins[binData$bins]

  # Cumulative sum of rows
  binData <- apply(binData[,-1], 1, cumsum)

  # Add row filled with 0 to build first polygon
  binData <- rbind(numeric(length(bins)), binData)

  # ~~~~~~~~~~~~~~~~~~~ LAYOUT ~~~~~~~~~~~~~~~~~~~ #
  # png('./figures/marimekko.png', width = 1800, height = 800, res = 200, pointsize = 8)
  mat <- matrix(ncol = 10, nrow = 24, data = 1)
  mat[5:13, ] <- 2
  mat[13:24, ] <- 3
  layout(mat)
  # layout.show(3)

  # ~~~~~~~~~~~~~~~~~~~~~~~ BARPLOT ~~~~~~~~~~~~~~~~~~~~~~~ #
  col1 <- '#424242'
  par(mar = c(0,4.5,0,0),
      # family = 'Josefin Slab',
      bg = 'transparent',
      col.lab = col1,
      col.axis = col1,
      fg = col1)

  # Empty plot
  plot(0, ann = FALSE, axes = FALSE, type = "n",
       xlim = c(0.5, 13.5),
       ylim = c(0, 25000))

   # Plot elements
   axis(2, cex.axis = .9, las = 2)
   mtext(text = 'Frequency', side = 2, line = 3.25, cex = .9)

   # Polygons
   xGap <- .25
   for(i in 1:nrow(binData)) {
     y <- freqData$hot[i]
     polygon(x = c(bins[i]-xGap, bins[i]+xGap, bins[i]+xGap, bins[i]-xGap),
             y = c(0, 0, y, y),
             col = cols[6],
             border = cols[4])
   }

  # ~~~~~~~~~~~~~~~~~~~ STACKED BARPLOT ~~~~~~~~~~~~~~~~~~~ #
  col1 <- '#424242'
  par(mar = c(4,4.5,0,0),
  bg = 'transparent',
  col.lab = col1,
  col.axis = col1,
  fg = col1)

  # Empty plot
  plot(0, ann = FALSE, axes = FALSE, type = "n",
        xlim = c(0.5, 13.5),
        ylim = c(0, 1))

  # Plot elements
  mtext(1:13, side = 1, at = 1:13, cex = .75)
  axis(2, cex.axis = .9, las = 2)
  mtext(text = 'Cumulative hotspots', side = 1, line = 2.25, cex = .9)
  mtext(text = 'Relative contribution (%)', side = 2, line = 3.25, cex = .9)

  # Polygons
  for(i in 1:(nrow(binData)-1)) {
    for(j in 1:ncol(binData)) {
      y1 <- binData[i, j]
      y2 <- binData[i+1, j]
      polygon(x = c(bins[j]-xGap, bins[j]+xGap, bins[j]+xGap, bins[j]-xGap),
              y = c(y1, y1, y2, y2),
              col = driversList$col[driversList$FileName == sel[i]],
              border = 'transparent')
    }
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
