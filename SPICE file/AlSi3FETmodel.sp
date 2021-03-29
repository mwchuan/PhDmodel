* Transistor model using 4-piece cubic spline

* 26/11/2020 edited by muwen

.TITLE 'IV Characteristics for AlSi3 Transistor'

.options POST=2
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-9 
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13
.option itl1 = 5000
.param   TEMP=27

.lib 'CSmuwen.lib' CSmuwen

***************************************************
*Beginning of circuit and device definitions

*Supplies and voltage params:
.param Supply=0.6  	
.param Vg='Supply'
.param Vd='Supply'

*************************************************

*Some FET parameters:
.param t0=1.5e-9
.param L=10e-9      
.param Vt=0	
.param Walsi3=1

***********************************************************************
* Define power supply
	
Vdd     Drain   Gnd     Vd
Vss     Source  Gnd     0
Vgg 	Gate	Gnd 	Vg

***********************************************************************
* Main Circuits
* nFET
*XMn1  Drain Gate Source  nAlSi3 Lch=L  Vth=Vt  dia=Walsi3  Tox=t0

* pFET
XMp1  Drain Gate Source  pSilicene Lch=L  Vth=Vt  dia=Walsi3  Tox=t0

***********************************************************************
* Measurements

* test nFETs, Ids vs. Vds
*.DC      Vdd   START=0     STOP='Supply'   STEP='0.01' 
*+ SWEEP  Vgg   START=0     STOP='Supply'   STEP='0.05'

* test pFETs, Ids vs. Vgs
.DC      Vdd   START=0     STOP='-Supply'   STEP='-0.025' 
+ SWEEP  Vgg   START=0     STOP='-Supply'   STEP='-0.05'
***********************************************************************
*.print I(XMp1)
.end 



