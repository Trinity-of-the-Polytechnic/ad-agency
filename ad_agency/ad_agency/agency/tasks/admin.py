from django.contrib import admin

from .models import Task, Status, Priority, EmployeeTask, ReportingTask
from projects.models import Project
from staff.models import Employee
from documents.models import Document, DocumentType

from helper.utils import extract_employee_id, russify_columns


class TaskAdmin(admin.ModelAdmin):
    ordering = ['project']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                project__in=Project.objects.filter(project_manager=Employee.objects.get(id=int(user_id))))
        elif request.user.groups.filter(name='Designer').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(id__in=[obj.task.id for obj in EmployeeTask.objects.filter(
                employee=Employee.objects.get(id=user_id))])
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['project'].queryset = Project.objects.filter(
                project_manager=Employee.objects.get(id=int(user_id)))
        elif request.user.groups.filter(name='Designer').exists():
            form.base_fields['description'].disabled = True
            form.base_fields['deadline'].disabled = True
            form.base_fields['priority'].disabled = True
            form.base_fields['project'].disabled = True
        return form

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

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                task__in=Task.objects.filter(project__in=Project.objects.filter(project_manager=
                                                                                Employee.objects.get(id=int(user_id)))))
        elif request.user.groups.filter(name='Designer').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(employee=Employee.objects.get(id=int(user_id)))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['task'].queryset = Task.objects.filter(project__in=Project.objects.filter(project_manager=Employee.objects.
                                                                                                       get(id=int(
                                                                                                           user_id))))
        return form

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['task', 'Задача'], ['employee', 'Сотрудник']]
        russify_columns(self, to_russian)


class ReportingTaskAdmin(admin.ModelAdmin):
    ordering = ['task']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                task__in=Task.objects.filter(project__in=Project.objects.filter(project_manager=Employee.objects.get(id=int(user_id)))))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['task'].queryset = Task.objects.filter(project__in=Project.objects.filter(project_manager=Employee.objects.
                                                                                                       get(id=int(
                                                                                                           user_id))))
            form.base_fields['report'].queryset = Document.objects.filter(document_type=DocumentType.objects.get(
                type_name='Отчет о проделанной работе')).filter(responsible=Employee.objects.get(id=int(user_id)))
        return form

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
