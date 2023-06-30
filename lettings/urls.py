from django.urls import path

from . import views

app_name = "lettings"

urlpatterns = [
    # path("", views.index, name="index"),
    path("", views.index, name="index"),
    path("<int:letting_id>/", views.letting, name="letting"),
    # path("profiles/", views.profiles_index, name="profiles_index"),
    # path("profiles/<str:username>/", views.profile, name="profile"),
    # path("admin/", admin.site.urls),
]
