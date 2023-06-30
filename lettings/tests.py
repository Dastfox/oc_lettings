from django.test import TestCase, Client
from django.urls import reverse
from .models import Letting, Address


class LettingViewTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.address1 = Address.objects.create(
            street="123 Test St",
            number="456",
            city="Test City",
            zip_code="12345",
            country_iso_code="USA",
        )
        self.address2 = Address.objects.create(
            street="789 Test St",
            number="1011",
            city="Test City",
            zip_code="12345",
            country_iso_code="USA",
        )
        self.letting1 = Letting.objects.create(
            title="Test Letting 1", address=self.address1
        )
        self.letting2 = Letting.objects.create(
            title="Test Letting 2", address=self.address2
        )

    def test_index_view(self):
        response = self.client.get(reverse("lettings:index"))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Test Letting 1")
        self.assertContains(response, "Test Letting 2")
        self.assertContains(response, "<title>Lettings</title>")

    def test_letting_view(self):
        response = self.client.get(
            reverse("lettings:letting", args=(self.letting1.id,))
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Test Letting 1")
        self.assertContains(response, "123 Test St")
        self.assertContains(response, "<title>Test Letting 1</title>")
