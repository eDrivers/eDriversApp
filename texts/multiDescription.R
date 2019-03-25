multiDesc <- function(type) {
  if (type == 'footprint') {
    paste(
      '<h1>','Cumulative intensity','<h1/>',
      '<br/>',
      '<hr/><div class="pad">',
      '<br/>'
    )
  } else {
    paste(
      '<h1>','Cumulative hotspots','<h1/>',
      '<br/>',
      '<hr/><div class="pad">',
      '<br/>'
    )
  }
}
