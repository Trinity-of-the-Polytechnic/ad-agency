from django.contrib import admin

from .models import Task, Status, Priority, EmployeeTask, ReportingTask


class TaskAdmin(admin.ModelAdmin):
    list_display = ['description', 'deadline', 'priority', 'project', 'status']
    ordering = ['project']


class StatusAdmin(admin.ModelAdmin):
    list_display = ['name']
    ordering = ['name']


class PriorityAdmin(admin.ModelAdmin):
    list_display = ['priority_level', 'priority_name']
    ordering = ['priority_level']


class EmployeeTaskAdmin(admin.ModelAdmin):
    list_display = ['task', 'employee']
    ordering = ['task']


class ReportingTaskAdmin(admin.ModelAdmin):
    list_display = ['task', 'report']
    ordering = ['task']


admin.site.register(Task, TaskAdmin)
admin.site.register(Status, StatusAdmin)
admin.site.register(Priority, PriorityAdmin)
admin.site.register(EmployeeTask, EmployeeTaskAdmin)
admin.site.register(ReportingTask, ReportingTaskAdmin)
