## US county data from USDA

## Source: www.ers.usda.gov/data-products/county-level-data-sets/download-data/

## Read in education and income data  

fileNameEdu<-"Education.csv" 
fileNameInc<-"Unemployment.csv"

if(!is.element(fileNameEdu,list.files())){
  fileNameEdu<-"https://www.ers.usda.gov/webdocs/DataFiles/48747/Education.csv" 
}

if(!is.element(fileNameInc,list.files())){
  fileNameInc<-"https://www.ers.usda.gov/webdocs/DataFiles/48747/Unemployment.csv" 
}


edu<-read.csv(fileNameEdu,colClasses = "character") 
inc<-read.csv(fileNameInc,colClasses = "character")

## FIPS ID 
fips<-as.character(edu$FIPS.Code)  
fips[nchar(fips)==4]<-paste("0",fips[nchar(fips)==4],sep="") 


## Percent of adults with Bachelors or higher
pctBdegree<-edu$"Percent.of.adults.with.a.bachelor.s.degree.or.higher..2014.18"
pctBdegree<-as.numeric(pctBdegree)/100 


## Education data
eduData<-data.frame(fips=fips,pctBdegree=pctBdegree) 


## Now do the same for income data
fips<-as.character(inc$FIPStxt) 
medianIncome<-as.numeric(gsub(",","",inc$Median_Household_Income_2018) )
incData<-data.frame(fips=fips,medianIncome=medianIncome)

## Merge 
USCses<-merge(eduData,incData)

## Remove states
isState<-substr(as.character(USCses$fips),3,5)=="000" 
USCses<-USCses[ !isState,] 

## Save 
saveRDS(USCses,file="USCses.rds") 

## Demo
if(FALSE){ 

  with(USCses,plot(pctBdegree,medianIncome))   

}


