from django.contrib import admin

from .models import Client, Company, Order

admin.site.site_header = 'Ad-agency'
admin.site.site_title = 'Ad-agency'

class CompanyAdmin(admin.ModelAdmin):
    list_display = ['name', 'address', 'OGRN', 'INN', 'requisites', 'phone']
    ordering = ['name']


class ClientAdmin(admin.ModelAdmin):
    list_display = ['last_name', 'first_name', 'patronymic', 'company', 'phone', 'email']
    ordering = ['last_name']


class OrderAdmin(admin.ModelAdmin):
    list_display = ['description', 'client', 'manager']
    ordering = ['client']


admin.site.register(Company, CompanyAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Order, OrderAdmin)
