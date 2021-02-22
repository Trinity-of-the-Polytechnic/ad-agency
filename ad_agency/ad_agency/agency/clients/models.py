from django.db import models

from staff.models import Employee

class Company(models.Model):
    name = models.CharField(max_length=200)
    address = models.CharField(max_length=200)
    OGRN = models.CharField(max_length=200)
    INN = models.CharField(max_length=200)
    requisites = models.CharField(max_length=200)
    phone = models.CharField(max_length=200)

class Client(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)

    last_name = models.CharField(max_length=200)
    first_name = models.CharField(max_length=200)
    patronymic = models.CharField(max_length=200)
    phone = models.CharField(max_length=200)
    email = models.CharField(max_length=200)

    def __str__(self):
        return str(self.last_name) + ' ' + str(self.first_name)

class Order(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    manager = models.ForeignKey(Employee, on_delete=models.CASCADE)
    description = models.CharField(max_length=1000)
