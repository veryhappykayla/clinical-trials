options( stringsAsFactors=F ) 

# Read CSV downloaded from ClinicalTrials.gov
clinical_trials <- read.csv(file = "data/study_fields.csv")
clinical_trials$drugs = character(length=nrow(clinical_trials))

for (i in 1:nrow(clinical_trials)) {
  all_trial_drugs_list <- vector()
  for (interventions in clinical_trials[i, ]$Interventions) {
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
        all_trial_drugs_list <- c(all_trial_drugs_list, drugs) 
      }
    }
  }
  clinical_trials[i, ]$drugs <- paste(all_trial_drugs_list, collapse=" | ")
}

write.csv(subset(clinical_trials, select=c("NCT.Number", "drugs")), file="nct_drugs.csv", row.names = FALSE)