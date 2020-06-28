

library(tiff)
library(sf)
library(tidyverse)
library(raster)
library(rgdal)
library(lubridate)


#In this script, we compare the two air temperature datasets that were used in the analysis
#We start by reading in the daily air temperature from the Hall data. This is the air tempeature modeled for every stream reach in the region from 1981 - 2014
#it is filtered to just include the summer months, may  - Sept

load(file = 'C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemperature_Baseline/temperature_K.RData')
temperature_C<- temperature_K %>% 
  mutate(temp_C = temp_K-273.15) %>% 
  dplyr::select(-temp_K)
rm(temperature_K)





#Next we need to extract the air temperature at each COMID from the Livneh data and calculate the mid range. We do this starting on the 11809th array because
#we want to start at 5/1/1982 to align with Hall et al.

comid<- temperature_C %>% 
  dplyr::select(COMID) %>% 
  unique()

#read in comid points and filter for the ones that will be used with the Livneh data
com1 <- st_read("C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/COMID_to_Point_AllCalifornia.shp") %>% 
  dplyr::select(COMID) %>% 
  dplyr::filter(COMID %in% comid$COMID) %>% 
  st_zm()

#read in Livneh et al 2015 Tmax
livneh_AirTemp_max <-readTIFF("C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/livneh_day_Tmax_clip_15Oct2014.1950-2013.tif")
#read in Livneh et al 2015 Tmin
livneh_AirTemp_min <-readTIFF("C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/livneh_day_Tmin_clip_15Oct2014.1950-2013.tif")


#dim: top 43.75 ; left -124.5625 ; right -113.375 ; bottom 31.5625
#proj <- GCS_WGS_1984


#Livneh et al Tmax:

dat<-NULL

#calculate range of dates we want
#range(StreamTemp_Livneh$date) -- "1962-01-18" "2013-12-31"
#ymd(19620117) - ymd(19500101) #4399 days

num<- 11809:23376
for (i in num){
  
  #catalog
  cat(i, '\t')
  
  #select day 1
  temp<-livneh_AirTemp_max[,,i]
  
  #reverse row to correct layout
  #temp <- temp[nrow(temp):1, ]
  #temp<- t(temp)
  #image(temp)
  
  #make raster file of TA
  temp<-raster(temp)
  extent(temp) <- matrix(c(-124.5625, 31.5625, -113.375, 43.75), nrow=2)
  crs(temp) <-   "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  #plot(temp)
  
  #extract temp value at each point
  pts <- as(com1$geometry, "Spatial") 
  temp_C<-extract(x=temp, y=pts) %>% data.frame()
  temp_C$COMID <- com1$COMID
  
  temp_C$date<- (ymd(19491231)+i)
  
  dat<-rbind(temp_C,dat)
  
}

names(dat)[1]<-"Tmax_C_liv"
save("dat", file = "C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/Tmax_C_liv.RData")

load("C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/Tmax_C_liv.RData")
temperature_C<- left_join(temperature_C, dat, by = c("COMID", "date")) #left joing to hall et al



#Livneh et al Tmin:

dat<-NULL


num<- 11809:23376
for (i in num){
  
  #catalog
  cat(i, '\t')
  
  #select day 1
  temp<-livneh_AirTemp_min[,,i]
  
  #make raster file of TA
  temp<-raster(temp)
  extent(temp) <- matrix(c(-124.5625, 31.5625, -113.375, 43.75), nrow=2)
  crs(temp) <-   "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  #plot(temp)
  
  #extract temp value at each point
  pts <- as(com1$geometry, "Spatial") 
  temp_C<-extract(x=temp, y=pts) %>% data.frame()
  temp_C$COMID <- com1$COMID
  
  temp_C$date<- (ymd(19491231)+i)
  
  dat<-rbind(temp_C,dat)
  
}

names(dat)[1]<-"Tmin_C_liv"
save("dat", file = "C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/Tmin_C_liv.RData")
load("C:/Users/JennyT/Documents/LitReview/RB4/AirTemp/AirTemp_Livneh/Tmin_C_liv.RData")

temperature_C<- left_join(temperature_C, dat, by = c("COMID", "date")) #left join to hall et al


#calulate mean air Temp (TempAir_C) as the average of the max and min air Temp
temperature_C <- temperature_C %>% 
  mutate(Tmean_C_liv = (Tmax_C_liv+Tmin_C_liv)/2,
         year = year(date)) %>% 
  filter(!is.na(Tmax_C_liv))




rm(dat)




#calculate correlation between hall and livneh, and check for impact of elevation, and month.


summary(lm(temp_C ~ Tmean_C_liv, data = temperature_C))

load("clusters.RData")

cor(temperature_C$temp_C, temperature_C$Tmean_C_liv, use = "complete.obs")
error <- (temperature_C$temp_C - temperature_C$Tmean_C_liv)
errorsq <- error^2
RMSE <- sqrt(mean(errorsq, na.rm = TRUE))

yrlyRMSE <- temperature_C %>% 
  group_by(year) %>% 
  summarise(RMSE = sqrt(mean((temp_C - Tmean_C_liv)^2, na.rm = TRUE)),
            meanLiv = mean(Tmean_C_liv),
            meanHal = mean(temp_C, na.rm = T))


mean(temperature_C$temp_C, na.rm = T) #18.97293
mean(temperature_C$Tmean_C_liv, na.rm = T) #19.52786
