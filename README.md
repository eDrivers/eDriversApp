# shiny-tundra-cc

A Shiny application to display modelled species distribution on the Nunavik

This repository contains the complete code for running the app but with a small sample of species. The app is deployed on the ShinyApps server and can be accessed at: [https://ahasverus.shinyapps.io/bioclimaticatlas/](https://ahasverus.shinyapps.io/bioclimaticatlas/).

Before running this app, please install the following packages:

- `leaflet`
- `shiny`
- `shinyjs`
- `sp`
- `rgdal`
- `raster`
- `RColorBrewer`

To locally launch this app, type the following command lines (once you have set your working directory, i.e. the repository name):

```r
library(shiny)
runApp()
```

Enjoy!
