################################################
# Cleaning Pest_Desc Dataset (NHBS descriptions)
################################################


NHBS_description_cleaner <- function(pest_Desc){
   
  # read in the data 
  pest_Desc <- read.csv("data/pestDesc.csv", header = TRUE, stringsAsFactors = FALSE)
  
  # changing column names 
  colnames(pest_Desc) # original column names 
  
  pest_Desc_colnames <- c("pesticide_name", "description", "pesticide_type")
  
  colnames(pest_Desc) <- pest_Desc_colnames
  
  # colnames(pest_Desc) # verify new column names
  
  # eliminating rows with redundant values from transition to csv 
  pest_Desc <- subset(pest_Desc, pest_Desc$pesticide_name != "Pesticide") 
  
  return(pest_Desc)

}

view(NHBS_description_cleaner(pest_Desc))







#### Original Code #### 
# changing column names 
colnames(pest_Desc) # original column names 

pest_Desc_colnames <- c("pesticide_name", "description", "pesticide_type")

colnames(pest_Desc) <- pest_Desc_colnames

# colnames(pest_Desc) # verify new column names

# eliminating rows with redundant values from transition to csv 
pest_Desc <- subset(pest_Desc, pest_Desc$pesticide_name != "Pesticide") 
