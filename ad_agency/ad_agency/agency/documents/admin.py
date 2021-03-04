from django.contrib import admin
from django.contrib.auth.models import Group
from .models import Document, DocumentType


class DocumentAdmin(admin.ModelAdmin):
    list_display = ['number', 'creation_date', 'document_type', 'responsible',
                    'client_order', 'project']
    ordering = ['number']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Account Manager').exists():
            return super().get_queryset(request).filter(document_type=DocumentType.objects.get(type_name='Договор'))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form =  super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Account Manager').exists():
            form.base_fields['document_type'].initial = DocumentType.objects.get(type_name='Договор')
            form.base_fields['document_type'].disabled = True
        return form


class DocumentTypeAdmin(admin.ModelAdmin):
    list_display = ['type_name']
    ordering = ['type_name']


admin.site.register(Document, DocumentAdmin)
admin.site.register(DocumentType, DocumentTypeAdmin)
