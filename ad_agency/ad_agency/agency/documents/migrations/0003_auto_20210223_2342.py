# Generated by Django 3.1.7 on 2021-02-23 16:42

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0002_auto_20210222_1916'),
        ('documents', '0002_document_project'),
    ]

    operations = [
        migrations.AlterField(
            model_name='document',
            name='project',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='projects.project'),
        ),
    ]
