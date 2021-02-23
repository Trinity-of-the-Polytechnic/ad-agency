from django.db import models

from projects.models import Project
from staff.models import Employee
from documents.models import Document

class Priority(models.Model):
    priority_level = models.IntegerField()
    priority_name = models.CharField(max_length=20)

class Status(models.Model):
    name = models.CharField(max_length=20)

class Task(models.Model):
    description = models.CharField(max_length=1000)
    deadline = models.DateField(null=True, blank=True)
    prority = models.ForeignKey(Priority, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    status = models.ForeignKey(Status, on_delete=models.CASCADE)

class EmployeeTask(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE)
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE)

class ReportingTask(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE)
    report = models.ForeignKey(Document, on_delete=models.CASCADE)
