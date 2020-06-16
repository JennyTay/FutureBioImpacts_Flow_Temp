# FutureBioImpacts_Flow_Temp  

This repository has data files and R Markdown files that we used to analyze the impacts to biology from projected streamflow and temperature changes due to climate change.  

**Biology model folder**   
  
**mod_chub_rf**: random forest model that predicts probability of occurence of arroyo chub using streamflow metrics at all timeframes   
**mod_chub_rf_3**: random forest model that predicts probability of occurence of arroyo chub using streamflow metrics at 3-year timeframes   
**mod_chub_rf_all**: random forest model that predicts probability of occurence of arroyo chub using streamflow metrics at all-year timeframes   
**mod_sucker_rf**: random forest model that predicts probability of occurence of Santa Ana sucker using streamflow metrics at all timeframes   
**mod_sucker_rf_3**: random forest model that predicts probability of occurence of Santa Ana sucker using streamflow metrics at 3-year timeframes   
**mod_sucker_rf_all**: random forest model that predicts probability of occurence of Santa Ana sucker using streamflow metrics at all-year timeframes   
**mod_toad_rf**: random forest model that predicts probability of occurence of arroyo toad using streamflow metrics at all timeframes   
**mod_toad_rf_3**: random forest model that predicts probability of occurence of arroyo toad using streamflow metrics at 3-year timeframes  
**mod_toad_rf_all**: random forest model that predicts probability of occurence of arroyo toad using streamflow metrics at all-year timeframes  
**mod_trout_rf**: random forest model that predicts probability of occurence of rainbow trout using streamflow metrics at all timeframes  
**mod_trout_rf_3**: random forest model that predicts probability of occurence of rainbow trout using streamflow metrics at 3-year timeframes  
**mod_trout_rf_all**: random forest model that predicts probability of occurence of rainbow trout using streamflow metrics at all-year timeframes  
**mod_turtle_rf**: random forest model that predicts probability of occurence of western pond turtle using streamflow metrics at all   timeframes  
**mod_vireo_rf**: random forest model that predicts probability of occurence of Least Bell's vireo using streamflow metrics at all timeframes  
**mod_vireo_rf_3**: random forest model that predicts probability of occurence of Least Bell's vireo using streamflow metrics at 3-year timeframes  
**mod_vireo_rf_all**: random forest model that predicts probability of occurence of Least Bell's vireo using streamflow metrics at all-year timeframes  



**Flow Metrics**  
  
**bsflowmetest.RData**: Flow metric predictions for the baseline wet, dry, and moderate year for all the NHD stream reaches in the study region   
**flowmetdt2.RData**: Flow metric predictions for the end-of-century wet, dry and moderate year for all the NHD stream reaches in the study region  
**flowmet_all.RData**: Flow metric predictions for the five flow metrics reported in manuscript one for the baseline and end-of-century wet, dry, and moderate years, for the NHD stream reaches in the study region, after removing the stream reaches that are altered  



**Stream Temperature Models**  
  
**max_temp_model.rda**: Linear regression model used to predict the maximum 7-day maximum stream temperature  
**mean_temp_model.rda**: Linear regression model used to predict the maximum 7-day mean stream temperature  
**min_temp_model.rda**: Linear regression model used to predict the  minimum 7-day minimum stream temperature  



**Stream temperature**  
  
**baseline_stream_temp.RData**:  Baseline annual stream temperature metric data for NHD stream reaches in the study region  
**baseline_stream_temp_wtrshd**:  Same as above, with watershed name and stream reach elevation   
**fut_strm_tmp.RData**:  Future annual predicted stream temperature metric data for NHD stream reaches in the study region  
**fut_strm_tmp_wtrshd.RData**:  Same as above, with watershed name and stream reach elevation   
**spp_tmp_dat.RData**:  Species presence and absence data associated with NHD stream reach COMIDs and dates and the modeled baseline temperature metrics  
**tmp_metrics_change.RData**: A shapefile with the difference in the end-of-century and the baseline temperature metrics for all the NHD stream reaches in the study region  



**geographic data**  
  
**wtrshd_bundry.RData**:  Shapefile with the names and geometries of the six watersheds in the study region  
**elv_comid.RData**: Stream elevations from StreamCat for each of the NHD stream reach COMIDs in the study region, along with the 'high' or 'low' designation that we used  
**NHD_strm_rvr_map.RData**: Shapefile of the NHD stream reaches in the study region with COMID, filtered for only streams and rivers  
**clusters.RData**: Shapefile with the selection of NHD stream reaches with no dams in the watershed and in the cluster with low land modifaction that we used in our analysis



**Scripts**  
  
**flow.Rmd**: Analysis of changes to streamflow  
**Temp.Rmd**:  Analysis of changes to stream temperature  
**bio_predictions.Rmd**:  Analysis for changes to habitat suitability  
**Timeframe_Comparrison.Rmd**:  Comparrison of results from models using short term (3 years) of streamflow data and the entire timeseries  
