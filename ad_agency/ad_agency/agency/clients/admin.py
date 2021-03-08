from django.contrib import admin
from advanced_filters.admin import AdminAdvancedFiltersMixin

from .models import Client, Company, Order
from staff.models import Employee

from helper.utils import extract_employee_id, russify_columns

admin.site.site_header = 'Ad-agency'
admin.site.site_title = 'Ad-agency'


class CompanyAdmin(AdminAdvancedFiltersMixin, admin.ModelAdmin):
    ordering = ['name']
    advanced_filter_fields = ('name')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['name', 'Название'], ['address', 'Адрес'], ['OGRN', 'ОГРН'],
                      ['INN', 'ИНН'], ['requisites', 'Реквизиты'], ['phone', 'Телефон']]
        russify_columns(self, to_russian)


class ClientAdmin(admin.ModelAdmin):
    ordering = ['last_name']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['last_name', 'Фамилия'], ['first_name', 'Имя'], ['patronymic', 'Отчество'],
                      ['company', 'Компания'], ['phone', 'Телефон'], ['email', 'Электронная почта']]
        russify_columns(self, to_russian)


class OrderAdmin(admin.ModelAdmin):
    ordering = ['client']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['manager', 'Менеджер'], ['client', 'Клиент'], ['description', 'Описание']]
        russify_columns(self, to_russian)

    def get_queryset(self, request):
        if request.user.groups.filter(name='Account Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(manager=Employee.objects.get(id=int(user_id)))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Account Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['manager'].initial = Employee.objects.get(id=int(user_id))
            form.base_fields['manager'].disabled = True
        return form


admin.site.register(Company, CompanyAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Order, OrderAdmin)
