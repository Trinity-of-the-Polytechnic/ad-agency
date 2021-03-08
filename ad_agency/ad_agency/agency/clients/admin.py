from django.contrib import admin
from advanced_filters.admin import AdminAdvancedFiltersMixin

from .models import Client, Company, Order
from staff.models import Employee

from helper.utils import extract_employee_id

admin.site.site_header = 'Ad-agency'
admin.site.site_title = 'Ad-agency'


class CompanyAdmin(AdminAdvancedFiltersMixin, admin.ModelAdmin):
    list_display = ['name', 'address', 'OGRN', 'INN', 'requisites', 'phone']
    ordering = ['name']
    advanced_filter_fields = ('name')


class ClientAdmin(admin.ModelAdmin):
    list_display = ['last_name', 'first_name', 'patronymic', 'company', 'phone', 'email']
    ordering = ['last_name']


class OrderAdmin(admin.ModelAdmin):
    list_display = ['description', 'client', 'manager']
    ordering = ['client']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Account Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(manager=Employee.objects.get(id=int(user_id)))
        else:
            return super().get_queryset(request)


admin.site.register(Company, CompanyAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Order, OrderAdmin)
