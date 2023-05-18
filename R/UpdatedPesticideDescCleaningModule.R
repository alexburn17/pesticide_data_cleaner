#################################################
# Cleaning pest_Desc_updated (Colin descriptions)
#################################################


updated_pest_desc_cleaner <- function(pest_Desc_updated){
  
  #read in the data 
  pest_Desc_updated <- read.csv(pest_Desc_updated)
  
  pest_Desc_updated[pest_Desc_updated == " "] <- NA
  pest_Desc_updated[pest_Desc_updated == ""] <- NA
  
  return(pest_Desc_updated)
  
}