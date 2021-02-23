from django.db import models

from staff.models import Employee

class Company(models.Model):
    name = models.CharField(max_length=200)
    address = models.CharField(max_length=200, null=True, blank=True)
    OGRN = models.CharField(max_length=200, null=True, blank=True)
    INN = models.CharField(max_length=200, null=True, blank=True)
    requisites = models.CharField(max_length=200, null=True, blank=True)
    phone = models.CharField(max_length=200, null=True, blank=True)

class Client(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)

    last_name = models.CharField(max_length=200)
    first_name = models.CharField(max_length=200)
    patronymic = models.CharField(max_length=200, null=True, blank=True)
    phone = models.CharField(max_length=200, null=True, blank=True)
    email = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return str(self.last_name) + ' ' + str(self.first_name)

class Order(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    manager = models.ForeignKey(Employee, on_delete=models.CASCADE)
    description = models.CharField(max_length=1000)
