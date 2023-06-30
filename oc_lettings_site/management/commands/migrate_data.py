from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from oc_lettings_site.models import (
    Profile as OldProfile,
    Address as OldAddress,
    Letting as OldLetting,
)
from profiles.models import Profile as NewProfile
from lettings.models import Address as NewAddress, Letting as NewLetting


class Command(BaseCommand):
    help = "Migrate data from old models to new ones"

    def handle(self, *args, **options):
        # Migrate Profile data
        for old_profile in OldProfile.objects.all():
            user = User.objects.get(id=old_profile.user.id)  # Fetching the associated user
            new_profile = NewProfile.objects.create(
                user=user,
                favorite_city=old_profile.favorite_city,
            )

        # Migrate Address data
        for old_address in OldAddress.objects.all():
            new_address = NewAddress.objects.create(
                number=old_address.number,
                street=old_address.street,
                city=old_address.city,
                state=old_address.state,
                zip_code=old_address.zip_code,
                country_iso_code=old_address.country_iso_code,
            )

        # Migrate Letting data
        for old_letting in OldLetting.objects.all():
            new_letting = NewLetting.objects.create(
                title=old_letting.title,
                address=NewAddress.objects.get(id=old_letting.address.id),
            )

        self.stdout.write(self.style.SUCCESS("Data migration completed successfully"))
