from django.db import models

class Post(models.Model):
    name = models.CharField(max_length=200)

class Employee(models.Model):
    last_name = models.CharField(max_length=200)
    first_name = models.CharField(max_length=200)
    patronymic = models.CharField(max_length=200)
    birthdate = models.DateField()
    post = models.ForeignKey(Post, on_delete=models.CASCADE)

