from django.db import models

from staff.models import Employee


class Company(models.Model):
    name = models.CharField(max_length=200)
    address = models.CharField(max_length=200, null=True, blank=True)
    OGRN = models.CharField(max_length=200, null=True, blank=True)
    INN = models.CharField(max_length=200, null=True, blank=True)
    requisites = models.CharField(max_length=200, null=True, blank=True)
    phone = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Компания'
        verbose_name_plural = 'Компании'


class Client(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)

    last_name = models.CharField(max_length=200)
    first_name = models.CharField(max_length=200)
    patronymic = models.CharField(max_length=200, null=True, blank=True)
    phone = models.CharField(max_length=200, null=True, blank=True)
    email = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return self.last_name + ' ' + self.first_name

    class Meta:
        verbose_name = 'Клиент'
        verbose_name_plural = 'Клиенты'


class Order(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    manager = models.ForeignKey(Employee, on_delete=models.CASCADE)
    description = models.CharField(max_length=1000)

    def client_view(self):
        return self.client.__str__()[0]
    client_view.short_description = 'Клиент'

    def __str__(self):
        return self.description

    class Meta:
        verbose_name = 'Заказ'
        verbose_name_plural = 'Заказы'
