## function to generate dataframe of Drugbank code and all synomys of drug name
##record number | record|drugname


drugbank_drug_ID_DB <- function(xml_data){
  
  num_records <- xmlSize(xml_data)
  ## record number, DrugbankID and Drug
  drugbase_drug_names <- data.frame(record = as.numeric(),code = as.character(),
                        drugname = as.character(),stringsAsFactors=FALSE)
  counter = 1
  
  for (i in 1:num_records){
    
    temp_code <- xmlValue(xml_data[[i]][["drugbank-id"]])
    
    drugbase_drug_names[counter,] <-  c(i,temp_code,xmlValue(xml_data[[i]][["name"]]))
    counter = counter + 1 
     
    ## synonyms have mutliple attributes
    num_synonyms <- xmlSize(xml_data[[i]][["synonyms"]])
    if (num_synonyms > 0){
      
      for (k in 1:num_synonyms){
        ## read through and insert synonyms into dataframe
        drugbase_drug_names[counter,] <-  c(i,temp_code,xmlValue(xml_data[[i]][["synonyms"]][[k]]))
        counter = counter + 1 
      }
    }
    
  }
  setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Source data")
  write.csv(drugbase_drug_names,"recordnum drugbankID main_drug.csv")## write it to file for records
  
  return(drugbase_drug_names) 
  
  
  
}