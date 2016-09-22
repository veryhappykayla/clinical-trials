## Build the feature vector for a trial - for similarity analysis

build_trial_feature_vector <- function(drug_data){
  
  drug_list <- read.table("all_drugs.txt",stringsAsFactors = FALSE, sep=",",header = TRUE)
  
  drug_feature_names <- character()
  for (i in 1:dim(drug_list)[1]){
    
    drug_feature_names <- c(drug_feature_names,paste0("drug_",i))
    
    
  }
  
  gene <- read.table("all_targets.txt" ,stringsAsFactors = FALSE,sep=",",header = TRUE)
  
  gene_feature_names <- character()
  for (i in 1:dim(gene)[1]){
    
    gene_feature_names <- c(gene_feature_names,paste0("gene_",i))
    
    
  }
  
  
  
  pathway <- read.table("all_pathways.txt" ,stringsAsFactors = FALSE,sep=",",header = TRUE)
  pathway_feature_names <- character()
  for (i in 1:dim(pathway)[1]){
    
    pathway_feature_names <- c(pathway_feature_names,paste0("pathway_",i))
    
    
  }
  

  
  features <- c("trial_NCT","immunotherapy",drug_feature_names,gene_feature_names,pathway_feature_names)
  
  
  feature_frame <- data.frame(matrix(NA, nrow = 0, ncol = length(features)))
  
  names(feature_frame) <- features
  
  
}