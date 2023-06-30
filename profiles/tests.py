from django.test import TestCase, Client
from django.urls import reverse
from profiles.models import Profile
from django.contrib.auth.models import User


class ProfileViewTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.user1 = User.objects.create_user(username="user1", password="testpassword")
        self.user2 = User.objects.create_user(username="user2", password="testpassword")
        self.profile1 = Profile.objects.create(user=self.user1, favorite_city="City 1")
        self.profile2 = Profile.objects.create(user=self.user2, favorite_city="City 2")

    def test_index_view(self):
        response = self.client.get(reverse("profiles:index"))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "user1")
        self.assertContains(response, "user2")
        self.assertContains(response, "<title>Profiles</title>")

    def test_profile_view(self):
        response = self.client.get(reverse("profiles:profile", args=("user1",)))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "user1")
        self.assertContains(response, "City 1")
        self.assertContains(response, "<title>user1</title>")
