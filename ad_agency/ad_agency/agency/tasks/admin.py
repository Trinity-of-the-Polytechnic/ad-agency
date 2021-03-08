from django.contrib import admin

from helper.utils import extract_employee_id

from .models import Task, Status, Priority, EmployeeTask, ReportingTask
from projects.models import Project
from staff.models import Employee
from documents.models import Document, DocumentType


class TaskAdmin(admin.ModelAdmin):
    list_display = ['description', 'deadline', 'priority', 'project', 'status']
    ordering = ['project']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                project__in=Project.objects.filter(project_manager=Employee.objects.get(id=int(user_id))))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['project'].queryset = Project.objects.filter(
                project_manager=Employee.objects.get(id=int(user_id)))
        return form


class StatusAdmin(admin.ModelAdmin):
    list_display = ['name']
    ordering = ['name']


class PriorityAdmin(admin.ModelAdmin):
    list_display = ['priority_level', 'priority_name']
    ordering = ['priority_level']


class EmployeeTaskAdmin(admin.ModelAdmin):
    list_display = ['task', 'employee']
    ordering = ['task']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                task__in=Task.objects.filter(project__in=
                                             Project.objects.filter(project_manager=Employee.objects.get(id=int(user_id)))))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['task'].queryset = Task.objects.filter(project__in=Project.objects.filter(project_manager=
                                                                                                       Employee.objects.
                                                                                                       get(id=int(
                                                                                                           user_id))))
        return form


class ReportingTaskAdmin(admin.ModelAdmin):
    list_display = ['task', 'report']
    ordering = ['task']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(
                task__in=Task.objects.filter(project__in=Project.objects.filter(project_manager=
                                                                                Employee.objects.get(id=int(user_id)))))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['task'].queryset = Task.objects.filter(project__in=Project.objects.filter(project_manager=
                                                                                                       Employee.objects.
                                                                                                       get(id=int(
                                                                                                           user_id))))
            form.base_fields['report'].queryset = Document.objects.filter(document_type=DocumentType.objects.get(
                type_name='Отчет о проделанной работе')).filter(responsible=Employee.objects.get(id=int(user_id)))
        return form


admin.site.register(Task, TaskAdmin)
admin.site.register(Status, StatusAdmin)
admin.site.register(Priority, PriorityAdmin)
admin.site.register(EmployeeTask, EmployeeTaskAdmin)
admin.site.register(ReportingTask, ReportingTaskAdmin)
