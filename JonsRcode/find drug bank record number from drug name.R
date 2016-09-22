## from a drug name find drugbank record number

find_rec_num <- function(drug,drug_synonym_frame){
  
  
  ## find the synonym columns
  start_col <- 4; end_col <- dim(drug_synonym_frame)[2]
  
  ## MAKE SURE DRUG AND DRUG_SYNONYMN_FRAME ARE IN SAME FORMAT---------
  ## covert both drug and drug synonyms to lower case
  drug <- tolower(drug)
  
  search_frame <- data.frame(lapply(drug_synonym_frame, function(v) {
    if (is.character(v)) return(tolower(v))
    else return(v)
  }))
  ## ----- lower case--------
  
  ## covert to character
  search_frame <- data.frame(lapply(search_frame, as.character), stringsAsFactors=FALSE)
  
  ## convert NA value to ""
  search_frame[is.na(search_frame)] = ""
  
  ## SAME FORMAT------------------------------------------------------------
  
  ## START SEARCH---------------------------
  index = as.numeric()
  
  ## search for match of drug
  for (i in start_col:end_col){
    
    for (k in 1:dim(search_frame)[1]){
      if (drug == search_frame[k,i]){
        index <- k
      }      
      
    }
    if (length(index) == 1){break}
    
  }
  
  ## END SEARCH----------------------------
  
  main_name <- as.character(drug_synonym_frame[index,start_col])
  
  return(main_name)
  
  
}