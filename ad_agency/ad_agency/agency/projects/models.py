from django.db import models

from clients.models import Order
from staff.models import Employee

class Project(models.Model):
    technical_task = models.CharField(max_length=10000, null=True, blank=True)
    client_order = models.ForeignKey(Order, on_delete=models.CASCADE)
    creative_director = models.ForeignKey(Employee, on_delete=models.CASCADE, related_name="creative_director")
    project_manager = models.ForeignKey(Employee, on_delete=models.CASCADE, related_name="project_manager")

    def __str__(self):
        return str(self.client_order)

