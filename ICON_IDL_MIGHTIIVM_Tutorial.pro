pro ICON_IDL_MIGHTIIVM_Tutorial
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

fileWinds      = 'Example_L22_Wind.NC'
fileIVM        = 'Example_L27_IVM.NC'

;List of all variables within a NetCDF file.
;NCDF_LIST,dir+fileWinds,/VARIABLES

;Getting wanted Wind Variables into structure
VarWinds = ['Epoch',$
   'ICON_L22_Zonal_Wind',$
   'ICON_L22_Meridional_Wind',$
   'ICON_L22_Altitude',$
   'ICON_L22_Longitude',$
   'ICON_L22_Latitude',$
   'ICON_L22_Local_Solar_Time',$
   'ICON_L22_Wind_Quality',$
   'ICON_L22_UTC_Time',$
   'ICON_L22_Orbit_Number']

;Gets the listed variables and creates a structure (windData).  Without /STRUCT the variable
;  is a hash.  /Quiet surpresses reading outputs which can useful.
NCDF_GET,dir+fileWinds,VarWinds,windData,/STRUCT,/QUIET

;Each Data product has an Epoch variable which is the time of observation in number of milliseconds
;  since the UNIX Epoch (1970-01-01 00:00:00 UTC).  
;Every variable has a var_note attribute that gives information on the variable.  
;Here we are seperating the structure into different variables but keeping the metadata 
;with the variable.  We are also setting any fill value to NaN.
windEpoch   = windData.Epoch
windEpoch.value[where(windEpoch.value EQ windEpoch.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windZon     = windData.ICON_L22_Zonal_Wind
windZon.value[where(windZon.value EQ windZon.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windMer    = windData.ICON_L22_Meridional_Wind
windMer.value[where(windMer.value EQ windMer.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windAlt     = windData.ICON_L22_Altitude
windAlt.value[where(windAlt.value EQ windAlt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windLong     = windData.ICON_L22_Longitude
windLong.value[where(windLong.value EQ windLong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windLat     = windData.ICON_L22_Latitude
windLat.value[where(windLat.value EQ windLat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windlst    = windData.ICON_L22_Local_Solar_Time
windlst.value[where(windlst.value EQ windlst.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windQual    = windData.ICON_L22_Wind_Quality
windQual.value[where(windQual.value EQ windQual.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windUTC     = windData.ICON_L22_UTC_Time
windUTC.value[where(windUTC.value EQ windUTC.attributes.FillVal,/NULL)] = !VALUES.F_NAN

windOrbit    = windData.ICON_L22_Orbit_Number
windOrbit.value[where(windOrbit.value EQ windOrbit.attributes.FillVal,/NULL)] = !VALUES.F_NAN

;Wind Quality should be equal to 1 for best data.
badData = where(windQual.value NE 1,/NULL)
windZon.value[badData] = !VALUES.F_NAN
windMer.value[badData] = !VALUES.F_NAN

;Getting wanted IVM Variables into structure
VarIVM = ['Epoch',$
   'ICON_L27_Ion_Velocity_Meridional',$
   'ICON_L27_Magnetic_Latitude',$
   'ICON_L27_Solar_Local_Time',$
   'ICON_L27_Altitude',$
   'ICON_L27_UTC_Time',$
   'ICON_L27_Orbit_Number',$
   'ICON_L27_DM_Flag',$
   'ICON_L27_RPA_Flag',$
   'ICON_L27_Ion_Temperature']
   
NCDF_GET,dir+fileIVM,VarIVM,IVMData,/STRUCT,/QUIET

IVMEpoch = IVMData.Epoch
IVMEpoch.value[where(IVMEpoch.value EQ IVMEpoch.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMIonVeloMer = IVMData.ICON_L27_Ion_Velocity_Meridional
IVMIonVeloMer.value[where(IVMIonVeloMer.value EQ IVMIonVeloMer.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMmlat = IVMData.ICON_L27_Magnetic_Latitude
IVMmlat.value[where(IVMmlat.value EQ IVMmlat.attributes._FillValue,/NULL)]  = !VALUES.F_NAN

IVMslt = IVMData.ICON_L27_Solar_Local_Time
IVMslt.value[where(IVMslt.value EQ IVMslt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMalt = IVMData.ICON_L27_Altitude
IVMalt.value[where(IVMalt.value EQ IVMalt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMDMFlag = IVMData.ICON_L27_DM_Flag
IVMDMFlag.value[where(IVMDMFLAG.value EQ IVMDMFlag.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMRPAFlag = IVMData.ICON_L27_RPA_Flag
IVMRPAFlag.value[where(IVMRPAFlag.value EQ IVMRPAFlag.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMUTC = IVMData.ICON_L27_UTC_Time

IVMOrbit = IVMData.ICON_L27_Orbit_Number
IVMOrbit.value[where(IVMOrbit.value EQ IVMOrbit.attributes._FillValue,/NULL)] = !VALUES.F_NAN

IVMTemp = IVMData.ICON_L27_Ion_Temperature
IVMTemp.value[where(IVMTemp.value EQ IVMTemp.attributes._FillValue,/NUll)] = !VALUES.F_NAN

;ICON_L27_DM_Flag and ICON_L27_RPA_Flag give warning flags for data.  See var_note for detials.
badData = where(IVMDMFlag.value NE 0 OR IVMRPAFlag.value GE 2,/NULL)
IVMIonVeloMer.value[badData] = !VALUES.F_NAN

print,format='("Range of the orbit number: ",I0," to ",I0)',min(windOrbit.value),max(windOrbit.value)

;Find frist equator crossing.
icon_near_equator = where(abs(IVMmlat.value) LT 1.,/NULL)
daytime = where(abs(IVMslt.value[icon_near_equator] - 12.) LT 6.,/NULL)

ii = icon_near_equator[daytime[0]]
t0 = IVMEpoch.value[ii]

print,format='("ICON near equator starting at ",A19)',IVMUTC.value[ii] 
 
;Find MIGHTI index that correspodes to the IVM time
im = where(abs(windEpoch.value - t0) EQ min(abs(windEpoch.value - t0)),/NULL)

IVMIonp = IVMIonVeloMer.value[ii]
IVMAltp = IVMAlt.value[ii]

;Plot the Zonal and Meridional winds at the time of the IVM magnetic meridional velocity measurement.
p =  plot([IVMIonp,IVMIonp],[IVMAltp,IVMAltp],'s',/SYM_FILLED,$
   Name='Vertical Ion Velocity',$
   Title='Observations of neutral wind and ion velocity\non nearly !Cidentical magnetic field lines')
p1 = plot(windZon.value[*,im],windAlt.value[*,im],'b',/overplot,Name='Zonal Neutral Wind')
p2 = plot(windMer.value[*,im],windAlt.value[*,im],'g',/OVERPLOT,Name='Meridional Neutral Wind')
lg = legend(Target=[p,p1,p2],/DATA,POSITION=[-25,550])
p.xtitle = 'Velocity (m/s)'
p.ytitle = 'Altitude (km)'


END
