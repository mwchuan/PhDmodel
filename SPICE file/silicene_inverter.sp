.TITLE 'Silicene Inverter'
* 12/12/2020 edited by muwen
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

*Some FET parameters:
.param t0=1.5e-9
.param L=10e-9  
.param W=10e-9
.param Ef=0
.param trf=.1p 



********************INVERTER*************************
XMn1  OUT IN GND nMOS  Lch=L  Efi=Ef  dia=W  Tox=t0
XMp2  OUT IN VDD pMOS  Lch=L  Efi=Ef  dia=W  Tox=t0



VDD VDD 0 Supply
VIN IN 0 0 PULSE 0 Supply 0 trf trf 0.5n 1n 

*An inverter drive another inverter
*CLOAD OUT 0 204.3652a
CLOAD OUT 0 130.69a

.OPTIONS LIST NODE POST=2
.TRAN .1n 4n
.PRINT TRAN V(IN) V(OUT)

* PDP calculation
.measure tran trise trig v(out) val='0.1*Supply' rise=1 targ v(out) val='0.9*Supply' rise=1
.measure tran tfall trig v(out) val='0.9*Supply' fall=1 targ v(out) val='0.1*Supply' fall=1
.measure tran tplh trig v(in) val='0.5*Supply' fall=1 targ v(out) val='0.5*Supply' rise=1
.measure tran tphl trig v(in) val='0.5*Supply' rise=1 targ v(out) val='0.5*Supply' fall=1
.measure tran tpd param='(tphl+tplh)/2'
.measure tran AVG_Power avg p(VDD) from=0p to=4n
.measure tran PDP param='AVG_Power*tpd'
.measure tran EDP param='AVG_Power*tpd*tpd'

.END 
