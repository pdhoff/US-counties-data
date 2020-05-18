## US county geographic data


## Source: www.census.gov/geographies/mapping-files/time-series/geo/
## carto-boundary-file.html

zipFile<-"cb_2018_us_county_5m.zip"
zipDir<-tempdir()  

if(!is.element(zipFile,list.files())){

  zipLink<-"https://www2.census.gov/geo/tiger/GENZ2018/shp/cb_2018_us_county_5m.zip" 
  download.file(zipLink,paste0(zipDir,"/",zipFile))  

}

unzip(paste0(zipDir,"/",zipFile),exdir=zipDir)   
fileName<-"cb_2018_us_county_5m.shp" 


## Read data 
library(rgdal)
usc<-readOGR(paste0(zipDir,"/",fileName)) 



## FIPS ID 
fips<-as.character(usc$GEOID)  


## Land area in square meters  
area<-as.numeric(as.character(usc$ALAND))


## Latitude and longitude 
coords<-coordinates(usc) 


## Create data frame and save 
USCgeo<-data.frame(fips=fips,area=area,
         longitude=coords[,1],latitude=coords[,2])

saveRDS(USCgeo,file="USCgeo.rds") 


## Demo
if(FALSE){ 

  plot(coords)  

  l48<-which( 23< coords[,2] & coords[,2]<50 ) 

  plot(coords[l48,],cex=area[l48]/max(area[l48])) 

}


