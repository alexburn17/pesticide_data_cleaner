# driver script for calling pesticide cleaning data functions

library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape2)

# set working directory
setwd("~/Documents/GitHub/pesticide_data_cleaner")


# Read in Datasets:

## Read in Cornell Results Dataset !NOTE! - find more general solution to white space/column headers
pest_Results <- read.csv("data/pesticide_results_2021.csv", header = TRUE, stringsAsFactors = FALSE, skip = 1)

## Read in Tosi Datasets 
tosi_lethal <- read.csv("data/Tosi_lethal.csv", header = TRUE, stringsAsFactors = FALSE, skip = 1)

tosi_sublethal <- read.csv("data/Tosi_sublethal.csv", header = TRUE, stringsAsFactors = FALSE)

## Read in Description Dataset (NHBS descriptions)
pest_Desc <- read.csv("data/pestDesc.csv", header = TRUE, stringsAsFactors = FALSE)

## Read in additional description information (classification info in Google Sheet from Colin)
pest_Desc_additionalinfo <- read.csv("data/pestDesc_additioninfo.csv", header = TRUE, stringsAsFactors = FALSE)

## Read in updated description information - Colin 
pest_Desc_updated <- read.csv("data/updated_descriptions_4-1-23.csv")



# Source 
  ## Function 

source("R/cornell_results_cleaning_module.R")
  pest_Results_cleaned <- pest_results_cleaner(pest_Results)

source("R/tosi_LD50_cleaning_module.R")
  tosi_lethal_cleaned <- tosi_lethal_cleaner(tosi_lethal)
  
source("R/tosi_LOAEL_cleaning_module.R")
  tosi_sublethal_cleaned <- tosi_LOAEL_cleaner(tosi_sublethal)
  
source("R/NHBS_description_cleaning_module.R")
  NHBS_cleaned <- NHBS_description_cleaner(pest_Desc)
  
source("R/updated_pest_desc_cleaning_module.R")
  pest_Desc_updated_cleaned <- updated_pest_desc_cleaner(pest_Desc_updated)
  

# !NOTE -- COLIN! -- need to double check where pest_Desc_additionalinfo comes into play, was not cleaned in the modulated functions 
  
  
# Removing Old Datasets 
rm(pest_Results, tosi_lethal, tosi_sublethal, pest_Desc, pest_Desc_updated)
  
source("R/merging_cleaned_datasets_module.R")
  # in data_cleaning_pesticides.R, the merged data was all in one script, need to merge cleaned data from this driver script, 
  # thinking this will require changnig the datasets called in the function to their new names 
  
  





# source functions/modules
# source("R/addNumbers.R")
#### PROGRAM BODY: ####
# number_adder(num1 = 2, num2 = 3)


