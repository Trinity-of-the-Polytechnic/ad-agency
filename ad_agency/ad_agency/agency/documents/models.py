from django.db import models

from staff.models import Employee
from clients.models import Order
from projects.models import Project


class DocumentType(models.Model):
    type_name = models.CharField(max_length=50)

    def __str__(self):
        return self.type_name

    class Meta:
        verbose_name = 'Тип документы'
        verbose_name_plural = 'Типы документов'


class Document(models.Model):
    number = models.CharField(max_length=255)
    creation_date = models.DateTimeField(null=True, blank=True)
    document_type = models.ForeignKey(DocumentType, on_delete=models.CASCADE)
    responsible = models.ForeignKey(Employee, on_delete=models.CASCADE, null=True, blank=True)
    client_order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.number

    class Meta:
        verbose_name = 'Документ'
        verbose_name_plural = 'Документы'


