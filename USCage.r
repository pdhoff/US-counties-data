## Source: www.census.gov/newsroom/press-kits/2018/estimates-characteristics.html 

fileName<-"cc-est2017-alldata.csv" 

if(!is.element(fileName,list.files())){ 
  fileName<-c("https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/counties/asrh/cc-est2017-alldata.csv") 
}


## Read data
colClasses<-c(rep("character",5),rep("numeric",75)) 
usc<-read.csv(fileName,colClasses=colClasses)

## Most recent estimate is largest "YEAR"
usc<-usc[usc$YEAR==10,] 

## FIPS ID 
stateFips<-as.character(usc$STATE)
countyFips<-as.character(usc$COUNTY)
fips<-paste(stateFips,countyFips,sep="")

## Age groups

agrp<-usc$AGEGRP
tpop<-usc$TOT_POP

## 19 or less
idx<-(agrp<=4) 
popLeq19<-tapply( tpop[idx], fips[idx],sum) 

## between 20 and 64 
idx<-(4<agrp & agrp< 14 )
pop20to64<-tapply( tpop[idx], fips[idx],sum)

## 65 and over 
idx<-(agrp>=14)
popGeq65<-tapply( tpop[idx], fips[idx],sum)

## total  
popTotal<-popLeq19+pop20to64+popGeq65


## Make data frame and save
USCage<-data.frame(fips=names(pop20to64),
               pctLeq19=popLeq19/popTotal,
               pct20to64=pop20to64/popTotal,
               pctGeq65=popGeq65/popTotal) 


saveRDS(USCage,file="USCage.rds")








