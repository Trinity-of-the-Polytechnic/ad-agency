from django.contrib import admin

from helper.utils import extract_employee_id

from .models import Document, DocumentType
from projects.models import Project
from staff.models import Employee


class DocumentAdmin(admin.ModelAdmin):
    list_display = ['number', 'creation_date', 'document_type', 'responsible',
                    'client_order', 'project']
    ordering = ['number']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(project__in=Project.objects.filter(project_manager=
                                                                                           Employee.objects.get
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


class DocumentTypeAdmin(admin.ModelAdmin):
    list_display = ['type_name']
    ordering = ['type_name']


admin.site.register(Document, DocumentAdmin)
admin.site.register(DocumentType, DocumentTypeAdmin)
