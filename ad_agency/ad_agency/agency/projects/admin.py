from django.contrib import admin

from helper.utils import extract_employee_id

from .models import Project
from staff.models import Employee, Post


class ProjectAdmin(admin.ModelAdmin):
    list_display = ['technical_task', 'client_order', 'creative_director', 'project_manager']
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


admin.site.register(Project, ProjectAdmin)
