from django.contrib import admin

from .models import Project
from staff.models import Employee, Post

from helper.utils import extract_employee_id, russify_columns


class ProjectAdmin(admin.ModelAdmin):
    ordering = ['client_order']

    def get_queryset(self, request):
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            return super().get_queryset(request).filter(project_manager=Employee.objects.get(id=int(user_id)))
        else:
            return super().get_queryset(request)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if request.user.groups.filter(name='Project Manager').exists():
            user_id = extract_employee_id(request.user.username)
            form.base_fields['project_manager'].initial = Employee.objects.get(id=int(user_id))
            form.base_fields['project_manager'].disabled = True
            form.base_fields['creative_director'].queryset = Employee.objects.filter(
                post=Post.objects.get(name='Креативный директор'))
        return form

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['technical_task', 'Техническое задание'], ['client_order', 'Заказ'],
                      ['creative_director', 'Креативный директор'], ['project_manager', 'Менеджер проекта']]
        russify_columns(self, to_russian)


admin.site.register(Project, ProjectAdmin)
