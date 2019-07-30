df <- data.frame(Groups = character(),
                 Drivers = character(),
                 FileName = character(),
                 Accronym = character(),
                 SpatRes = character(),
                 TempRes = character(),
                 Years = character(),
                 Units = character(),
                 Source = character(),
                 Overview = character(),
                 DataTrans = character(),
                 SourceLink = character(),
                 # Github = character(),
                 stringsAsFactors = F)



df[1,] <- c("Climate",
            "Acidification",
            "Acidification",
            "ACID",
            "\\(Lat/long\\)",
            "August-September",
            "2018",
            '\\(\\Omega\\) \\(Aragonite\\)',
            "Starr (2019). Reference to come, aragonite and hypoxia.",
            '<p>We interpolated aragonite distribution using the exponential kriging model. We then built an index of aragonite level stress. When <span class="math inline">\\(\\Omega\\)</span> aragonite levels decrease below 1, the water becomes corrosive to calcifying organisms such as echinoderms, corals and mollusks larvae. These organisms thus have to continually recalcify their shells to maintain their structure, which becomes harder to do as <span class="math inline">\\(\\Omega\\)</span> aragonite levels further decrease towards 0. We therefore considered stress associated to decreasing <span class="math inline">\\(\\Omega\\)</span> aragonite levels to increase linearly between values of 1 and 0. The index of stress therefore has a value of 0 and 1 for values of <span class="math inline">\\(\\Omega\\)</span> aragonite equal to 1 and 0, respectively.</p>',
            'Scaled (99th quantile)',
            '')


df[2,] <- c("Climate",
            "Hypoxia",
            "Hypoxia",
            "HYP",
            "\\(Lat/long\\)",
            "August-September",
            "2018",
            "\\(ml * L^{-1}\\)",
            df[1,]$Source,
            '<p>We interpolated the dissolved oxygen using cokriging with depth as a covariable, as done in <span class="citation">(Dutil et al., 2011)</span>. According to <span class="citation">Diaz and Rosenberg (1995)</span>, severe hypoxia can be observed when oxygen saturation falls below 2 <span class="math inline">\\(ml\\)</span> <span class="math inline">\\(L^{-1}\\)</span> or 62.5 <span class="math inline">\\(\\mu mol\\)</span> <span class="math inline">\\(L^{-1}\\)</span>, which is considered the level necessary to maintain most animal life. This threshold is equal to 1.4 <span class="math inline">\\(ml\\)</span> <span class="math inline">\\(L^{-1}\\)</span> (1 <span class="math inline">\\(mg\\)</span> <span class="math inline">\\(L^{-1}\\)</span> = 0.7 <span class="math inline">\\(ml\\)</span> <span class="math inline">\\(L^{-1}\\)</span>). We used this threshold to create an index of hypoxia using an inverted logistic curve to transform the dissolved oxygen values as an index of hypoxic stress <span class="math inline">\\(H_s\\)</span> ranging from 0 to 1, under the assumption that hypoxic stress will increase following a logistic curve as it approaches the hypoxic threshold:</p> <p><span class="math display">\\[H_s = \\frac{-1}{200 * e^{-2.5 * DO_2}} + 1\\]</span></p>',
            'Log-transformed and scaled (99th quantile)',
            '')

df[3,] <- c("Climate",
            "Negative sea bottom temperature anomalies",
            "NegativeSBT",
            "SBT-",
            "\\(~2 km^2\\)",
            "Monthly",
            "1981-2010 vs. 2013-2017",
            "number (\\(n\\)) negative anomalies",
            'Galbraith et al. (2018). Physical Oceanographic Conditions in the Gulf of St. Lawrence during 2017. Department of Fisheries and Oceans.',
            '<p>The data used to characterize bottom temperature anomalies come from the Department of Fisheries and Oceans’ (DFO) Atlantic Zone Monitoring Program <span class="citation">(AZMP; Galbraith et al., 2018)</span>. We provide a brief summary of data and methods to characterize surface temperature climatology and anomalies in this document. For more details, refer to <span class="citation">Galbraith et al. (2018)</span>.</p><p>Bottom temperatures are interpolated in the Gulf using conductivity-temperature-depth (CTD) sampling performed annually through DFO’s multispecies surveys for the northern Gulf in August and for the Magdalen Shallows in September. Using this sampling survey, temperatures are interpolated at each 1 m depth layer on a 2 km resolution grid. Bottom temperature are then extracted from this grid by using a bathymetry layer from the Canadian Hydrographic Survey <span class="citation">(Dutil et al., 2012)</span>.</p><p>We used temperature anomalies, <em>i.e.</em> deviations from long-term normal conditions, to measure an annual index of stress associated with extreme temperatures between 2013 and 2017. Temperature anomalies were calculated using the difference between grid cell monthly climatologies to the associated long-term averages generated from the reference period between 1981 and 2010. Grid cells whose monthly value exceeded ±0.5 standard deviation (SD) from the long-term average were considered as anomalous <span class="citation">(Galbraith et al., 2018)</span>.</p><p>Outliers in the data were considered as those that fell beyond the interquartile range (IQR) * 3, identified as extreme ouliers by <span class="citation">Tukey (1977)</span>. Outlier values were capped to correspond to the 5th and 95th percentiles. Anomalies were divided into positive and negative anomalies and summed for the available months of September and August. By adding the monthly anomaly values, we essentially considered the summed deviation from the mean as an indicator of the annual intensity of surface temperature anomalies in the St. Lawrence.</p>',
            'Log-transformed and scaled (99th quantile)',
            'http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_050-fra.html')

df[4,] <- c("Climate",
            "Positive sea bottom temperature anomalies",
            "PositiveSBT",
            "SBT+",
            "\\(~2 km^2\\)",
            "Monthly",
            "1981-2010 vs. 2013-2017",
            "number (\\(n\\)) positive anomalies",
            df[3,]$Source,
            df[3,]$Overview,
            'Log-transformed and scaled (99th quantile)',
            df[3,]$SourceLink)


df[5,] <- c("Climate",
            "Negative sea surface temperature anomalies",
            "NegativeSST",
            "SST-",
            "\\(~2 km^2\\)",
            "Monthly",
            "1981-2010 vs. 2013-2017",
            "number (\\(n\\)) negative anomalies",
            df[3,]$Source,
            '<p>The data used to characterize surface temperature anomalies come from the Department of Fisheries and Oceans’ (DFO) Atlantic Zone Monitoring Program <span class="citation">(AZMP; Galbraith et al., 2018)</span>. We provide a brief summary of data and methods to characterize surface temperature climatology and anomalies in this document. For more details, refer to <span class="citation">Galbraith et al. (2018)</span>.</p><p>The surface layer is characterized using a variety of methods:</p><ol style="list-style-type: decimal"><li>Temperature-salinity sensors installed on various ships and forming the shipboard thermosalinograph network,</li><li>Moored instruments recording water temperature every 30 minutes and forming the thermograph network,</li><li>Sea surface temperature (SST) monthly composite climatologies using Advanced Very High Resolution Radiometer (AVHRR) satellite images from the National Oceanic and Atmospheric Administration (NOAA) and European Organization for the Exploitation of Meteorological Satellites (EUMETSAT) available from the Maurice Lamontagne Institute sea surface temperature processing facility at a 1km resolution from 1985-2013 and from the Bedford Institute of Oceanography (BIO) Operational Remote Sensing group at a 1.5km resolution since 2014.</li></ol><p>Positive and negative surface temperature anomalies were identified following the same approach used for bottom temperature anomalies. Compared to the bottom temperature anomalies, however, data is available throughout the year. Only the months of April to November were included to avoid biases associated with anomalies measurements due to the presence of ice cover.</p><p>We used temperature anomalies, <em>i.e.</em> deviations from long-term normal conditions, to measure an annual index of stress associated with extreme temperatures between 2013 and 2017. Temperature anomalies were calculated using the difference between grid cell monthly climatologies to the associated long-term averages generated from the reference period between 1981 and 2010. Grid cells whose monthly value exceeded ±0.5 standard deviation (SD) from the long-term average were considered as anomalous <span class="citation">(Galbraith et al., 2018)</span>.</p><p>Outliers in the data were considered as those that fell beyond the interquartile range (IQR) * 3, identified as extreme outliers by <span class="citation">Tukey (1977)</span>. Outlier values were capped to correspond to the 5th and 95th percentiles. Anomalies were divided into positive and negative anomalies and summed for the months of April to November. By adding the monthly anomaly values, we essentially considered the summed deviation from the mean as an indicator of the annual intensity of surface temperature anomalies in the St. Lawrence. The months of December to March were removed to avoid biases associated with anomalies measurements due to the presence of ice cover.</p>',
            'Scaled (99th quantile)',
            df[3,]$SourceLink)


df[6,] <- c("Climate",
            "Positive sea surface temperature anomalies",
            "PositiveSST",
            "SST+",
            "\\(~2 km^2\\)",
            "Monthly",
            "1981-2010 vs. 2013-2017",
            "number (\\(n\\)) positive anomalies",
            df[3,]$Source,
            df[5,]$Overview,
            'Scaled (99th quantile)',
            df[3,]$SourceLink)


df[7,] <- c("Climate",
            "Sea water level",
            "SeaLevel",
            "SLR",
            "Modeled \\(0.25\\) \\(degree\\)",
            "10 days",
            "1992-2012",
            "\\(mm\\)",
            "Halpern et al. (2015). Cumulative human impacts: Raw stressor data (2008 and 2013). KNB Data Repository doi:10.5063/f1s180fs.",
            '<p>The data used to characterize sea level rise risk comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to <span class="citation">Halpern et al. (2015b)</span>.</p><p>Sea level rise was characterized by <span class="citation">(<span class="citeproc-not-found" data-reference-id="Nicholls and Cazenave 2010"><strong>???</strong></span>)</span> using NASA’s satellite altimetry data (Topex/Poseidon, Jason-1&amp;2, GFO, ERS-1&amp;2, and Envisat missions) and available at <a href="http://www.aviso.altimetry.fr/en/data/products/ocean-indicatorsproducts/mean-sea-level/products-images.html" class="uri">http://www.aviso.altimetry.fr/en/data/products/ocean-indicatorsproducts/mean-sea-level/products-images.html</a></p><p>The rate of sea level rise (<span class="math inline">\\(mm/year\\)</span>) was measured between 1992 and 2012 and transformed as a net change value (<span class="math inline">\\(mm\\)</span>) by multiplying by the number of years considered. Only positive values were selected under the assumption that only positive sea level rise is likely to cause environmental stress.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
            'Scaled (99th quantile)',
            'https://knb.ecoinformatics.org/view/doi:10.5063/F1S180FS')


df[8,] <- c("Coastal",
            "Aquaculture",
            "AquacultureInvertebrates",
            "AQUA",
            "\\(Lat/long\\)",
            "NA",
            "Variable, between 1990-2016",
            "\\(presence-absence\\)",
            "TBD",
            '<p>Aquaculture data comes from a variety of sources in the St. Lawrence because aquaculture sites are mostly managed at the provincial level. We therefore had to gather the data on aquaculture sites from the 5 provinces dividing the St. Lawrence.</p><p>Invertebrates aquaculture is especially important in the southern and western Gulf. Fish and algae aquaculture, on the other hand, remains marginal. Considering this, we only considered invertebrates aquaculture for the aquaculture driver layer. However, if fish or algae farming were to become more important, these driver should be incorporated in future analyses as individual layers, as impacts vary between types of aquaculture.</p><p>Aquaculture activities are highly localized and potential effects do not or rarely extend beyond the location of the farms. We therefore only considered the actual location of sites to characterize the distribution of this driver. We were unable to characterize site production in terms of biomass farmed, which could provide an indication of the intensity of aquaculture activities. As such, we considered aquaculture as binary presence-absence data in our analyses.</p>',
            'Scaled (99th quantile)',
            '')


df[9,] <- c("Coastal",
            "Coastal development",
            "CoastalDevelopment",
            "CD",
            "\\(15\\) \\(arc-second\\)",
            "Annual",
            "2015-2016",
            "\\(nanoWatts * cm^{-2} * sr^{-1}\\)",
            "Earth Observation Group (2019). Version 1 VIIRS Day/Night Band Nighttime Lights. NOAA National Centers for Environmental Information (NCEI).",
            '<p>We used lights at night as a proxy of coastal infrastructure development, as terrestrial stable lights at night represent light from human settlements and industrial sites with electricity.</p><p>The data comes from the Nighttime Lights Time Series. Nighttime light products are compiled by the Earth Observation Group at the National Oceanic and Atmospheric Administration’s (NOAA) National Centers for Environmental Information (NCEI). They use glogally available nighttime data obtained from the Visible Infrared Imaging Radiometer Suite (VIIRS) Day/Night Band (DNB) of the Defense Meteorological Satellite Program (DMSP) to characterize global average radiance (<span class="math inline">\\(nanoWatts\\)</span> <span class="math inline">\\(cm^{-2}\\)</span> <span class="math inline">\\(sr^{-1}\\)</span>) composite images at a 15 arc-second (~200 m) resolution.</p><p>We used the annual Version 1 Nighttime VIIRS DNB composites between 2015 and 2016 <span class="citation">(Earth Observation Group, 2019)</span> to characterize coastal development in coastal areas of the St. Lawrence. As the effects of coastal development are likely acute in its direct vicinity, we extracted average radiance values using a 2 km buffer around grid cells within 2 km of the coast. We used a weighted area average to extract the radiance values.</p>',
            'Log-transformed and scaled (99th quantile)',
            'https://www.ngdc.noaa.gov/eog/viirs/download_dnb_composites.html')


df[10,] <- c("Coastal",
             "Direct human impact",
             "DirectHumanImpact",
             "DHI",
             "Modeled \\(1 km^2\\)",
             "Annual",
             "2011",
             "\\(population * 10km^{-2}\\)",
             "Statistics Canada (2017). Population and Dwelling Count Highlight Tables. 2016 Census. Statistics Canada Catalogue no. 98-402-X2016001. Ottawa. Released February 8, 2017.",
             '<p>As in <span class="citation">Halpern et al. (2008)</span> and <span class="citation">Halpern et al. (2015b)</span>, we used the sum of coastal populations as a proxy of direct human impact. We used Statistics Canada dissemination area population count from the 2016 census to obtain coastal population size around the St. Lawrence <span class="citation">(<span class="citeproc-not-found" data-reference-id="statscan2017">Statistics Canada, 2017</span>)</span>. Dissemination areas are the smallest standard geographic area in which census data are disseminated and they combine to cover all of Canada. The census provides population count within the boundary of each dissemination area, which we used to evaluate total coastal population.</p><p>As the effects of direct human impacts are likely acute mostly in coastal areas we calculated total population in grid cells within 2 km of the coast. Total population was measured in a 10 km buffer around each coastal cell. The total population in each buffer was the sum of intersecting dissemination areas divided by the intersection area between buffers and dissemination areas:</p><p><span class="math display">\\[DHI_j = \\sum_{k=1}^{n_j} P_k * \\frac{A_{j,k}}{A{tot, k}}\\]</span></p><p>where <span class="math inline">\\(j\\)</span> is a buffered grid cell, <span class="math inline">\\(k\\)</span> is a dissemination area intersecting <span class="math inline">\\(j\\)</span>, <span class="math inline">\\(P\\)</span> is the population in <span class="math inline">\\(k\\)</span>, <span class="math inline">\\(A\\)</span> is the area of the <span class="math inline">\\(k\\)</span> overlapping with <span class="math inline">\\(j\\)</span> and <span class="math inline">\\(A_{tot}\\)</span> is the total area of <span class="math inline">\\(k\\)</span>. This approach was favoured to reduce the effects of very large dissemination areas overlapping with buffers on a very small percentage of their total area.</p>',
             'Log-transformed and scaled (99th quantile)',
             'https://www12.statcan.gc.ca/census-recensement/index-eng.cfm')


df[11,] <- c("Coastal",
             "Inorganic pollution",
             "InorganicPollution",
             "IP",
             "Modeled \\(1 km^2\\)",
             "Annual",
             "2000-2001",
             "-",
             df[7,]$Source,
             '<p>The data used to characterize inorganic pollution comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to <span class="citation">Halpern et al. (2015b)</span>.</p><p>Inorganic pollution was modelled using impervious surface area (<em>i.e.</em> artificial surfaces such as paved roads) under the assumption that most of this pollution source comes from urban runoff. Inorganic pollution originating from point-sources or in areas lacking paved roads is therefore not captured by this layer. The data obtained was aggregated at the watershed scale and spread into coastal and marine environments was modelled using a diffusive plume model from each watershed pourpoints (<em>e.g.</em> river mouths).</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Log-transformed and scaled (99th quantile)',
             df[7,]$SourceLink)



df[12,] <- c("Coastal",
             "Nutrient import",
             "NutrientInput",
             "NI",
             "Modeled \\(1 km^2\\)",
             "Annual",
             "2007-2010",
             "tonnes (\\(t\\)) fertilizer",
             df[7,]$Source,
             '<p>The data used to characterize nutrient pollution comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to <span class="citation">Halpern et al. (2015b)</span>.</p><p>Annual fertilizer use in tonnes (<span class="math inline">\\(t\\)</span>) was used as a proxy of nutrient pollution. The data used came from the Food and Agriculture Organization of the United Nations (FAO). Gaps in data were modelled using a linear regression between fertilizer and pesticides or agricultural gross domestic product (GDP). Dasymetric maps were then used to distribute fertilizer data over the landscape using 2009 data from the Moderate Resolution Imaging Spectroradiometer (MODIS) at ~500 m resolution and aggregated to watersheds. Diffusive plume models from each watershed pourpoint (<em>e.g.</em> river mouths) were then used to model the distribution and intensity of nutrient pollution in coastal and marine environments.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Log-transformed and scaled (99th quantile)',
             df[7,]$SourceLink)


df[13,] <- c("Coastal",
             "Organic pollution",
             "OrganicPollution",
             "OP","Modeled \\(1 km^2\\)",
             "Annual",
             "2007-2010",
             "tonnes (\\(t\\)) pesticide",
             df[7,]$Source,
             '<p>The data used to characterize organic pollution comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to <span class="citation">Halpern et al. (2015b)</span>.</p><p>Annual pesticide use in tonnes (<span class="math inline">\\(t\\)</span>) was used as a proxy of organic pollution. The data used came from the FAO and gaps in data were modelled using a linear regression between pesticides and fertilizers or agricultural gross domestic product (GDP). Dasymetric maps were then used to distribute fertilizer data over the landscape using 2009 data from the Moderate Resolution Imaging Spectroradiometer (MODIS) at ~500 m resolution and aggregated to watersheds. Diffusive plume models from each watershed pourpoint (<em>e.g.</em> river mouths) were then used to model the distribution and intensity of organic pollution in coastal and marine environments.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Log-transformed and scaled (99th quantile)',
             df[7,]$SourceLink)


df[14,] <- c("Coastal",
             "Toxic algae",
             "ToxicAlgae",
             "TA",
             "NA",
             "NA",
             "NA",
             "\\(Expert\\) \\(based\\)",
             "Starr (2019). Reference to come, toxic algae.",
             '<p>The data we use to describe the risk of toxic algae comes from an expert based map delineating the areas where coastal areas are at risk from five different toxins <span class="citation">(Bates, 2019)</span>. The map presents coastal areas at risk from 5 different toxins: 1) paralytic shellfish poisoning (PSP) toxins from the regular presence of the dinoflagellate <em>Alexandrium catenella</em> (previously <em>Alexandrium tamarense</em>) at high concentrations, 2) amnesic shellfish poisoning (ASP) toxins from domoic acid 3) diarrhetic shellfish poisoning (DSP) toxins, 4) spirolides and 5) pectenotoxins, two toxins produced by dinoflagellates occurring in the St. Lawrence.</p><p>The information provided on this expert map on the 5 toxins <span class="citation">(Bates, 2019)</span>. was georeferenced and transformed as vecctorized objects. We calculated a toxic algae risk (<span class="math inline">\\(T\\)</span>) index for each cell (<span class="math inline">\\(x\\)</span>) in the 1 <span class="math inline">\\(km^2\\)</span> study grid. For each toxin (<span class="math inline">\\(t\\)</span>), a value of 1 was attributed to all grid cells overlapping with areas identified at risk on the expert map and a value of 0.5 for grid cells overlapping with areas where ASP and DSP toxins were observed without exceeding legal thresholds. The value for all 5 toxins was them summed for all grid cells:</p><p><span class="math display">\\[TA_{i,x} = \\sum_{i = 1}^{5} i_x\\]</span></p>',
             'Scaled (99th quantile)',
             '')


df[15,] <- c("Fisheries",
             "Demersal, destructive",
             "FisheriesDD",
             "DD",
             "\\(Lat/long\\)",
             "Event based",
             "2010-2015",
             "\\(kg\\)",
             "Fisheries and Oceans Canada (2016). Departement of Fisheries and Oceans Canada’s Fisheries and Oceans Canada Zonal Interchange File Format (ZIFF) data. A compilation of landing data from logbook data between 2010 and 2015.",
             '<p>The impacts of fisheries activities in the St. Lawrence are evaluated using DFO fisheries logbooks program <span class="citation">(DFO, 2016)</span>. While logbooks are not mandatory for all fisheries in the St. Lawrence, they still provide a very thorough overview of the spatial distribution and intensity of fishing activities in the St. Lawrence. The data we used spans 6 years from 2010 to 2015 and details 218323 fishing events (36387 <span class="math inline">\\(\\pm\\)</span> 3147 fishing events per year). There were 31 targeted species and a total of 53 caught species in the dataset.</p><p>Fishing activities are performed using a variety of gear types: trap, trawl, dredge, driftnet, hand line, longline, scuba diving, purse seine, seine, beach seine and jig fishing. Intensity of fishing activities was divided among gear types and based on their respective types of environmental impacts. For example, traps and trawls have very different effects on a system. Gear classification was done using the classification presented in <span class="citation">Halpern et al. (2008)</span> and <span class="citation">Halpern et al. (2015a)</span> and is broken down into 5 distinct classes: demersal destructive (DD), demersal, non-destructive, low-bycatch (DNL), demersal, non-destructive, high-bycatch (DNH), pelagic, low-bycatch (PLB) and pelagic, high-bycatch (PHB). This categorization therefore divides the fisheries data into 5 distinct driver layers characterizing fishing activities.</p><p>Gear types can also be further classified into fixed or mobile engines based on their mobility. We used these two mobility classes to generate a buffer of impact around each fishing activity coordinates to consider potential spatial uncertainty associated with locations and the fact that mobile engines can be tracted over several kilometers during fishing activities and that we do not have the beginning and end points of mobile fishing events. Buffer sizes for fixed and mobile engine was of 200 and 2000 meters, respectively.</p><br/><p>Table 1. Classification of gear types in the fisheries dataset based on their environmental impact and mobility</p><table><thead><tr class="header"><th>Gear type</th><th>Classification</th><th>Mobility</th></tr></thead><tbody><tr class="odd"><td>Trap</td><td>DNH</td><td>Fixed</td></tr><tr class="even"><td>Trawl</td><td>DD</td><td>Mobile</td></tr><tr class="odd"><td>Dredge</td><td>DD</td><td>Mobile</td></tr><tr class="even"><td>Driftnet</td><td>PHB</td><td>Fixed</td></tr><tr class="odd"><td>Hand lines</td><td>PLB</td><td>Fixed</td></tr><tr class="even"><td>Longline</td><td>PHB</td><td>Fixed</td></tr><tr class="odd"><td>Scuba diving</td><td>DNL</td><td>Fixed</td></tr><tr class="even"><td>Purse seine</td><td>PLB</td><td>Fixed</td></tr><tr class="odd"><td>Seine</td><td>DNH</td><td>Fixed</td></tr><tr class="even"><td>Beach seine</td><td>DNH</td><td>Fixed</td></tr><tr class="odd"><td>Trap</td><td>DNH</td><td>Fixed</td></tr><tr class="even"><td>Jig fishing</td><td>PLB</td><td>Fixed</td></tr></tbody></table><br/><p>In order to characterize the intensity of fishing activities (<span class="math inline">\\(FI\\)</span>), we used a biomass yield density index. We multipled the total annual biomass captured in each grid cell <em>j</em>, regardless of species, by the proportion of fishing area in each grid cell:</p><p><span class="math display">\\[FI_j = \\sum_{k=1}^{n_j} B_{tot, k} * \\frac{A_{j,k}}{A_{tot,k}}\\]</span></p><p>where <span class="math inline">\\(j\\)</span> is a grid cell, <span class="math inline">\\(k\\)</span> is a fishing event, <span class="math inline">\\(B_{tot}\\)</span> is the total biomass of a fishing event <span class="math inline">\\(k\\)</span>, <span class="math inline">\\(A\\)</span> is the area of a fishing event <em>k</em> overlapping a cell <span class="math inline">\\(j\\)</span> and <span class="math inline">\\(A_{tot}\\)</span> is the total area of the fishing event <span class="math inline">\\(k\\)</span>. This formula gives an intensity measurement in biomass units, which is kg in our case. Since we measure the intensity within a 1 <span class="math inline">\\(km^2\\)</span> grid cell, the intensity evaluation is in <span class="math inline">\\(kg * km^{-2}\\)</span>. This metric distributes the biomass captured within each grid cell as a function of overlapping fishing area and provides an overview of how impacted each grid cell is in terms of extracted biomass.</p>',
             'Log-transformed and scaled (99th quantile)',
             '')


df[16,] <- c("Fisheries",
             "Demersal, non-destructive, high-bycatch",
             "FisheriesDNH",
             "DNH",
             "\\(Lat/long\\)",
             "Event based",
             "2010-2015",
             "\\(kg\\)",
             df[15,]$Source,
             df[15,]$Overview,
             'Log-transformed and scaled (99th quantile)',
             '')


df[17,] <- c("Fisheries",
             "Demersal, non-destructive, low-bycatch",
             "FisheriesDNL",
             "DNL",
             "\\(Lat/long\\)",
             "Event based",
             "2010-2015",
             "\\(kg\\)",
             df[15,]$Source,
             df[15,]$Overview,
             'Log-transformed and scaled (99th quantile)',
             '')


df[18,] <- c("Fisheries",
             "Pelagic, high-bycatch",
             "FisheriesPHB",
             "PHB",
             "\\(Lat/long\\)",
             "Event based",
             "2010-2015",
             "\\(kg\\)",
             df[15,]$Source,
             df[15,]$Overview,
             'Log-transformed and scaled (99th quantile)',
             '')


df[19,] <- c("Fisheries",
             "Pelagic, low-bycatch",
             "FisheriesPLB",
             "PLB",
             "\\(Lat/long\\)",
             "Event based",
             "2010-2015",
             "\\(kg\\)",
             df[15,]$Source,
             df[15,]$Overview,
             'Log-transformed and scaled (99th quantile)',
             '')


df[20,] <- c("Marine traffic",
             "Invasive species",
             "InvasiveSpecies",
             "INV",
             "Modeled \\(1 km^2\\)",
             "Annual",
             "2011",
             "tonnes (\\(t\\)) cargo",
             df[7,]$Source,
             '<p>The data used to characterize invasive species risk comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to supplementary materials provided in <span class="citation">Halpern et al. (2008)</span> and <span class="citation">Halpern et al. (2015b)</span>.</p><p>Cargo volume was used as a proxy of invasion risk under the assumption that risk of invasion is proportional to tonnes of goods transferred through ports. Cargo throughput in metric tonnes for the year 2011 was accessed through a variety of sources <span class="citation">(see supplementary material in Halpern et al., 2015b for more details)</span> and cross-matched with entries in the World Port Index database (WPI; available from the National Geospatial-Intelligence Agency). A gap-filling procedure using linear regression and sets of predictors related to port volume and available in the WPI dataset was then applied to the WPI dataset to predict missing cargo volume entries. Finally, volume data was distributed in marine environments adjacent to ports using a diffusive plume model with an exponential decay function that set the maximum spread distance to approximately 1000 km. The plume model was then clipped to areas less than 60 m deep, as invasive species are more likely to invade shallow areas.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Log-transformed and scaled (99th quantile)',
             df[7,]$SourceLink)


df[21,] <- c("Marine traffic",
             "Marine pollution",
             "MarinePollution",
             "MP",
             "Modeled \\(1 km^2\\)",
             "Event based & annual",
             "2003-2011 & 2011",
             "number (\\(n\\)) shipping lanes + tonnes (\\(t\\)) cargo",
             df[7,]$Source,
             '<p>The data used to characterize marine pollution risk comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. Marine pollution was considered to be mainly driver by the shipping industry. As such, the driver layer was constructed by combining the shipping (<em>i.e.</em> shipping lanes) and invasives species (<em>i.e.</em> cargo volume) layers. invasive. For more details, refer to supplementary materials provided in <span class="citation">Halpern et al. (2008)</span> and <span class="citation">Halpern et al. (2015b)</span>.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Scaled (99th quantile)',
             df[7,]$SourceLink)


df[22,] <- c("Marine traffic",
             "Shipping",
             "Shipping",
             "SHP",
             "\\(0.1\\) \\(degree\\)",
             "Event based",
             "2003-2011",
             "number (\\(n\\)) shipping lanes",
             df[7,]$Source,
             '<p>The data used to characterize shipping comes from the global cumulative impacts assessment on habitats <span class="citation">(Halpern et al., 2015b, 2008)</span> and available on the NCEAS online data repository <span class="citation">(Halpern et al., 2015a)</span>. We provide a brief summary of data and methods in this document. For more details, refer to <span class="citation">Halpern et al. (2015b)</span>.</p><p>Two data sources were used to characterize shipping. The first set of data is gathered as part of the World Meteorological Organization Voluntary Observing Ships’ (VOS) scheme. Ships participating in the program gather meteorological data along with observation location as part of an open-ocean climate dataset. The data spans 20 years and annually covers 10-20% of ships worlwide. Data used spanned 2003 to 2011.</p><p>The second set of data comes from the Automatic Identification System (AIS), an initiative launched in 2002 that sought to improve marine safety by providing mariners with real-time vessel traffic <span class="citation">(<span class="citeproc-not-found" data-reference-id="tetreault2002">Tetreault et al. 2002</span>)</span>. Through the International Maritime Organization SOLAS agreement, all vessels of over 300 gross tonnage on international voyages and those carrying passengers are now required to be equipped with AIS transceivers. These transceivers use Global Positioning System technology to locate vessels every 10 minutes. The data used was from November 2010 to December 2011.</p><p>Data used come mostly from vessels that move globally (<em>i.e.</em> cargo, tanker and passenger), as they are required to carry AIS transceivers, but also include data from fishing, high-speed, pleasure and support classes. Shipping intensity was evaluated as the number of fishing tracks at a 0.1 decimal degrees resolution. For more details on data and methods used, consult <span class="citation">(<span class="citeproc-not-found" data-reference-id="walbridge2013">Walbridge et al. 2013</span>)</span>.</p><p>For the St. Lawrence, we overlaid the raw data layers <span class="citation">(Halpern et al., 2015a)</span> with our 1 <span class="math inline">\\(km^2\\)</span> grid cell using weighted area average.</p>',
             'Log-transformed and scaled (99th quantile)',
             df[7,]$SourceLink)




# Order table
df <- df[order(df$Groups, df$Drivers), ]

# Add colors
# Colors
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100, alpha = .5)[1:n]
}

# Transparency
transparency <- c('FF','DD','BB','99','77','55','33','11')
nGroup <- length(unique(df$Groups))
df$col <- gg_color_hue(nGroup)[as.numeric(as.factor(df$Groups))]
for(i in unique(df$Groups)) {
  id <- which(df$Groups == i)
  nId <- length(id)
  for(j in 1:nId) {
    df$col[id[j]] <- paste0(substr(df$col[id[j]],1,7), transparency[j])
  }
}


# Export table
driversList <- df
# save(driversList, file = './data/driversList.RData')
