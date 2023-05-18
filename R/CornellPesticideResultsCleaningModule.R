###############################################################################
# Cleaning Cornell Results Dataset
###############################################################################
# view(pest_Results)

pest_results_cleaner <- function(pesticide_results, long_form = TRUE){
  
  # reading in the data -- is this something I need to do if I've already read the data into the driver? 
  pest_Results <- read.csv(pesticide_results, header = TRUE, stringsAsFactors = FALSE, skip = 1)
  
  # replace n.d. with NA
  pest_Results[pest_Results == "n.d."] <- NA
  
  # find our cut points
  LS_row <- which(pest_Results == "Large Scale", arr.ind=TRUE)[1]
  SS_row <- which(pest_Results == "Small Scale", arr.ind=TRUE)[1]
  SS_filename_row <- which(pest_Results == "File Name", arr.ind=TRUE)[1]
  bottom_row <- which(pest_Results == "Results are in ppb.", arr.ind=TRUE)[1] #find regex solution Results are in *
  
  
  # cut out our data frames
  LS_df <- pest_Results[1:(LS_row-1),]
  SS_df <- pest_Results[(SS_filename_row+1):(SS_row-1),]
  
  # cut out look up tables
  LS_lookup <- pest_Results[LS_row:(LS_row+3),]
  SS_lookup <- pest_Results[SS_row:(SS_row+3),]
  
  #######################################################
  # LIMIT FINDER FUNCTION
  #######################################################
  limit_finder <- function(df, search, lookup, scale){
    
    # find where samples say <loq
    loqVals <- data.frame(which(df == search, arr.ind=TRUE))
    
    if(length(loqVals$row>0)){
      
      # pull out mass and lod and do out the division
      mass <- as.numeric(df$Mass..g.[loqVals$row])
      scaleNum <- ifelse(search==">ULOQ", 3, 1) # convert scale into row index
      lod <- as.numeric(lookup[scaleNum,loqVals$col])
      
      results <- lod/mass
      
      # assign results to index where loq was found
      for(i in 1:length(results)){
        df[loqVals$row[i], loqVals$col[i]] <- results[i]
      }
    }
    return(df)
  }
  #######################################################
  
  LS_df <- limit_finder(df = LS_df, search = "<LOQ", lookup = LS_lookup)
  SS_df <- limit_finder(df = SS_df, search = "<LOQ", lookup = SS_lookup)
  LS_df <- limit_finder(df = LS_df, search = ">ULOQ", lookup = LS_lookup)
  SS_df <- limit_finder(df = SS_df, search = ">ULOQ", lookup = SS_lookup)
  
  # append dataframes
  pest_df <- rbind(LS_df, SS_df)
  
  # create small scale/large scale column
  pest_df$scale <- ifelse(pest_df$Mass..g. < 1, "small", "large")
  
  #getting rid of column "X'
  pest_df$X <- NULL
  
  if(long_form == TRUE){
    
    # Cornell Results to long form 
    pest_df_long <- melt(pest_df, 
                         id.vars = c("File.Name", "Client.ID1", "Client.ID2", "Mass..g.", "scale"))
    # changing column names 
    colnames(pest_df_long) # original column names
    pest_df_long_colnames <- c("file_name", "client_ID1", "client_ID2", "mass_g", "scale", "pesticide_name", "value")
    
    colnames(pest_df_long) <- pest_df_long_colnames
    
    df_out <- pest_df_long
  } else{
    
    df_out <- pest_df
    
  }

  return(df_out)
  }

# view(pest_results_cleaner(pest_Results))
  
# view(pest_df_long)

