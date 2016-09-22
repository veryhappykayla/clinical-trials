## Function to extract ATC code from Drugbank XML
get_ATC <- function(xml_data,record){

  
  x <- (xml_data[[record]][["atc-codes"]])
  ATC_vector <- character() ## set ATC empty character 
  
  ## if there is no result in drugbank then x == "" - skip ATC search and return character()
  if (xmlValue(x) != ""){
    
    size <- xmlSApply(x, xmlSize) #number of levels
    
    
    k =1  
    for (i in size:1){ ## step in reverse direction
      
      ## correct for reversing direction using k
      ATC_vector[k] <- xmlValue(x[[1]][[i]])
      k = k +1
    }
    ## place final attribute as final ATC_vector value
    ATC_vector[k] <- xmlAttrs(x[[1]])
    
    
  }
  
  return(ATC_vector)
    
  
}
  

