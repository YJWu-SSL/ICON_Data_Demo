PRO ICON_IDL_MIGHTI_Tutorial
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
fileTemps      = 'Example_L23_Temperature.NC'

;List of all variables within a NetCDF file.
;NCDF_LIST,dir+fileTemps,/VARIABLES

;Getting wanted Wind Variables into structure
VarWinds = ['Epoch',$
   'ICON_L22_Zonal_Wind',$
   'ICON_L22_Meridional_Wind',$
   'ICON_L22_Altitude',$
   'ICON_L22_Wind_Quality',$
   'ICON_L22_UTC_Time',$
   'ICON_L22_Orbit_Number',$
   'ICON_L22_Local_Solar_Time']

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

windQual    = windData.ICON_L22_Wind_Quality
windQual.value[where(windQual.value EQ windQual.attributes._FillValue,/NULL)] = !VALUES.F_NAN

windUTC     = windData.ICON_L22_UTC_Time
windUTC.value[where(windUTC.value EQ windUTC.attributes.FillVal,/NULL)] = !VALUES.F_NAN

windOrbit    = windData.ICON_L22_Orbit_Number
windOrbit.value[where(windOrbit.value EQ windOrbit.attributes.FillVal,/NULL)] = !VALUES.F_NAN

windSLT    = windData.ICON_L22_Local_Solar_Time
windSLT.value[where(windSLT.value EQ windSLT.attributes.FillVal,/NULL)] = !VALUES.F_NAN

;Wind Quality should be equal to 1 for best data.
badData = where(windQual.value NE 1,/NULL)
windZon.value[badData] = !VALUES.F_NAN
windMer.value[badData] = !VALUES.F_NAN

;Getting wanted Temperature Variables into structure
VarTemps = ['Epoch',$
   'ICON_L23_MIGHTI_A_Temperature',$
   'ICON_L23_MIGHTI_A_Tangent_Altitude',$
   'ICON_L23_MIGHTI_A_Tangent_Latitude',$
   'ICON_L23_MIGHTI_A_Tangent_Longitude',$
   'ICON_L23_MIGHTI_A_UTC_Time',$
   'ICON_L23_MIGHTI_A_Tangent_Solar_Local_Time',$
   'ICON_L23_Observatory_Latitude',$
   'ICON_L23_Observatory_Longitude',$
   'ICON_L23_Orbit_Number',$
   'ICON_L1_MIGHTI_A_Quality_Flag_South_Atlantic_Anomaly',$
   'ICON_L1_MIGHTI_A_Quality_Flag_Bad_Calibration']

NCDF_GET,dir+fileTemps,VarTemps,tempData,/STRUCT,/QUIET

tempEpoch   = tempData.Epoch
tempEpoch.value[where(tempEpoch.value EQ tempEpoch.attributes._FillValue,/NULL)] = !VALUES.F_NAN

temp     = tempData.ICON_L23_MIGHTI_A_Temperature
temp.value[where(temp.value EQ temp.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempAlt    = tempData.ICON_L23_MIGHTI_A_Tangent_Altitude
tempAlt.value[where(tempAlt.value EQ tempAlt.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempLat    = tempData.ICON_L23_MIGHTI_A_Tangent_Latitude
tempLat.value[where(tempLat.value EQ tempLat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempLong    = tempData.ICON_L23_MIGHTI_A_Tangent_Longitude
tempLong.value[where(tempLong.value EQ tempLong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempsLat    = tempData.ICON_L23_Observatory_Latitude
tempsLat.value[where(tempsLat.value EQ tempsLat.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempsLong    = tempData.ICON_L23_Observatory_Longitude
tempsLong.value[where(tempsLong.value EQ tempsLong.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempSLT    = tempData.ICON_L23_MIGHTI_A_Tangent_Solar_Local_Time
tempSLT.value[where(tempSLT.value EQ tempSLT.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempOrbit    = tempData.ICON_L23_Orbit_Number
tempOrbit.value[where(tempOrbit.value EQ tempOrbit.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempQualSAA = tempData.ICON_L1_MIGHTI_A_Quality_Flag_South_Atlantic_Anomaly
tempQualSAA.value[where(tempQualSAA.value EQ tempQualSAA.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempQualBadCal = tempData.ICON_L1_MIGHTI_A_Quality_Flag_Bad_Calibration
tempQualBadCal.value[where(tempQualBadCal.value EQ tempQualBadCal.attributes._FillValue,/NULL)] = !VALUES.F_NAN

tempUTC    = tempData.ICON_L23_MIGHTI_A_UTC_Time

;Block on the SAA location and when the Calibration was bad.
badData = where(tempQualSAA.value NE 0 AND tempQualBadcal.value NE 0,/NULL)

tempEpoch.value[badData] = !VALUES.F_NAN
temp.value[badData,*] = !VALUES.F_NAN

print,format='("Range of the orbit number: ",I0," to ",I0)',min(tempOrbit.value),max(tempOrbit.value)

;Find preticular orbit and shift.
targetOrbit = 2211
shiftEpoch = -50.

idxtemp = where(tempOrbit.value EQ targetOrbit,/NULL)
idxtemp = idxtemp+shiftEpoch


t0 = tempEpoch.value[idxtemp[0]]
t1 = tempEpoch.value[idxtemp[-1]]

;Find the values when the winds are at the same time as the temperatures.
idxwind = where(windEpoch.value GE t0 AND windEpoch.value LE t1,/NULL)


idxtempSLT = where(abs(tempSLT.value[idxtemp]-12) LT 5)  

print,format='("Selected time: ",A19," to ",A19)',tempUTC.value[idxtemp[0]],tempUTC.value[idxtemp[-1]]


;Makeing plotting variables to make plotting calls simpler.
tempp = temp.value[idxtemp,*]
temppslt = tempslt.value[idxtemp,*]

;Since altitudes at the tangent points change with the temperature data we find a 
;  median value to plot against.
temppalt = median(tempalt.value[idxtemp,*],dimension=1)

;Filter to only plot between 8 to 17 hours Solar Local Time and 90 to 115 km.
idxtempSLT = where(temppslt[*,0] GE 8 AND temppslt[*,0] LE 17,/NULL)
idxtempAlt = where(temppalt GE 90 AND temppalt LE 115,/NULL)

;To show a plot of the solar local times for the wind and temperature data we grab the values
;  at ~103 km.
tempplong = tempLong.value[idxtemp,5]
tempplat  = tempLat.value[idxtemp,5]


;Making plotting variables to make plotting calls simpler.
windp = transpose(windZon.value[*,idxwind])
windpslt = transpose(windSLT.value[*,idxwind])
windpalt = windAlt.value

;Filter to only plot between 8 and 17 hours Solar Local Time and 90 to 115 km.
idxwindSLT = where(windpslt[*,0] GE 8 AND windpslt[*,0] LE 17,/NULL)
idxwindAlt = where(windpalt GE 90 AND windpalt LE 115,/NULL)

;Plot a contour plot of the temperature and wind data for a set of daytime data.  Also show the latitude
;  and longitude of the Solar Local Times.
p = contour(tempp[idxtempSLT,idxtempAlt[0]:idxtempAlt[-1]],temppslt[idxtempSLT,0],temppalt[idxtempAlt],$
   LAYOUT = [1,3,1],$
   yrange=[90,115],$
   xrange=[8,17],$
   RGB_TABLE=4,$
   DIMENSIONS=[1000,450],$
   Title='ICON L2.3 Temperature',/FILL)
cb = colorbar(target=p,orientation=1,TEXTPOS=1,Title='K')
cb.position = [p.position[2],p.position[1],p.position[2]+0.01,p.position[3]]
p.xtitle = 'Solar Local Time (hr)'
p.ytitle = 'Altitude (km)'


p1 = contour(windp[idxwindSLT,idxwindAlt[0]:idxwindAlt[-1]],windpslt[idxwindSLT,0],windpalt[idxwindAlt],$
   LAYOUT = [1,3,2],$
   yrange=[90,115],$
   xrange=[8,17],$
   RGB_TABLE=70,$
   Title='ICON L2.2 Zonal Wind',/FILL,/CURRENT)
cb1 = colorbar(target=p1,orientation=1,TEXTPOS=1,Title='m/s') 
cb1.position= [p1.position[2],p1.position[1],p1.position[2]+0.01,p1.position[3]]   
p1.xtitle = 'Solar Local Time (hr)'
p1.ytitle = 'Altitude (km)'  
  

p2 = scatterplot(tempplong,tempplat,magnitude=temppslt[*,5],$
   LAYOUT=[1,3,3],$,
   /SYM_FILLED,$
   RGB_TABLE=67,$
   /CURRENT) 
cb2 = colorbar(target=p2,range=[0,24],MAJOR=7,orientation=1,TEXTPOS=1,Title='hr')
cb2.position= [p2.position[2],p2.position[1],p2.position[2]+0.01,p2.position[3]]
p2.xtitle = 'Longitude (degrees)'
p2.ytitle = 'Latitude (degress)'
p2.title = STRING(FORMAT='Solar Local Times at %i km Tangent Altitude',temppalt[5])

;Find noon and overplot it.
idx12 = where(abs(temppSLT[*,0]-12) EQ MIN(abs(temppSLT[*,0]-12)),/NULL)
tempLong12 = tempplong[idx12]
tempLat12 = tempplat[idx12]

p2 = plot([tempLong12,tempLong12],[tempLat12,tempLat12],'ro',$
   LAYOUT=[1,3,3],$
   SYM_SIZE=1.,$
   Name='Noon Time',/SYM_FILLED,/OVERPLOT)
lg = legend(target=p2,/DATA,POSITION=[100,45],SAMPLE_WIDTH=0)


END
