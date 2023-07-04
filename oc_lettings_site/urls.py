from django.contrib import admin
from django.urls import include, path

from . import views

# dont lint this line


urlpatterns = [
    path("", views.index, name="index"),
    path("lettings/", include("lettings.urls"), name="lettings"),
    path("profiles/", include("profiles.urls"), name="profiles"),
    path("admin/", admin.site.urls),
    path("sentry-debug/", views.trigger_error, name="sentry-debug"),
]
