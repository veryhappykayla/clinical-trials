from django.shortcuts import render_to_response
from django.http import HttpResponse

from .models import Trial
from .serializers import TrialSerializer
from rest_framework import viewsets


def index(request):
    hot_trials = Trial.objects.order_by('-rank')[:5]
    output = ', '.join([t.nct_number for t in hot_trials])
    return HttpResponse(output)


# ViewSets define the view behavior.
class TrialViewSet(viewsets.ModelViewSet):
    queryset = Trial.objects.all()
    serializer_class = TrialSerializer
    lookup_field = 'nct_number'





