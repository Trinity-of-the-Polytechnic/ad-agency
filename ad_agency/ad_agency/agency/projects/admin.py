from django.contrib import admin

from .models import Project


class ProjectAdmin(admin.ModelAdmin):
    list_display = ['technical_task', 'client_order', 'creative_director', 'project_manager']
    ordering = ['client_order']


admin.site.register(Project, ProjectAdmin)
