## Function to extract targets names from Drugbank XML
## max_targets_retrieve - gets top x target.
## return drug_targets
get_target <- function(xml_data,max_targets_retrieve,record){
  ## select between different targets with x[[y]]
  ## x[[y]][["name"]] - for target name
  
  x <- (xml_data[[record]][["targets"]]) ## select record
  drug_targets <- character() ## initialize value to return
  uniprot_IDs <- character()
  
  
  
  
  
  
## tryto extract the external identifier containing the uniprot id
  
  
  
  
  ## if there is no result in drugbank then x == "" - skip ATC search and return character()
  if (xmlValue(x) != "") {
    
    num_targets <- min(c(xmlSize(x),max_targets_retrieve)) ## set max targets
    
    
    for (i in 1:num_targets){
      
      drug_targets[i] <- xmlValue(x[[i]][["name"]])
      y = (x[[i]][["polypeptide"]][["external-identifiers"]])
      
      if (is.null(y)){
        uniprot_IDs[i] = NA
      } else {
        
          for (k in 1:xmlSize(y)){
          
            if (xmlValue(y[[k]][["resource"]]) == "UniProtKB"){
              uniprot_IDs[i] = xmlValue(y[[k]][["identifier"]])
            
            
            }
          
          }
        
        
        }
      
     
      
      
    }
    
    
  }
  ## need to insert NA to fill holes in dataframe
  target_and_uniplot <- c(drug_targets,rep(NA,max_targets_retrieve - length(drug_targets)),
                          uniprot_IDs,rep(NA,max_targets_retrieve - length(uniprot_IDs)))
  return(target_and_uniplot)  
  
}

