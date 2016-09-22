options( stringsAsFactors=F ) 

# Read CSV downloaded from ClinicalTrials.gov
clinical_trials <- read.csv(file = "data/study_fields.csv")

# Restrict dataset to those with interventions marked "Drug" or "Biological"
relevant_interventions <- clinical_trials[which(grepl("Drug: ", clinical_trials$Interventions)>0 | grepl("Biological: ", clinical_trials$Interventions)>0), ]$Interventions

# Extract individual drugs from relevant interventions
all_drugs <- vector()

# relevant_interventions <- as.character(relevant_interventions)
# relevant_interventions <- sapply(relevant_interventions, function(x) strsplit(x, "|", fixed=TRUE))
# relevant_interventions <- as.character(relevant_interventions)
# print(head(relevant_interventions))
# relevant_interventions <- unlist(relevant_interventions, recursive=TRUE)
# print(head(relevant_interventions))
#print(head(relevant_interventions))

for (interventions in relevant_interventions) {
  interventions_list <- strsplit(interventions, "|", fixed=TRUE)
  interventions_list <- unlist(interventions_list)
  for (intervention in interventions_list) {
    if (startsWith(intervention, "Drug: ") | startsWith(intervention, "Biological: ")) {
      if (startsWith(intervention, "Drug: ")) {
        drugs <- substr(intervention, 7, nchar(intervention))
      }
      else if (startsWith(intervention, "Biological: ")) {
        drugs <- substr(intervention, 13, nchar(intervention))
      }
      # Remove parenthetical clauses
      drugs <- gsub( " *\\(.*?\\) *", "", drugs)
      
      if (!(drugs %in% all_drugs)) {
        all_drugs <- c(all_drugs, drugs)
      }
    }
  }
}
write.csv(all_drugs, file="all_drugs.txt", na="", row.names=TRUE)

# --------------------------------------

df <- data.frame(drug.name=all_drugs)

drugbank <- read.csv(file = "data/drugbank/drugbank vocabulary.csv", na.strings=c("NA","NaN", " ", ""))



#drugbank$has.synonyms <- ifelse(is.na(drugbank$Synonyms), FALSE, TRUE)



#drugbank[which(drugbank$has.synonyms==FALSE), ]$realname2 <- drugbank[which(drugbank$has.synonyms==FALSE), ]$Common.name

#drugbank[which(is.na(drugbank$Synonyms)), ]$realname <- drugbank[which(is.na(drugbank$Synonyms)), ]$Common.name
#drugbank[which(!is.na(drugbank$Synonyms)), ]$realname <- paste(drugbank[which(!is.na(drugbank$Synonyms)), ]$Common.name, " | ", drugbank[which(!is.na(drugbank$Synonyms)), ]$Synonyms)

#drugbank$drug.name <- mapply(
#  function(Common.name, Synonyms) {
#  ifelse(is.na(Synonyms),
#         Common.name,
#         paste(Common.name, " | ", Synonyms))},
#  drugbank$Common.name,
#  drugbank$Synonyms)


#drugbank$really <-  ifelse(is.na(drugbank$Synonyms),
#                             drugbank$Common.name,
#                             paste(drugbank$Common.name, " | ", drugbank$Synonyms))

drugbank$drug.name <- paste(drugbank$Common.name, " | ", drugbank$Synonyms)
#drugbank$drug.name2 <- substr(drugbank$drug.name, nchar(drugbank$drug.name)-4+1, nchar(drugbank$drug.name))

#drugbank$drug.name3 <- ifelse(drugbank$drug.name2 == "| NA", TRUE, FALSE)
#drugbank$drug.name4 <-nchar(drugbank$drug.name2)
#drugbank$drug.name5 <- ifelse()
#ifelse(substr(drugbank$drug.name, nchar(drugbank$drug.name)-5+1, nchar(drugbank$drug.name)) == " | NA",
#        "OWWW",
#               #substr(drugbank$drug.name, 1, nchar(drugbank$drug.name)-5),
#               drugbank$drug.name)


#  sapply(drugbank$drug.name, function(x) ifelse(substr(x, nchar(x)-5+1, nchar(x)) == " | NA",
#                                                                     substr(x, 1, nchar(x)-5),
#                                                                     x))


drugbank <- subset(drugbank, select=c("DrugBank.ID", "drug.name"))


#df <- merge(canonical_tags, connections, by="canonical_id", all.x=FALSE, all.y=TRUE)

# --------------------------------------

sanger <- read.csv(file = "data/sanger/Screened_Compounds -list with pathways.csv", stringsAsFactors=FALSE)
sanger$SYNONYMS <- gsub(","," | ", sanger$SYNONYMS)
sanger$SYNONYMS <- gsub("  "," ", sanger$SYNONYMS)
sanger$drug.names <- paste(sanger$DRUG.NAME, sanger$SYNONYMS)

sanger$TARGET <- gsub(","," | ", sanger$TARGET)
sanger$TARGET <- gsub("  "," ", sanger$TARGET)
sanger$target_list <- strsplit(sanger$TARGET, " | ", fixed=TRUE)
sanger$TARGET.PATHWAY <- as.character(sanger$TARGET.PATHWAY)

target_pathway_mapping <- data.frame(target=character(), pathway=character(), stringsAsFactors=FALSE)
all_targets <- vector()
for (i in 1:nrow(sanger)) {
  for (targets in sanger[i, ]$target_list) {
    for (target in targets) {
      if (!(target %in% all_targets)) {
        all_targets <- c(all_targets, target)
      }
      target_pathway_mapping <- rbind(target_pathway_mapping, c(as.character(target), as.character(sanger[i, ]$TARGET.PATHWAY)))
      
    }
  }
}

names(target_pathway_mapping) <- c("target", "pathway")

write.csv(all_targets, file="all_targets.txt", na="", row.names=TRUE)

all_pathways <- unique(sanger$TARGET.PATHWAY)
write.csv(all_pathways, file="all_pathways.txt", na="", row.names=TRUE)
write.csv(unique(target_pathway_mapping$pathway), file="all_pathways2.txt", na="", row.names=TRUE)



# --------------------------------------



# --------------------------------------

drug_targets <- read.csv(file = "data/drugbank/drugbank_all_target_polypeptide_ids.csv/all.csv")
drug_targets <- subset(drug_targets, select=c("Drug.IDs", "Gene.Name"))

drug_targets$drug_list <- strsplit(drug_targets$Drug.IDs, "; ", fixed=TRUE)

drug_target_mapping <- data.frame(drug_targets=character(), targets=character())
for (i in 1:nrow(drug_targets)) {
  for (drugs in drug_targets[i, ]$drug_list) {
    for (drug in drugs) {
      drug_target_mapping <- rbind(drug_target_mapping, c(as.character(drug), as.character(drug_targets[i, ]$Gene.Name)))
      #print(c(target, sanger[i, ]$TARGET.PATHWAY))
      #print(paste(target,sanger[i, ]$TARGET.PATHWAY))
    }
  }
}
names(drug_target_mapping) <- c("drug_id", "target")

Hash <- sapply(unique(drug_target_mapping$drug_id), function(x) {
  drug_target_mapping[drug_target_mapping$drug_id == x, 2]
}, simplify = FALSE)

Hash2 <- sapply(Hash, function(x) paste(x, collapse=" | "))

Hash3 <- as.data.frame(Hash2)
Hash3$drug_id <- rownames(Hash3)
rownames(Hash3) <- NULL
names(Hash3) <- c("targets", "drug_id")

final <- merge(drugbank, Hash3, by.x="DrugBank.ID", by.y="drug_id")
final <- subset(final, select=-DrugBank.ID)

# Read list of immunotherapy genes
immune <- read.csv(file = "data/InnateDB_genes immune system genes.csv")
immune <- as.character(immune$name)


final$immunotherapy <- logical(length=nrow(final))
final$pathways <- character(length=nrow(final))

for (i in 1:nrow(final)) {
  #print(final[i, ])
  for (targets in final[i, ]$targets) {
    targets_list <-  unlist(strsplit(targets, " | ", fixed=TRUE))
    pathways_list <- vector()
    for (mytarget in targets_list) {
      
      if (mytarget %in% immune) {
        final[i, ]$immunotherapy <- TRUE
      }
      
      
      pathway <- ""
      if (mytarget %in% target_pathway_mapping$target) {
        pathway <- target_pathway_mapping[which(target_pathway_mapping$target==mytarget), ]$pathway  
        
        if (!(is.null(pathway) || pathway=="" || pathway=="NA")) {
          #print(paste("PTHWAY:",pathway))
          if (!(pathway %in% pathways_list)){
            pathways_list <- c(pathways_list, pathway)
          }  
        }
      }
      #print(paste("PATH:", pathway))
      #print(paste(final[i,], "{{{{{", pathway, "}}}}}"))
    }
    #print("----")
  }
  final[i, ]$pathways <- paste(pathways_list, collapse=" | ")
  
  #target_pathway_mapping$immunotherapy <- sapply(target_pathway_mapping$target,
  #                                               function(x) {ifelse(x %in% immune, TRUE, FALSE)})
  
  # print("=============")
}


#drug_targets$drug_list <- strsplit(drug_targets$Drug.IDs, "; ", fixed=TRUE)

# --------------------------------------

write.csv(final, file="drug_table.csv", na="", row.names=TRUE)
