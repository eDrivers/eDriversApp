df <- data.frame(Groups = character(),
                 Drivers = character(),
                 FileName = character(),
                 Accronym = character(),
                 SpatRes = character(),
                 TempRes = character(),
                 Years = character(),
                 Units = character(),
                 Source = character(),
                 stringsAsFactors = F)

# &Omega;



df[1,] <- c("Climate","Aragonite","Aragonite","ARAG","\\(Lat/long\\)","August-September","2018",'\\(\\Omega\\) \\(Aragonite\\)',"Starr, M. (2019a). Reference to come, aragonite and hypoxia.")
df[2,] <- c("Climate","Hypoxia","Hypoxia","HYP","\\(Lat/long\\)","August-September","2018","\\(ml * L^{-1}\\)","Starr, M. (2019a). Reference to come, aragonite and hypoxia.")
df[3,] <- c("Climate","Negative sea bottom temperature anomalies","negSBT","SBT-","\\(~2 km^2\\)","Monthly","1981-2010 vs. 2013-2017","number (\\(n\\)) negative anomalies","Galbraith, P. S., Chassé, J., Caverhill, C., Nicot, P., Gilbert, D., Lefaivre, D., et al. (2018). Physical Oceanographic Conditions in the Gulf of St. Lawrence during 2017. Department of Fisheries; Oceans Available at: http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_050-fra.html [Accessed November 26, 2018].")
df[4,] <- c("Climate","Positive sea bottom temperature anomalies","posSBT","SBT+","\\(~2 km^2\\)","Monthly","1981-2010 vs. 2013-2017","number (\\(n\\)) positive anomalies","Galbraith, P. S., Chassé, J., Caverhill, C., Nicot, P., Gilbert, D., Lefaivre, D., et al. (2018). Physical Oceanographic Conditions in the Gulf of St. Lawrence during 2017. Department of Fisheries; Oceans Available at: http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_050-fra.html [Accessed November 26, 2018].")
df[5,] <- c("Climate","Negative sea surface temperature anomalies","negSST","SST-","\\(~2 km^2\\)","Monthly","1981-2010 vs. 2013-2017","number (\\(n\\)) negative anomalies","Galbraith, P. S., Chassé, J., Caverhill, C., Nicot, P., Gilbert, D., Lefaivre, D., et al. (2018). Physical Oceanographic Conditions in the Gulf of St. Lawrence during 2017. Department of Fisheries; Oceans Available at: http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_050-fra.html [Accessed November 26, 2018].")
df[6,] <- c("Climate","Positive sea surface temperature anomalies","posSST","SST+","\\(~2 km^2\\)","Monthly","1981-2010 vs. 2013-2017","number (\\(n\\)) positive anomalies","Galbraith, P. S., Chassé, J., Caverhill, C., Nicot, P., Gilbert, D., Lefaivre, D., et al. (2018). Physical Oceanographic Conditions in the Gulf of St. Lawrence during 2017. Department of Fisheries; Oceans Available at: http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_050-fra.html [Accessed November 26, 2018].")
df[7,] <- c("Climate","Sea water level","seaLevel","SLR","Modeled \\(0.25\\) \\(degree\\)","10 days","1992-2012","\\(mm\\)","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[8,] <- c("Coastal","Aquaculture","aquacultureInv","AQUA","\\(Lat/long\\)","NA","Variable, between 1990-2016","\\(presence-absence\\)","TBD")
df[9,] <- c("Coastal","Coastal development","coastDev","CD","\\(15\\) \\(arc-second\\)","Annual","2015-2016","\\(nanoWatts * cm^{-2} * sr^{-1}\\)","Earth Observation Group (2019). Version 1 VIIRS Day/Night Band Nighttime Lights. NOAA National Centers for Environmental Information (NCEI).")
df[10,] <- c("Coastal","Direct human impact","dirHumImpact","DHI","Modeled \\(1 km^2\\)","Annual","2011","\\(population * 10km^{-2}\\)","Statistics Canada (2017). Population and Dwelling Count Highlight Tables. 2016 Census. Statistics Canada Catalogue no. 98-402-X2016001. Ottawa. Released February 8, 2017.")
df[11,] <- c("Coastal","Inorganic pollution","inorgPol","IP","Modeled \\(1 km^2\\)","Annual","2000-2001","-","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[12,] <- c("Coastal","Nutrient import","nutrientInput","NI","Modeled \\(1 km^2\\)","Annual","2007-2010","tonnes (\\(t\\)) fertilizer","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[13,] <- c("Coastal","Organic pollution","orgPol","OP","Modeled \\(1 km^2\\)","Annual","2007-2010","tonnes (\\(t\\)) pesticide","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[14,] <- c("Coastal","Toxic algae","toxicAlgae","TA","NA","NA","NA","\\(Expert\\) \\(based\\)","Starr, M. (2019b). Reference to come, toxic algae.")
df[15,] <- c("Fisheries","Demersal, destructive","fisheriesDD","DD","\\(Lat/long\\)","Event based","2010-2015","\\(kg\\)","DFO (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.")
df[16,] <- c("Fisheries","Demersal, non-destructive, high-bycatch","fisheriesDNH","DNH","\\(Lat/long\\)","Event based","2010-2015","\\(kg\\)","DFO (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.")
df[17,] <- c("Fisheries","Demersal, non-destructive, low-bycatch","fisheriesDNL","DNL","\\(Lat/long\\)","Event based","2010-2015","\\(kg\\)","DFO (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.")
df[18,] <- c("Fisheries","Pelagic, high-bycatch","fisheriesPHB","PHB","\\(Lat/long\\)","Event based","2010-2015","\\(kg\\)","DFO (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.")
df[19,] <- c("Fisheries","Pelagic, low-bycatch","fisheriesPLB","PLB","\\(Lat/long\\)","Event based","2010-2015","\\(kg\\)","DFO (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.")
df[20,] <- c("Marine traffic","Invasive species","invasives","INV","Modeled \\(1 km^2\\)","Annual","2011","tonnes (\\(t\\)) cargo","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[21,] <- c("Marine traffic","Marine pollution","marinePol","MP","Modeled \\(1 km^2\\)","Event based & annual","2003-2011 & 2011","number (\\(n\\)) shipping lanes + tonnes (\\(t\\)) cargo","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")
df[22,] <- c("Marine traffic","Shipping","shipping","SHP","\\(0.1\\) \\(degree\\)","Event based","2003-2011","number (\\(n\\)) shipping lanes","Halpern, B. S., Frazier, M., Potapenko, J., Casey, K. S., Koenig, K., Longo, C., et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.")




# Order table
df <- df[order(df$Groups, df$Drivers), ]

# Export table
driversList <- df
save(driversList, file = './data/driversList.RData')
