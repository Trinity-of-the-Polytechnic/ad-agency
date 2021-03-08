from django.contrib import admin

from .models import Document, DocumentType


class DocumentAdmin(admin.ModelAdmin):
    list_display = ['number', 'creation_date', 'document_type', 'responsible',
                    'client_order', 'project']
    ordering = ['number']


class DocumentTypeAdmin(admin.ModelAdmin):
    list_display = ['type_name']
    ordering = ['type_name']


admin.site.register(Document, DocumentAdmin)
admin.site.register(DocumentType, DocumentTypeAdmin)
