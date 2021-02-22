from django.db import models

from staff.models import Employee
from clients.models import Order
from projects.models import Project
class DocumentType(models.Model):
    type_name = models.CharField(max_length=50)

class Document(models.Model):
    number = models.CharField(max_length=255)
    creaеtion_date = models.DateTimeField()
    document_type = models.ForeignKey(DocumentType, on_delete=models.CASCADE)
    responsible = models.ForeignKey(Employee, on_delete=models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)



