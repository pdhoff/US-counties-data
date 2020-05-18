## US county population data

## Source: www2.census.gov/programs-surveys/popest/datasets/2010-2019/
## counties/totals/

fileName<-"co-est2019-alldata.csv"

if(!is.element(fileName,list.files()) ){
  fileName<-"https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv" 
}


## Read data 
colClasses<-c(rep("character",7),rep("numeric",157)) 
usc<-read.csv(fileName,colClasses=colClasses) 


## FIPS ID 
stateFips<-as.character(usc$STATE) 
countyFips<-as.character(usc$COUNTY) 
fips<-paste(stateFips,countyFips,sep="")


## County and state names
state<-usc$STNAME
county<-usc$CTYNAME 


## Population 
population<-usc$POPESTIMATE2019
births<-usc$BIRTHS2019
deaths<-usc$DEATHS2019
internationalMigration<-usc$INTERNATIONALMIG2019
domesticMigration<-usc$DOMESTICMIG2019 


## Create data frame and save
USCpop<-data.frame(fips=fips,stateFips=stateFips,countyFips=countyFips,
               state=state,county=county,
               population=population,births=births,deaths=deaths,
               internationalMigration=internationalMigration,
                domesticMigration=domesticMigration) 

USCpop<-USCpop[ USCpop$countyFips!="000",] # states

saveRDS(USCpop,file="USCpop.rds")


## Demo 
if(FALSE){ 

  with(USCpop, plot( internationalMigration/population, births/deaths) ) 

}


