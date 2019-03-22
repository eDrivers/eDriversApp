histHotspot <- function(x) {
  col1 <- '#424242'
  par(mar = c(4, 4, 1.5, 1.5),
      # family = 'Josefin Slab',
      bg = 'transparent',
      col.lab = col1,
      col.axis = col1,
      fg = col1)

  barplot(x,
          ylim = c(0, 20000),
          xlim = c(0,14),
          col = cols[6],
          border = paste0(cols[4], '55'),
          main = '',
          xlab = 'Hotspots overlap',
          ylab = 'Frequency',
          cex.axis = .8,
          cex.names = .8)
}
