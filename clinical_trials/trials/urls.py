from django.conf.urls import url, include

from .views import TrialViewSet, TrialIndivViewSet

from rest_framework import routers, serializers, viewsets

router = routers.DefaultRouter()
router.register(r'trials/many', TrialViewSet)
router.register(r'trials/individual', TrialIndivViewSet)

urlpatterns = [
    url(r'^api/', include(router.urls)),
]



