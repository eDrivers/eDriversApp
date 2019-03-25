dataDesc <- function(id) {
  paste(
    # '<h1>',driversList$Drivers[id],'<h1/>',
    '<h1>',driversList$Groups[id],'<h1/>',
    '<h2>',driversList$Drivers[id],'<h2/>',
    '<br/>',
    '<hr /><div class="pad">',
    '<br/>',
    '<h3>Data description<h3/>',
    '<h4><b>Spatial resolution</b>: ',driversList$SpatRes[id],'<h4/>',
    '<h4><b>Temporal resolution</b>: ',driversList$TempRes[id],'<h4/>',
    '<h4><b>Years</b>: ',driversList$Years[id],'<h4/>',
    '<h4><b>Units</b>: ',withMathJax(driversList$Units[id]),'<h4/>',
    '<h4><b>Transformations</b>: ',driversList$DataTrans[id],'<h4/>',
    '<br/>',
    '<h3>Source &nbsp;', ifelse(driversList$SourceLink[id] != '',
                          paste0('<a href="',driversList$SourceLink[id],'" target="_blank"><i class="fa fa-globe" aria-hidden="true"></i></a><h3/>'),
                          '<h3/>'),
    '<h4>',driversList$Source[id],'<h4/>',
    '<br/>'
  )
}

dataOver <- function(id) {
  paste(
    '<br/>',
    '<h3>Overview<h3/>',
    '<h4>',driversList$Overview[id],'<h4/>',
    '<br/>'
  )
}
