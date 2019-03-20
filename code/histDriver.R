histDriver <- function(x) {
  col1 <- '#424242'
  par(mar = c(4, 4, 1.5, 1.5),
      # family = 'Josefin Slab',
      bg = 'transparent',
      col.lab = col1,
      col.axis = col1,
      fg = col1)

  hist(x[x > 0],
       prob = T,
       main = '',
       xlab = 'Intensity',
       ylab = 'Frequency',
       col = cols[6],
       border = paste0(cols[4], '55'),
       breaks = 100)
}
