from django.db import models

from projects.models import Project
from staff.models import Employee
from documents.models import Document


class Priority(models.Model):
    priority_level = models.IntegerField()
    priority_name = models.CharField(max_length=20)

    def __str__(self):
        return self.priority_name

    class Meta:
        verbose_name = 'Приоритет'
        verbose_name_plural = 'Приоритеты'


class Status(models.Model):
    name = models.CharField(max_length=20)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Статус'
        verbose_name_plural = 'Статусы'


class Task(models.Model):
    description = models.CharField(max_length=1000)
    deadline = models.DateField(null=True, blank=True)
    priority = models.ForeignKey(Priority, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    status = models.ForeignKey(Status, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.project)

    class Meta:
        verbose_name = 'Задача'
        verbose_name_plural = 'Задачи'


class EmployeeTask(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE)
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.task) + ' ' + str(self.employee)

    class Meta:
        verbose_name = 'Сотрудник'
        verbose_name_plural = 'Сотрудники'


class ReportingTask(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE)
    report = models.ForeignKey(Document, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.task) + ' ' + str(self.report)

    class Meta:
        verbose_name = 'Отчет по задаче'
        verbose_name_plural = 'Отчеты по задачам'
