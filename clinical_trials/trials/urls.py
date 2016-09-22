from django.conf.urls import url, include

from .views import TrialViewSet

from rest_framework import routers, serializers, viewsets

router = routers.DefaultRouter()
router.register(r'trials', TrialViewSet)

urlpatterns = [
    url(r'^api/', include(router.urls)),
]



