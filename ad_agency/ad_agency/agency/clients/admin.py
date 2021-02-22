from django.contrib import admin

from .models import Client, Company, Order

# Register your models here.
admin.site.register(Client)
admin.site.register(Company)
admin.site.register(Order)