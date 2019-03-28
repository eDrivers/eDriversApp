experts <- data.frame(name = character(), lastName = character(), email = character(), stringsAsFactors = F)
experts[1,] <- c('Andréane','Bastien', 'BastienA@ogsl.ca')
experts[2,] <- c('Simon','Bélanger', 'simon_belanger@uqar.ca')
experts[3,] <- c('Pascal','Bernatchez', 'Pascal_Bernatchez@uqar.ca')
experts[4,] <- c('Hugo','Bourdages', 'Hugo.Bourdages@dfo-mpo.gc.ca')
experts[5,] <- c('Clément','Chion', 'clementchion@gmail.com')
experts[6,] <- c('Rémi M.','Daigle', 'daigleremi@gmail.com')
experts[7,] <- c('Peter S.','Galbraith', 'Peter.Galbraith@dfo-mpo.gc.ca')
experts[8,] <- c('Benjamin','Halpern', 'halpern@nceas.ucsb.edu')
experts[9,] <- c('Christopher W.','McKindsey', 'Chris.Mckindsey@dfo-mpo.gc.ca')
experts[10,] <- c('Alfonso','Mucci', 'alfonso.mucci@mcgill.ca')
experts[11,] <- c('Simon','Pineault', 'Simon.Pineault@environnement.gouv.qc.ca')
experts[12,] <- c('Michel','Starr', 'Michel.Starr@dfo-mpo.gc.ca')
experts[13,] <- c('Anne-Sophie','Ste-Marie', 'SteMarieA@ogsl.ca')
experts[14,] <- c('Steve','Vissault', 'steve.vissault@usherbrooke.ca')

experts <- experts[order(experts$lastName), ]


eDrivers <- c('
<h1>eDrivers<h1/>
<br/>
<hr /><div class="pad">
<br/>
<h3>What is <em>eDrivers</em>?
    &nbsp;&nbsp;
    <a href="mailto:eDrivers@gmail.com"><i class="fa fa-envelope" aria-hidden="true"></i></a>
    <a href="https://github.com/eDrivers" target="_blank"><i class="fa fa-github" aria-hidden="true"></i></a>
<h3/>

<h4><em>eDrivers</em> is an open data platform focused on the description of the
spatial distribution and intensity of drivers and using the Estuary and Gulf
of St. Lawrence in Canada. The overarching goal of this platform is to create
an expert community committed to structuring, sharing and standardizing drivers
data in support to science and management.<h4/>

<h4>Drivers are any externality that affects environmental processes and
disturbs natural systems and they are often referred to as stressors or pressures.
Drivers can be natural (e.g. sea surface temperature anomalies and hypoxia) or
anthropogenic (e.g. fisheries and marine pollution) in origin.<h4/>

<h4> There are currently 22 driver layers accessible through <em>eDrivers</em>
and we are actively working on updating or developing additional layers.
Drivers are currently divided into 4 groups: coastal, climate, fisheries and
marine traffic related.</h4>

<h4>The project is described in depth in an accompanying publication
(provide details and reference).</h4>

<h4>All data layers are hosted and can be accessed through the web portal of our
main partner, the
<a href="https://ogsl.ca/en" target="_blank">St. Lawrence Global Observatory</a>
 (SLGO).

<h4> The <a href="https://github.com/eDrivers/" target="_blank"><em>eDrivers</em> github organization</a>.
also provides access the the workflows and methodologies applied to produce
all driver layers, an R package called
<a href="https://github.com/eDrivers/eDrivers/" target="_blank"><em>eDrivers</em></a>
to access the data through the SLGO web portal, an R package called
<a href="https://github.com/eDrivers/eDriversEx/" target="_blank"><em>eDriversEx</em></a>
for analytical tools to explore the drivers dataset and the
<a href="https://github.com/eDrivers/eDriversApp/" target="_blank">code</a>
associated with this web application. </h4>


<br/>
<h3>Guiding principles<h3/>
<h7>Unity and inclusiveness</h7>
<h4>Operating over such large scales in time, space and subject matter requires
a vast and diverse expertise that cannot possibly be possessed by any one
individual or organization. Consequently, we envision an initiative that seeks
to mobilize all individuals and entities with relevant expertise.<h4/>

<h4>We are also committed to promote, consolidate and work with experts involved
in existing and highly valuable environmental initiatives already in place in
the St. Lawrence</h4>

<h4>Please <a href="mailto:david.beauchesne@hotmail.com">contact us</a>
if you are interested in collaborating on this initiative!</h4>


<br/>
<h7>Findability, accessibility</h7><br/>
<h7>interoperability and reusability</h7>

<h4>By moving towards large scale, cross-disciplinary research and management
projects, there is a growing need to increase the efficiency of data discovery,
access, interoperability, standardization and analysis. Our goal is to foster
efficient and functional open science by building an infrastructure adhering to
the FAIR Data Principles, which states that data and metadata must be Findable,
Accessible, Interoperable and Reusable
(<a href="https://www.nature.com/articles/sdata201618" target="_blank">Wilkinson <em>et al.</em> 2016</a>).<h4/>


<br/>
<h7>Adaptiveness</h7>

<h4>Adaptive management can only be achieved through a commitment to adaptive
monitoring and data reporting. We further contend that adaptive management
requires the development of adaptive monitoring tools and infrastructures,
which we seek to address through a continuously-evolving platform.<h4/>


<br/>
<h7>Validation and quality</h7>
<h4>Using high-quality data is crucial to ensure robust analyses and
decision-making. Shared data should therefore undergo a robust quality
assessment process.<h4/>

<br/>
<h7>Recognition</h7>
<h4>Like peer-reviewed publications, data must also be given its due
importance in scientific endeavors and thus be considered as legitimate citable
products contributing to the overall scientific output of data providers
Appropriate citations following acknowledged
<a href="https://www.force11.org/datacitationprinciples" target="_blank">Data Citation Principles</a>
will therefore be provided for all data layers used and shared on <em>eDrivers</em>.<h4/>

<br/>

<div align=center><img src="structure.png" alt="" height=350px></div>
<hCaption>Figure 1. Platform structure</hCaption>




<br/><br/>
<h3>Contact us</h3>
<h7>Project leaders</h7>

<ul>
<li><h4>
    <a href="mailto:david.beauchesne@hotmail.com"><i class="fa fa-envelope" aria-hidden="true"></i></a>
    &nbsp;&nbsp;
    David Beauchesne
    &nbsp;&nbsp;
    <a href="https://github.com/david-beauchesne" target="_blank"><i class="fa fa-github" aria-hidden="true"></i></a>
    <a href="https://www.researchgate.net/profile/David_Beauchesne" target="_blank"><i class="ai ai-researchgate" aria-hidden="true"></i></a>
<h4/></li>

<li><h4>
    <a href="mailto:philippe.archambault@bio.ulaval.ca"><i class="fa fa-envelope" aria-hidden="true"></i></a>
    &nbsp;&nbsp;
    Philippe Archambault
    &nbsp;&nbsp;
    <a href="https://www.researchgate.net/profile/Philippe_Archambault" target="_blank"><i class="ai ai-researchgate" aria-hidden="true"></i></a>
<h4/></li>

<li><h4>
    <a href="mailto:dominique.gravel@usherbrooke.ca"><i class="fa fa-envelope" aria-hidden="true"></i></a>
    &nbsp;&nbsp;
    Dominique Gravel
    &nbsp;&nbsp;
    <a href="https://github.com/DominiqueGravel" target="_blank"><i class="fa fa-github" aria-hidden="true"></i></a>
<h4/></li>
</ul>
<br/>
<h7>Experts</h7>
<ul>',

paste0(
'<li><h4>',
    '<a href="mailto:', experts$email, '"><i class="fa fa-envelope" aria-hidden="true"></i></a>
    &nbsp;&nbsp;',
    experts$name, ' ', experts$lastName,
'<h4/></li>'),

'
</ul>


<br/>
<h3>Partners</h3>
<br/>

<div class="wrapper">
  <div class="logo2">
  <div id="benthos">
      <img src="benthos.png" alt="">
  </div>
  <div id="ogsl">
      <img src="logo-ogsl-fr.png" alt="">
  </div>
  <div id="ielab">
      <img src="ielab.jpg" alt="">
  </div>
  </div>
</div>

<br/>
<h7>Academic</h7>
<br/>
<div class="wrapper">
  <div class="logo">
  <div id="ismer">
      <img src="uqar_ismer.png" alt="">
  </div>
  <div id="laval">
      <img src="ul.png" alt="">
  </div>
  <div id="uds">
      <img src="UdeS.png" alt="">
  </div>
  </div>
</div>

<br/>
<h7>Governmental</h7>
<br/>
<div class="wrapper">
  <div class="logo">
  <div id="mpo">
      <img src="mpo.png" alt="">
  </div>
  <div id="melcc">
      <img src="mddelcc.png" alt="">
  </div>
  <div id="crsng">
      <img src="CRSNG-color.png" alt="">
  </div>
  <div id="fqrnt">
      <img src="frqnt.png" alt="">
  </div>
  </div>
</div>

<br/>
<h7>Research groups</h7>
<br/>
<div class="wrapper">
  <div class="logo">
    <div id="takuvik">
        <img src="takuvik.jpg" alt="">
    </div>
    <div id="chone">
        <img src="chone.jpg" alt="">
    </div>
    <div id="qcocean">
        <img src="logo-QO_png.png" alt="">
    </div>
    <div id="notregolf">
        <img src="Notre_Golfe.png" alt="">
    </div>
    <div id="csbq">
        <img src="SCBQ_logo2.png" alt="">
    </div>
    <div id="nceas">
        <img src="NCEAS.png" alt="">
    </div>
  </div>
  </div>
</div>

<br/>
<h7>Private</h7>
<br/>
<div class="wrapper">
  <div class="logo">
    <div id="inrest">
        <img src="INREST.png" alt="">
    </div>
    <div id="port7i">
        <img src="port7i.png" alt="">
    </div>
  </div>
  </div>
</div>

')
