# Base R Shiny image
FROM rocker/geospatial:latest

RUN apt-get update && apt-get install -y 

# Copy the Shiny app code
WORKDIR /home/app
ADD . /home/app

# Install R dependencies
RUN install2.r remotes
RUN Rscript -e 'remotes::install_deps()'

# Expose the application port
EXPOSE 8083

# Run the R Shiny app
CMD Rscript -e "shiny::runApp(port = 8083, host = '0.0.0.0')"