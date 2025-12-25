import time

from django.http import HttpResponse, JsonResponse
from django.shortcuts import render


# Create your views here.

def home(request):
    return HttpResponse("Hello Django 👋, Testing CICD Pipeline!")


def ping(args):
    time.sleep(6)  # healthcheck timeout = 5s
    return JsonResponse({"status": "ok"})
