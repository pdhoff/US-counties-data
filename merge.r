## Dataframes to construct
dframes<-c("pop","geo","age","ses") 


## Source the code to construct the dataframes 
for(dfname in dframes){ 

  source(paste0("USC",dfname,".r"),local=TRUE) 
  cat(dfname,"\n") 
}


## Merge dataframes
usc<-readRDS( paste0("USC",dframes[1],".rds") )

for(i in seq(2,length(dframes),length=length(dframes)-1) ){

  usc<-merge(usc, readRDS( paste0("USC",dframes[i],".rds") ) )

}


## Save 

saveRDS(usc,file="UScounties.rds") 

write.csv(usc,file="UScounties.csv",row.names=FALSE) 


## Demo
if(FALSE){ 
  plot(usc$longitude,usc$latitude,ylim=c(23,50),xlim=c(-125,-65)) 


  cex<-( usc$medianIncome-min(usc$medianIncome) )/
       ( max(usc$medianIncome) -min(usc$medianIncome) )

  plot(usc$longitude,
       usc$latitude,cex=cex,
       ylim=c(23,50),xlim=c(-125,-65))
}


