from django.contrib import admin

from .models import Document, DocumentType

from helper.utils import russify_columns


class DocumentAdmin(admin.ModelAdmin):
    ordering = ['number']

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
