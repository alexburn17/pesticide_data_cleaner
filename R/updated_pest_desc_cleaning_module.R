#################################################
# Cleaning pest_Desc_updated (Colin descriptions)
#################################################


updated_pest_desc_cleaner <- function(pest_Desc_updated){
  
  #read in the data 
  pest_Desc_updated <- read.csv("data/updated_descriptions_4-1-23.csv")
  
  pest_Desc_updated[pest_Desc_updated == " "] <- NA
  pest_Desc_updated[pest_Desc_updated == ""] <- NA
  
  return(pest_Desc_updated)
  
}

view(updated_pest_desc_cleaner(pest_Desc_updated))



#### Original Code #### 

pest_Desc_updated[pest_Desc_updated == " "] <- NA
pest_Desc_updated[pest_Desc_updated == ""] <- NA
