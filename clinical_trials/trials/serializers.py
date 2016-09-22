from .models import Trial
from rest_framework import serializers


class TrialSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Trial
        fields = ('rank','nct_number','title','recruitment','study_results','conditions','interventions','sponsor','gender','age','phases','enrolment','funded_by','study_types','study_designs','other_ids','first_received','start_date','completion_date','last_updated','last_verified','results_first_received','acronym','primary_completion_date','outcome_measures','url')
