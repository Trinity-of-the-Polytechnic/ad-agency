# Generated by Django 3.1.7 on 2021-02-23 17:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('clients', '0005_auto_20210224_0011'),
    ]

    operations = [
        migrations.AlterField(
            model_name='client',
            name='email',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='client',
            name='patronymic',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='client',
            name='phone',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
