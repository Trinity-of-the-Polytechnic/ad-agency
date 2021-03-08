from django.contrib import admin

from .models import Task, Status, Priority, EmployeeTask, ReportingTask

from helper.utils import extract_employee_id, russify_columns


class TaskAdmin(admin.ModelAdmin):
    ordering = ['project']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['description', 'Описание'], ['deadline', 'Сроки'], ['priority', 'Приоритет'],
                      ['project', 'Проект'], ['status', 'Статус']]
        russify_columns(self, to_russian)


class StatusAdmin(admin.ModelAdmin):
    ordering = ['name']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['name', 'Наименование']]
        russify_columns(self, to_russian)


class PriorityAdmin(admin.ModelAdmin):
    ordering = ['priority_level']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['priority_level', 'Уровень приоритета'], ['priority_name', 'Наименование приоритета']]
        russify_columns(self, to_russian)


class EmployeeTaskAdmin(admin.ModelAdmin):
    ordering = ['task']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['task', 'Задача'], ['employee', 'Сотрудник']]
        russify_columns(self, to_russian)


class ReportingTaskAdmin(admin.ModelAdmin):
    ordering = ['task']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['task', 'Задача'], ['report', 'Отчет']]
        russify_columns(self, to_russian)


admin.site.register(Task, TaskAdmin)
admin.site.register(Status, StatusAdmin)
admin.site.register(Priority, PriorityAdmin)
admin.site.register(EmployeeTask, EmployeeTaskAdmin)
admin.site.register(ReportingTask, ReportingTaskAdmin)
