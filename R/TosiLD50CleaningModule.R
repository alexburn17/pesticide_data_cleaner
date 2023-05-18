################################################################################
# Cleaning LD50 Dataset -- Tosi Lethal
################################################################################
# looking to find the min LD50 value whether it be from contact or acute exposure types 
# put min value in its own column


tosi_lethal_cleaner <- function(tosi_lethal){
  
  # read in the data 
  tosi_lethal <- read.csv(tosi_lethal, header = TRUE, stringsAsFactors = FALSE, skip = 1)
  
  # convert blank spaces to NA 
  tosi_lethal[tosi_lethal == " "] <- NA
  tosi_lethal[tosi_lethal == ""] <- NA
  
  
  # changing column names 
  colnames(tosi_lethal) # original column names
  
  tosi_lethal_colnames <- c("pesticide_name", "other_names","cas", "pesticide_type", "MoA_short", "MoA_classification_site_target", "oral_LD50_geometricmean_ugbee", "oral_source_num","oral_LD50_min", "oralQ1", "oralQ2_median", "oralQ3", "oral_LD50_max", "oral_range", "oral_source_name", "oral_LD50_1", "oral_LD50_2", "oral_LD50_3", "oral_LD50_4", "oral_LD50_5", "contact_LD50_geometricmean_ugbee","contact_source_num","contact_LD50_min", "contactQ1", "contactQ2_median", "contactQ3", "contact_LD50_max","contact_range", "contact_source_name", "contact_LD50_1", "contact_LD50_2","contact_LD50_3")
  
  colnames(tosi_lethal) <- tosi_lethal_colnames
  
  
    # finding minLD50 value - all units are ug/bee
    # NOTE: Transform to PPB
  
  tl <- tosi_lethal %>% rowwise() %>% mutate(min_LD50_value = min(oral_LD50_min, oral_LD50_1, oral_LD50_2, oral_LD50_3, oral_LD50_4, oral_LD50_5, contact_LD50_min, contact_LD50_1, contact_LD50_2, contact_LD50_3, na.rm = TRUE))
  
  # remove Inf values
  tl$min_LD50_value <- ifelse(tl$min_LD50_value == "Inf", NA, tl$min_LD50_value)
  
  
  # remove rows with NA for LD50
  tosi_lethal_noNA <- tl[!is.na(tl$min_LD50_value), ]
  
  # summarize for each chemical 
  TL_simplified <- tosi_lethal_noNA %>% 
    group_by(pesticide_name) %>% # pick variables to group by
    summarise(
      
      min_LD50_value = min(min_LD50_value, na.rm=T), 
    ) 
  
  # unlike Tosi sublethal data, this dataset does not distinguish by publications or bee type 
  
  # view(TL_simplified)
  
  return(TL_simplified)
}

# view(tosi_lethal_cleaner(tosi_lethal))

