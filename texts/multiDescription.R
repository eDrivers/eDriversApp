multiDesc <- function(type) {
  if (type == 'footprint') {
    paste(
      '<h1>','Cumulative intensity','<h1/>',
      '<br/>',
      '<hr/><div class="pad">',
      '<br/>',
      '<h3>Visualization description</h3>',
      '<h4>Frequency distribution of cumulative intensity (i.e. sum of transformed driver intensity in each grid cell) and percent contribution of each driver to the frequency distribution of cumulative intensity.</h4>',
      '<br/>'
    )
  } else {
    paste(
      '<h1>','Cumulative hotspots','<h1/>',
      '<br/>',
      '<hr/><div class="pad">',
      '<br/>',
      '<h3>Visualization description</h3>',
      '<h4>Frequency distribution of cumulative hotspots (i.e. sum of 80th quantile of drivers in each grid cell) and percent contribution of each driver to the frequency distribution of cumulative hotspots.</h4>',
      '<br/>'
    )
  }
}
