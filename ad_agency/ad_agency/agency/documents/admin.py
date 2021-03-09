from django.contrib import admin

from .models import Document, DocumentType
from projects.models import Project
from staff.models import Employee

from helper.utils import extract_employee_id, russify_columns


class DocumentAdmin(admin.ModelAdmin):
    ordering = ['number']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(project__in=Project.objects.filter(project_manager=Employee.objects.get
                                                                                           (id=int(user_id))))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['document_type'].initial = DocumentType.objects.get(type_name='Отчет о проделанной работе')
            form.base_fields['document_type'].disabled = True
            form.base_fields['responsible'].initial = Employee.objects.get(id=int(user_id))
            form.base_fields['responsible'].disabled = True
            form.base_fields['project'].queryset = Project.objects.filter(
                project_manager=Employee.objects.get(id=int(user_id)))
            form.base_fields['project'].required = True
        return form

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['number', 'Номер'], ['creation_date', 'Дата создания'],
                      ['document_type', 'Тип документа'], ['responsible', 'Отвественное лицо'],
                      ['client_order', 'Заказ'], ['project', 'Проект']]
        russify_columns(self, to_russian)


class DocumentTypeAdmin(admin.ModelAdmin):
    ordering = ['type_name']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['type_name', 'Тип']]
        russify_columns(self, to_russian)


admin.site.register(Document, DocumentAdmin)
admin.site.register(DocumentType, DocumentTypeAdmin)
