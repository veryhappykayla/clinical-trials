from django.db import models

# Create your models here.


class Trial(models.Model):
    rank = models.IntegerField()
    nct_number = models.CharField(max_length=255)
    title = models.CharField(max_length=255)
    recruitment = models.CharField(max_length=255)
    study_results = models.CharField(max_length=255)
    conditions = models.CharField(max_length=255)
    interventions = models.CharField(max_length=255)
    sponsor = models.CharField(max_length=255)
    gender = models.CharField(max_length=255)
    age = models.CharField(max_length=255)
    phases = models.CharField(max_length=255, null=True, blank=True)
    enrolment = models.CharField(max_length=255)
    funded_by = models.CharField(max_length=255)
    study_types = models.CharField(max_length=255)
    study_designs = models.CharField(max_length=255)
    other_ids = models.CharField(max_length=255)
    first_received = models.CharField(max_length=255)
    start_date = models.CharField(max_length=255)
    completion_date = models.CharField(max_length=255)
    last_updated = models.CharField(max_length=255)
    last_verified = models.CharField(max_length=255)
    results_first_received = models.CharField(max_length=255)
    acronym = models.CharField(max_length=255)
    primary_completion_date = models.CharField(max_length=255)
    outcome_measures = models.CharField(max_length=255)
    url = models.CharField(max_length=255)

    def __str__(self):
        return self.nct_number

