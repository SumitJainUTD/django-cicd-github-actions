import time

from django.http import JsonResponse
from django.urls import path

from web.views import home, ping

urlpatterns = [
    path('', home),
    path('ping', ping)
]
