## Search for drug in drugbase DB and return recorde and drugbank_ID

search_drugbank <- function(drugbank_DB,drug){
  
  ## search for the drug in the drugbank database
  index <- which(grepl(drug, drugbank_DB[,"drugname"],ignore.case = TRUE))   
  
  code <- drugbank_DB[index[1],"code"]  ## take 1st index to take first result
  record <- drugbank_DB[index[1],"record"]
  
  return(c(record,code))  
  
  
}

 
