from django.shortcuts import render_to_response
from django.http import HttpResponse

from .models import Trial
from .serializers import TrialSerializer
from rest_framework import viewsets


# ViewSets define the view behavior.
class TrialViewSet(viewsets.ModelViewSet):
    queryset = Trial.objects.all()[:10]
    serializer_class = TrialSerializer


class TrialIndivViewSet(viewsets.ModelViewSet):
    queryset = Trial.objects.all()
    serializer_class = TrialSerializer
    lookup_field = 'nct_number'








