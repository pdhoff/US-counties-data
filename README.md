This code generates a dataset containing a variety of information on US counties (FIPS areas) from various US governmental agencies, including the following: 

* population (US census) 
* migration (US census) 
* births and deaths (US census) 
* age distribution (US census) 
* land area (US census) 
* socioeconomic status (USDA) 

Information on these variables requires merging several different datasets. 
To generate the data files `UScounties.rds` and `UScounties.csv`,  source the `merge.r` file in an R session. This will source several `USCxxx.r` files, each one of which loads a different raw dataset and creates a dataframe. Then the code loads the dataframes, merges them and saves the result to the working directory. 




