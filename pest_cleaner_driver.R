# BeeLab 
# Driver script for calling pesticide cleaning data functions
# 05/15/2023

library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape2)

# set working directory
setwd("~/Documents/GitHub/pesticide_data_cleaner")


# source modules for data cleaning process
source("R/CornellPesticideResultsCleaningModule.R")
source("R/TosiLD50CleaningModule.R")
source("R/TosiLOAELCleaningModule.R")
source("R/NHBSdescCleaningModule.R")
source("R/UpdatedPesticideDescCleaningModule.R")

# source module for data merging process 
source("R/MergingCleanedDatasets.R")


################################################################################
# Program Body for Data Cleaning 
################################################################################
# In this section, the script is calling on functions from modules to clean datasets. 

# Calling the function pest_results_cleaner to clean the Cornell Pesticide Results
# Parameters: 
# pest_results: Data In 
# long_form: transition Cornell data to long form 
# Output: cleaned Cornell pesticide results
pesticideResultsCleaned <- pest_results_cleaner(pesticide_results = "data/PesticideResults2021.csv", long_form = TRUE)


# Calling the function tosi_lethal_cleaner to clean Tosi Lethal (LD50) data 
# Parameters: 
# tosi_lethal: Data In 
# Output: Cleaned Tosi Lethal (LD50) data
tosiLethalCleaned <- tosi_lethal_cleaner(tosi_lethal = "data/TosiLethal.csv")


# Calling the function tosi_sublethal_cleaner to clean Tosi Sublethal (LOAEL) data 
# Parameters: 
# tosi_sublethal: Data In 
# Output: Cleaned Tosi SubLethal (LOAEL) data 
tosiSubLethalCleaned <- tosi_LOAEL_cleaner(tosi_sublethal = "data/TosiSubLethal.csv")


# Calling the function NHBS_desctiption_cleaner to clean NHBS description data
# Parameters: 
# pest_Desc: Data In 
# Output: Cleaned NHBS descriptions 
NHBSdescCleaned <- NHBS_description_cleaner(pest_Desc = "data/NHBSpesticideDescriptions.csv")


# Calling the function updated_pest_desc_cleaner to clean Updated Pesticide Description Data 
# Parameters: 
# pest_Desc_updated: Data In 
# Output: Cleaned Updated Pesticide Description Information 
updatedPesticideDescCleaned <- updated_pest_desc_cleaner(pest_Desc_updated = "data/UpdatedDescriptions_4-1-23.csv")
  


################################################################################
# Program Body for Cleaned Data Merging 
################################################################################

# Calling on the function cleaned_data_merger to merge the cleaned datasets one at a time. 
# Parameters: 
# pest_Desc_combined: Data In -- Merge of pesticide description data from pesticideResultsCleaned
# tosi_combined: Data in from -- Merge of tosi (LD50 and LOAEL) data from tosiLethalCleaned and tosiSubLethalCleaned
# tosiDesc_combined: Data in from -- Merge of pesticide description data and tosi data from pest_Desc_combined and tosi_combined
# pest_DescResults_combined: Data in from -- Merge of description data, tosi data and Cornell Results into one dataset 
# Output: pest_DescResults_combined dataset, complete merge of all data 
cleaned_data_merged <- cleaned_data_merger(pest_Desc_combined = TRUE, #if statements still need to be created for each  of these in modular script
                                           tosi_combined = TRUE,      
                                           tosiDesc_combined = TRUE, 
                                           pest_DescResults_combined = TRUE)



# source functions/modules
# source("R/addNumbers.R")
#### PROGRAM BODY: ####
# number_adder(num1 = 2, num2 = 3)

## Naming Structures 
#dataCleaner.R
#data_cleaner()

