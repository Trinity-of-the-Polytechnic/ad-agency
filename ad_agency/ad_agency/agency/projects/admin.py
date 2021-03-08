from django.contrib import admin

from .models import Project

from helper.utils import russify_columns


class ProjectAdmin(admin.ModelAdmin):
    ordering = ['client_order']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['technical_task', 'Техническое задание'], ['client_order', 'Заказ'],
                      ['creative_director', 'Креативный директор'], ['project_manager', 'Менеджер проекта']]
        russify_columns(self, to_russian)


admin.site.register(Project, ProjectAdmin)
