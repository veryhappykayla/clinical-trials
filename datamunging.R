
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
write.csv(all_drugs, file="all_drugs.txt", na="", row.names=FALSE)