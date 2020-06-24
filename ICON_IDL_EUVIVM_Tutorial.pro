PRO ICON_IDL_EUVIVM_Tutorial
;;;;
;
;Introduction of the science products
;Access all data products and data documents on the website: https://icon.ssl.berkeley.edu/Data
;FTP site: ftp://icon-science.ssl.berkeley.edu/pub
;
;The Ionospheric Connection Explorer, or ICON, is a new NASA Explorer mission that will explore
; the boundary between Earth and space to understand the physical connection between our world 
; and our space environment. 
;
;Please Read ICON Rules of the Road available @ https://icon.ssl.berkeley.edu/Data
;
;When acknowledging support from ICON in a publication, please include the following statement:
;  ICON is supported by NASA’s Explorers Program through contracts NNG12FA45C and NNG12FA42I.
;
;LEVEL.2 Data products:
;L2.1 MIGHTI -- Line-of-Sight Winds
;L2.2 MIGHTI -- Neutral Vector Winds -- Zonal Wind & Meridional Wind
;L2.3 MIGHTI-A/B* -- Neutral Temperature
;L2.4 FUV--Column O/N2
;L2.5 FUV--Nighttime O+ Density
;L2.6 EUV--Daytime O+ Denisty
;L2.7 IVM-A/B* -- Ion Drift/Ion Densities/Ion Temperature
;  A/B* are two identical instruments pointing to different directions.
;Note:
;Please read variable notes and quality flags for caveats, limitations, and best practices.
;The NetCDF files used here are only for demonstration. Please do not use the example data for publication - use official data sources instead.
;
;;;;

;Directory where data is located
dir = './'

;Files to be read.
fileEUV        = 'Example_L26_EUV.NC'
fileIVM        = 'Example_L27_IVM.NC'

;List of all variables within a NetCDF file.
;NCDF_LIST,dir+fileIVM,/VARIABLES

;Getting wanted EUV Variables into structure
VarEUV = ['Epoch',$
   'ICON_L26_Oplus',$
   'ICON_L26_Altitude',$
   'ICON_L26_HmF2',$
   'ICON_L26_NmF2',$
   'ICON_L26_Orbit_Number',$
   'ICON_L26_Local_Solar_Time',$
   'ICON_L26_Longitude',$
   'ICON_L26_Latitude',$
   'ICON_L26_Altitude',$
   'ICON_L26_Magnetic_Longitude',$
   'ICON_L26_Magnetic_Latitude',$
   'ICON_L26_Observatory_Longitude',$
   'ICON_L26_Observatory_Latitude',$
   'ICON_L26_Flags',$
   'ICON_L26_UTC_Time']

;Gets the listed variables and creates a structure (EUVData).  Without /STRUCT the variable
;  is a hash.  /Quiet surpresses reading outputs which can useful.
NCDF_GET,dir+fileEUV,VarEUV,EUVData,/STRUCT,/QUIET

;Each Data product has an Epoch variable which is the time of observation in number of milliseconds
;  since the UNIX Epoch (1970-01-01 00:00:00 UTC).  
;Every variable has a var_note attribute that gives information on the variable.  
;Here we are seperating the structure into different variables but keeping the metadata 
;with the variable.  We are also setting any fill value to NaN.
EUVEpoch = EUVData.Epoch
EUVEpoch.value[where(EUVEpoch.value EQ EUVEpoch.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVOplus    = EUVData.ICON_L26_Oplus
EUVOplus.value[where(EUVOplus.value EQ EUVOplus.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVAlt = EUVData.ICON_L26_Altitude
EUVAlt.value[where(EUVAlt.value EQ EUVAlt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVHmF2 = EUVData.ICON_L26_HmF2
EUVHmF2.value[where(EUVHmF2.value EQ EUVHmF2.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVNmF2 = EUVData.ICON_L26_NmF2
EUVNmF2.value[where(EUVNmF2.value EQ EUVNmF2.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVOrbit = EUVData.ICON_L26_Orbit_Number
EUVOrbit.value[where(EUVOrbit.value EQ EUVOrbit.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVslt   = EUVData.ICON_L26_Local_Solar_Time
EUVslt.value[where(EUVslt.value EQ EUVslt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVtlong = EUVData.ICON_L26_Longitude
EUVtlong.value[where(EUVtlong.value EQ EUVtlong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVtlat = EUVData.ICON_L26_Latitude
EUVtlat.value[where(EUVtlat.value EQ EUVtlat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVtmlong = EUVData.ICON_L26_Magnetic_Longitude
EUVtmlong.value[where(EUVtmlong.value EQ EUVtmlong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVtmlat = EUVData.ICON_L26_Magnetic_Latitude
EUVtmlat.value[where(EUVtmlat.value EQ EUVtmlat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVSClong = EUVData.ICON_L26_Observatory_Longitude
EUVSClong.value[where(EUVSClong.value EQ EUVSClong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVSClat = EUVData.ICON_L26_Observatory_Latitude
EUVSClat.value[where(EUVSClat.value EQ EUVSClat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

EUVUTC = EUVData.ICON_L26_UTC_Time

EUVFlags = EUVData.ICON_L26_Flags

;ICON_L26_Flags give warning flags for data.  See var_notes for details.  
badData = where(EUVFlags.value GT 1,/NULL)

EUVHmF2.value[badData] = !VALUES.F_NAN
EUVNmF2.value[badData] = !VALUES.F_NAN
EUVOplus.value[*,badData] = !VALUES.F_NAN
EUVtmlat.value[badData] = !VALUES.F_NAN

;Getting wanted IVM Variables into structure
VarIVM = ['Epoch',$
   'ICON_L27_Ion_Velocity_Meridional',$
   'ICON_L27_Ion_Density',$
   'ICON_L27_Magnetic_Latitude',$
   'ICON_L27_Magnetic_Longitude',$
   'ICON_L27_Solar_Local_Time',$
   'ICON_L27_Altitude',$
   'ICON_L27_Longitude',$
   'ICON_L27_Latitude',$
   'ICON_L27_Orbit_Number',$
   'ICON_L27_DM_Flag',$
   'ICON_L27_RPA_Flag',$
   'ICON_L27_UTC_Time']
   
NCDF_GET,dir+fileIVM,VarIVM,IVMData,/STRUCT,/QUIET

IVMEpoch = IVMData.Epoch
IVMEpoch.value[where(IVMEpoch.value EQ IVMEpoch.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMIonVeloMer = IVMData.ICON_L27_Ion_Velocity_Meridional
IVMIonVeloMer.value[where(IVMIonVeloMer.value EQ IVMIonVeloMer.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMIonDen = IVMData.ICON_L27_Ion_Density
IVMIonDen.value[where(IVMIonDen.value EQ IVMIonDen.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMmlat = IVMData.ICON_L27_Magnetic_Latitude
IVMmlat.value[where(IVMmlat.value EQ IVMmlat.attributes._FillValue,/NULL)]  = !VALUES.F_NAN

IVMmlong = IVMData.ICON_L27_Magnetic_Longitude
IVMmlong.value[where(IVMmlong.value EQ IVMmlong.attributes._FillValue,/NULL)]  = !VALUES.F_NAN

IVMslt = IVMData.ICON_L27_Solar_Local_Time
IVMslt.value[where(IVMslt.value EQ IVMslt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMalt = IVMData.ICON_L27_Altitude
IVMalt.value[where(IVMalt.value EQ IVMalt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMlong = IVMData.ICON_L27_Longitude
IVMlong.value[where(IVMlong.value EQ IVMlong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMlat = IVMData.ICON_L27_Latitude
IVMlat.value[where(IVMlat.value EQ IVMlat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMDMFlag = IVMData.ICON_L27_DM_Flag
IVMDMFlag.value[where(IVMDMFLAG.value EQ IVMDMFlag.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMRPAFlag = IVMData.ICON_L27_RPA_Flag
IVMRPAFlag.value[where(IVMRPAFlag.value EQ IVMRPAFlag.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMUTC = IVMData.ICON_L27_UTC_Time

IVMOrbit = IVMData.ICON_L27_Orbit_Number
IVMOrbit.value[where(IVMOrbit.value EQ IVMOrbit.attributes._FillValue,/NULL)] = !VALUES.F_NAN

;ICON_L27_DM_Flag and ICON_L27_RPA_Flag give warning flags for data.  See var_note for detials.
badData = where(IVMDMFlag.value NE 0 OR IVMRPAFlag.value GE 2,/NULL)
IVMIonDen.value[badData] = !VALUES.F_NAN


print,FORMAT='("Range of the orbit number: ",I0," to ",I0)',min(EUVOrbit.value),max(EUVOrbit.value)

;Find a preticular orbit and shift it by some value.
targetOrbit = 2200
shiftEpoch = 360.*4.

idxIVM = where(IVMOrbit.value EQ targetOrbit,/NULL) 
idxIVM = idxIVM+shiftEpoch

;Epoch times of IVM for the target orbit with shift.
t0 = IVMEpoch.value[idxIVM[0]]
t1 = IVMEpoch.value[idxIVM[-1]]

;Find the EUV Epoch values that are the same as the IVM Epoch values.
idxEUV = where(EUVEpoch.value GE t0 AND EUVEpoch.value LE t1,/NULL)

print,FORMAT='("Seleted time: ",A19," to ",A19)',IVMUTC.value[idxIVM[0]],IVMUTC.value[idxIVM[-1]]


;Below plots the NmF2 on magnetic latatiude and magnetic longitude with the
;  color related to the value of the NmF2.
p = scatterplot(EUVtmlong.value[idxEUV],EUVtmlat.value[idxEUV],$
   MAGNITUDE=EUVNmF2.value[idxEUV],$
   RGB_Table=33,$
   SYM='o',Dimensions=[1000,400],POSITION=[0.1,0.1,0.8,0.9],$
   /SYM_FILLED)

cb = colorbar(target=p,$
   orientation=1,$
   POSITION=[0.805,0.1,0.845,0.9],$
   TEXTPOS=1,$
   title=EUVNmF2.attributes.long_name+' ('+$
      EUVNmF2.attributes.units+'*$10^{5})$',$
   RANGE=[min(EUVNmF2.value[idxEUV])/1e5,max(EUVNmF2.value[idxEUV])/1e5])

;NaN exist within the IVM Ion Density because of the data filtering.
;The magnitude keywork will see these values to a color of 0, which is then plotted.
;This call advoids plotting those NaN.
idxCon = where(FINITE(IVMIonDen.value[idxIVM]) EQ 1,/NULL)
p1 = scatterplot(IVMmlong.value[idxIVM[idxCon]],IVMmlat.value[idxIVM[idxCon]],$
   MAGNITUDE=IVMIonDen.value[idxIVM[idxCon]],$
   RGB_Table=16,$
   SYM='x',$
  /SYM_FILLED,/OVERPLOT)

cb1 = colorbar(target=p1,$
   orientation=1,$
   TEXTPOS = 1,$
   POSITION=[0.905,0.1,0.945,0.9],$
   title=IVMIonDen.attributes.long_name+' ('+$
      IVMIonDen.attributes.units+'*$10^{5}$)',$
   RANGE=[min(IVMIonDen.value[idxIVM])/1e5,max(IVMIonDen.value[idxIVM])/1e5])

;p.xrange = [100,250]
p.xtitle = 'Magnetic Longitude (degrees)'
p.ytitle = 'Magnetic Latitude (degress)'
p.title = 'IVM-EUV Daytime Plasma'



;Plotting the ion density in time over a contour plot of the EUV O+.
IonDenplot = IVMIonDen.value[idxIVM]

;The EUV altitudes are two dimensional.  We can plot with assuming the 0th altitude
;  profile is similar enough to the other altitude profiles.
alts = EUVAlt.value[*,idxEUV[0]]
;Find altitude betwen 200 and 500 km.
alts0 = where(alts GE 200 AND alts LE 500.,/NULL)

;For easier plotting rename and transpose the EUV O+ variable.
Data = transpose(EUVOplus.value[*,idxEUV])
;Only plot O+ values between 1e5 and 8e5 cm^-3.
Data[where(Data GT 8e5,/NULL)] = !VALUES.F_NAN
Data[where(Data LT 1e5,/NULL)] = !VALUES.F_NAN

;Epoch is a long64 value and some operations are better done on either float or
;  double types.  With long64 converting to double does not mess up the epoch
;  values while converting to float can mess up the epoch values.
timeIVM = DOUBLE(IVMEpoch.value[idxIVM])
timeEUV = DOUBLE(EUVEpoch.value[idxEUV])
;For and x-axis that has the time format HH:MM we create a holder array that
;  maps to the epochs to be plotted so we can find the HH:MM string from the
;  UTC variable.
hld = indgen(n_elements(timeIVM))

;Setting margin and xrange makes it simpler to overplot the line and contour plots.
plot_margin = [0.05,0.1,0.18,0.15]
plot_xrange = [min(timeIVM),max(timeIVM)]

;Plot the wanted ion density.
p1 = plot(hld,IVMIonDen.value[idxIVM]/1e5,$
   'm3',$
   axis_style = 1,$
   margin = plot_margin,$
   xrange=[0,n_elements(timeIVM)-1],$
   dimension=[1000,500],$
   yrange=[0,2.5],$
   xtitle='Time UTC',$
   ytitle='Ion Density ($cm^{-3}*10^{5}$)',$
   title='ICON EUV L2.6 Oplus')

;Renaming the x-axis to have HH:MM time format.  There are better ways to do this
;  but for a simple example we use this method.
p1.axes[0].major = 10
p1.axes[0].minor = 0
TickValues = FIX(p1.axes[0].tickvalues)

name = []
for i=0,n_elements(TickValues)-1 do begin
   name = [name,IVMUTC.value[idxIVM[TickValues[i]]]]
endfor

p1.axes[0].tickname = STRMID(name,11,5)

;Overplot the contour plot of the O+ in the same time range as the ion density.
pe = contour(Data[*,alts0]/1e5,timeEUV,alts[alts0],$
   min_value=1,max_value=8,$
   RGB_TABLE=40,$
   axis_style = 4,$
   margin = plot_margin,$
   xrange = plot_xrange,$
   /FILL,/CURRENT)
   
DataYAxis = AXIS('Y',target=pe,location=[pe.xrange[-1],1,1],textpos=1,title='Altitude (km)')
cb = colorbar(target=pe,orientation=1,taper=3,TEXTPOS=1,TITLE='O+ Density ($cm^{-3}*10^{5}$)')
cb.POSITION=[cb.position[0]+0.05,cb.position[1],cb.position[2]+0.05,cb.position[3]]

;Since the ion density was plotted frist, we bring it in front of the contour plot.
p1.order,'bring_forward'

END
