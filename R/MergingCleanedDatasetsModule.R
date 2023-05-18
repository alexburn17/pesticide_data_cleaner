##################
# Merging Datasets 
##################

# cleaned_data_merger <- function(pest_Desc_combined, tosi_combined, tosiDesc_combined, pest_DescResults_combined)

  
#### Original Code #### 

## 1st description dataset merge 
# Merging pest_Desc_additionalinfo to pest_Desc, creating pest_Desc_combined
pest_Desc_combined <- merge(y = pest_Desc, x = pest_Desc_additionalinfo, by = "pesticide_name", all = TRUE)
# view(pest_Desc_combined)

##2nd description dataset merge 
# Merging pest_Desc_updated into pest_Desc_combined
pest_Desc_combined <- merge(y = pest_Desc_combined, x = pest_Desc_updated , by = "pesticide_name", all = TRUE)
#view(pest_Desc_combined)


## if other_pesticide_name in pest_Desc_combined == pesticide_name, delete row pertaining to the other pesticide name 


# Merging Tosi Datasets 
tosi_combined <- merge(TL_simplified, TS_simplified, by = "pesticide_name", all = TRUE)
# view(tosi_combined)

# Merging Tosi combined dataset with the combined pesticide description dataset 
tosiDesc_combined <- merge(tosi_combined, pest_Desc_combined, by = "pesticide_name", all = TRUE)
# view(tosiDesc_combined)

# removing unwanted columns 
tosiDesc_combined <- tosiDesc_combined %>% 
  select(-description.x, -description.y, -pesticide_type.y)

# view(tosiDesc_combined)


# Merging combined pesticide description dataset and the long form of Cornell results 

pest_DescResults_combined <- merge(tosiDesc_combined, pest_df_long, by = "pesticide_name", all = TRUE)
view(pest_DescResults_combined) ## not sure if this was the final dataset we are looking for 
