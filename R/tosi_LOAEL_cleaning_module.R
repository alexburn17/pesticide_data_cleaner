################################################################################
# Cleaning LOAEL Dataset -- Tosi Sublethal 
################################################################################


tosi_LOAEL_cleaner <- function(tosi_sublethal){
  
  tosi_sublethal <- read.csv("data/Tosi_sublethal.csv", header = TRUE, stringsAsFactors = FALSE)
  
  colnames(tosi_sublethal)
  
  tosi_sublethal_colnames <- c("pesticide_name", "cas", "pesticide_type", "MoA_short", "MoA_classification_site_taret", "survey_inclusion_name", "screened_in_survey", "num_survery_screenings", "oral_LD50_geometricmean_ugbee", "oral_source_name", "contact_LD50_geometricmean_ugbee", "contact_source_name", "LOAEL_allunits", "LOAEL_unit_measure", "LOAEL_ug/bee/day", "LOAEL_category_ug/bee", "SubTR_LOAEL/LD50", "SubTR_category", "exposure_type_oral_v_contact", "exposure_type_acute_v_chronic", "exposure_duration_h", "time_after_exposure_of_significant_effect_h", "feedtype_main_category", "feedtype_subcategory", "feedtype_concentration", "bee_type", "bee_genus", "bee_species", "bee_species_details", "sublethal_effect_main_category", "sublethal_effect_subcategory", "sublethal_effect_details", "original_ref", "ref_year", "review_ref")
  
  colnames(tosi_sublethal) <- tosi_sublethal_colnames
  
  # colnames(tosi_sublethal) # verify new column names
  
  tosi_sublethal[tosi_sublethal == " "] <- NA
  tosi_sublethal[tosi_sublethal == ""] <- NA
  
  # if LOAEL_unit_measure does not equal ppb, convert the values of LOAEL to ppb based on the unit measure of LOAEL_unit_measure.
  ## ex./ if LOAEL_unit_measure == ppm, then multiply LOAEL by 1000. (output in new column?)
  ## but if it is another unit, apply different conversion factor
  
  tosi_sublethal$LOAEL_unit_measure <- as.character(tosi_sublethal$LOAEL_unit_measure)
  
  str(tosi_sublethal$LOAEL_unit_measure)
  which(table(tosi_sublethal$LOAEL_unit_measure)>=1)
  
  
  # could unit measures be put into a function for conversion to ppb? 
  tosi_sublethal_unit_measures <- c("µg/bee", "µM", "g/bee/week", "g/ha", "g/hive", "g/hm-2", "gals/acre", "μg", "μg/bee", 
                                    "μg/bee/day", "μg/larva", "μL", "μL/bee", "μM", "kg/ha", "MFR", "mL/bee", "mL/colony", 
                                    "mM", "mm3 /bee", "ng/L", "ng/ml", "nM", "nmol/bee", "nmol/day/bee", "ppb", "ppm", "unclear")
  
  
  tosi_sublethal$LOAEL_ug_per_bee <- tosi_sublethal$`LOAEL_ug/bee/day`
  
  # remove rows with NA for LOAEL
  tosi_sublethal_noNA <- tosi_sublethal[!is.na(tosi_sublethal$LOAEL_ug_per_bee), ]
  
  
  # make variable of bee genus simplified
  tosi_sublethal_noNA$bee_genus_simple <- ifelse(tosi_sublethal_noNA$bee_genus == "Apis", "Honeybee", ifelse(
    tosi_sublethal_noNA$bee_genus == "Bombus", "Bumblebee", "Other")
  )
  
  # TO DO: convert to PPB
  # LOAEL: Lowest Observed Adverse effect level
  # N studies found sublethal impacts of this chemical on beeGenera. The lowest concentration accross studies is X
  # summarize for each chemical - min value fro LOAEL - block by bee type and sum number of pubs
  TS_simplified <- tosi_sublethal_noNA %>% # operate on the dataframe (ds_2021) and assign to new object (pltN)
    group_by(pesticide_name, bee_genus_simple) %>% # pick variables to group by
    summarise(
      
      min_LOAEL_ug_per_bee = min(LOAEL_ug_per_bee, na.rm=T), # mean
      numPubs = length(original_ref),
      
    ) 
  
  return(TS_simplified)
  
}
  

view(tosi_LOAEL_cleaner(tosi_sublethal))
  














#### Original Code #### 

#view(tosi_sublethal)

colnames(tosi_sublethal)

tosi_sublethal_colnames <- c("pesticide_name", "cas", "pesticide_type", "MoA_short", "MoA_classification_site_taret", "survey_inclusion_name", "screened_in_survey", "num_survery_screenings", "oral_LD50_geometricmean_ugbee", "oral_source_name", "contact_LD50_geometricmean_ugbee", "contact_source_name", "LOAEL_allunits", "LOAEL_unit_measure", "LOAEL_ug/bee/day", "LOAEL_category_ug/bee", "SubTR_LOAEL/LD50", "SubTR_category", "exposure_type_oral_v_contact", "exposure_type_acute_v_chronic", "exposure_duration_h", "time_after_exposure_of_significant_effect_h", "feedtype_main_category", "feedtype_subcategory", "feedtype_concentration", "bee_type", "bee_genus", "bee_species", "bee_species_details", "sublethal_effect_main_category", "sublethal_effect_subcategory", "sublethal_effect_details", "original_ref", "ref_year", "review_ref")

colnames(tosi_sublethal) <- tosi_sublethal_colnames

# colnames(tosi_sublethal) # verify new column names

tosi_sublethal[tosi_sublethal == " "] <- NA
tosi_sublethal[tosi_sublethal == ""] <- NA

# if LOAEL_unit_measure does not equal ppb, convert the values of LOAEL to ppb based on the unit measure of LOAEL_unit_measure.
## ex./ if LOAEL_unit_measure == ppm, then multiply LOAEL by 1000. (output in new column?)
## but if it is another unit, apply different conversion factor

tosi_sublethal$LOAEL_unit_measure <- as.character(tosi_sublethal$LOAEL_unit_measure)

str(tosi_sublethal$LOAEL_unit_measure)
which(table(tosi_sublethal$LOAEL_unit_measure)>=1)


# could unit measures be put into a function for conversion to ppb? 
tosi_sublethal_unit_measures <- c("µg/bee", "µM", "g/bee/week", "g/ha", "g/hive", "g/hm-2", "gals/acre", "μg", "μg/bee", 
                                  "μg/bee/day", "μg/larva", "μL", "μL/bee", "μM", "kg/ha", "MFR", "mL/bee", "mL/colony", 
                                  "mM", "mm3 /bee", "ng/L", "ng/ml", "nM", "nmol/bee", "nmol/day/bee", "ppb", "ppm", "unclear")


tosi_sublethal$LOAEL_ug_per_bee <- tosi_sublethal$`LOAEL_ug/bee/day`

# remove rows with NA for LOAEL
tosi_sublethal_noNA <- tosi_sublethal[!is.na(tosi_sublethal$LOAEL_ug_per_bee), ]


# make variable of bee genus simplified
tosi_sublethal_noNA$bee_genus_simple <- ifelse(tosi_sublethal_noNA$bee_genus == "Apis", "Honeybee", ifelse(
  tosi_sublethal_noNA$bee_genus == "Bombus", "Bumblebee", "Other")
)

# TO DO: convert to PPB
# LOAEL: Lowest Observed Adverse effect level
# N studies found sublethal impacts of this chemical on beeGenera. The lowest concentration accross studies is X
# summarize for each chemical - min value fro LOAEL - block by bee type and sum number of pubs
TS_simplified <- tosi_sublethal_noNA %>% # operate on the dataframe (ds_2021) and assign to new object (pltN)
  group_by(pesticide_name, bee_genus_simple) %>% # pick variables to group by
  summarise(
    
    min_LOAEL_ug_per_bee = min(LOAEL_ug_per_bee, na.rm=T), # mean
    numPubs = length(original_ref),
    
  ) 

# TS_simplified


