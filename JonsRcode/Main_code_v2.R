## Main code line for toms project
## Build drug matrix for each trial and assign similarity 

library(XML)

##load in data--------------------------------------------------------
## get list of trials
setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Source data")
trials <- read.csv("MSS CRC-Elegible Immunotherapy Trials (All Phase) .csv",stringsAsFactors=FALSE) 

## read in drugbank XML data
setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Source data")
xml.data <- xmlTreeParse("full database.xml",useInternalNodes=TRUE)
xml_data = xmlRoot(xml.data) #gives content of root

## Get ATC empty dataframe format for listed drugs as well as targets
setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Source data")
ATC_target_results <- read.csv("ATC and drug target template.csv",stringsAsFactors = FALSE)
ATC_target_results <- ATC_target_results[-1,] 

## Read in Target Pathways Dataframe - Sanger source
setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Source data")
pathway_df <- read.csv("Screened_Compounds edited with uniprot.csv",stringsAsFactors = FALSE)
## -----------------------------------------------------------------------

## build NCT and drug dataframe and then edit and process manually for now
## function uses clinicaltrials.gov API to extract drugs from each trial
trial_drugs <- import_drugs(trials)
setwd("C:/Users/jondy/Dropbox/KIP Health/Health project programing/Development/Tom trial list project")
write.csv(trial_drugs,"raw drug table - edit manually v2.csv")

## later add fuction to automatically process and format the data----------------------

## edit the drugs manually removing commas and "and" etc etc
trial_drugs <- read.csv("raw drug table - edit manually v4.csv",stringsAsFactors = FALSE)

## trim leading and trailing white space in updated names column
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
trial_drugs$updated_names <- trim(trial_drugs$updated_names)

## Calculate the Drugbank ID codes with Synonyms
drugbank_DB <- drugbank_drug_ID_DB(xml_data)

## Remove duplicated drugs from list
dup <- duplicated(tolower(trial_drugs[,"updated_names"]))
drug_list <- trial_drugs[!dup,"updated_names"]

## Add transformed name to drug_list df - to keep track of name changes
#initially set to the same names 
##drug_list_transform <- data.frame(original_drug_name=drug_list 
                                  ##,transformed_drug_name= drug_list,stringsAsFactors = FALSE)

## Build drug table with ATC values and targets----------------------------

## set maximim target to 5
max_targets_retrieve = 5

## drug list - to fill in the empty dataframe ATC_target_results
for (i in 1:length(drug_list)){
  
  drug_name <- drug_list[i]                            
  
  ## NCI database
  ##drug_main_name <- find_rec_num(drug_name,drug_synonym_frame)
  ##drug_main_name <- drug_main_name[1] ## use main name for search
  
  
  
  ## if no match in NCI database
  ##if (length(drug_main_name) == 0 ||is.na(drug_main_name)) {
    ##print("error drug not found in NCI DB")
    ## NA results for drug - not found in NCI DB
    ##temp_record <- c(drug_name,rep(NA,dim(ATC_target_results)[2]-1))
    ## change name back to original if no match
    ##drug_main_name <- drug_name
  ##} 
  
  drug_bank_ID <- search_drugbank(drugbank_DB,drug_name)
  
  ## if no match in drugbank ID
  if (is.na(drug_bank_ID)[1]) {
    print("error drug not found in drugbank")
    ## NA results for drug - not found in drugbank DB
    temp_record <- c(drug_name,rep(NA,dim(ATC_target_results)[2]-1))
    print("no match in drug bank")
    
  } else {
    
    
    ## keep track of transformed name in trial_drugs
    drug_list_transform$transformed_drug_name[i] <- drug_name
    
    drug_bank_record <- as.numeric(drug_bank_ID[1])
      
    ATC <- get_ATC(xml_data,drug_bank_record) ## get ATC from Drugbank
      
      
    targets <- get_target(xml_data,max_targets_retrieve,drug_bank_record)
      
    ## results to add 
    temp_record <- c(drug_name,drug_bank_ID[2],ATC,rep(NA,
                              7-length(ATC)),targets) 
      
    pathways <- get_pathways(temp_record,pathway_df,max_targets_retrieve)
      
    temp_record <- c(temp_record,pathways)
      
    
  }
  
  ATC_target_results[i,] <- temp_record  ## change later
  
}
## Build drug table with ATC values and targets----------------------------


## Mark new drugs and write the Drug ATC codes and targets to file 

## add new column to whether records was found in drugbank
index <- which(is.na(ATC_target_results[,2]))
new_col <- rep("yes",dim(ATC_target_results)[1])
new_col[index] <- "no"
new_col <- as.factor(new_col)

ATC_target_results$in_drug_bank <- new_col

## remove duplicates which result due to drug synonyms
dup <- which(duplicated(tolower(ATC_target_results[,"drug"])))
if (length(dup) > 0){ATC_target_results <- ATC_target_results[-dup,]} 

## order alphabetically
rearrange <- order(ATC_target_results$drug)
ATC_target_results <- ATC_target_results[rearrange,]

##------------------
write.csv(ATC_target_results,"atc and targets new v3.csv")

## Edited Manually the drug table to add immune categories
ATC_edited_results <- read.csv("atc and targets v8.csv",header = TRUE,stringsAsFactors = FALSE)


## produce results NCT_ID, Trial_main_cat, Trial_sub_cat
trial_drug_df <- calculate_trial_drug_df(ATC_edited_results,trial_drugs,drug_list_transform)
write.csv(trial_drug_df,"trials with categories.csv")








