# Generated by Django 3.1.7 on 2021-02-23 18:33

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0003_auto_20210224_0018'),
    ]

    operations = [
        migrations.RenameField(
            model_name='task',
            old_name='prority',
            new_name='priority',
        ),
    ]
