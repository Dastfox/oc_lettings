from django.test import TestCase, Client
from django.urls import reverse


class IndexViewTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_index_view(self):
        response = self.client.get(reverse("index"))

        self.assertContains(response, "<title>Holiday Homes</title>")
        self.assertEqual(response.status_code, 200)
