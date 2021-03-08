from django.contrib import admin

from advanced_filters.admin import AdminAdvancedFiltersMixin

from .models import Client, Company, Order

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
        # TODO add query set for account manager
        #if request.user.groups.filter(name='Account Manager').exists():
        #    return super().get_queryset(request).filter(manager='')
        #else:
        return super().get_queryset(request)


admin.site.register(Company, CompanyAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Order, OrderAdmin)
