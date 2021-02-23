from django.contrib import admin

from .models import Employee, Post


class EmployeeAdmin(admin.ModelAdmin):
    list_display = ['last_name', 'first_name', 'patronymic', 'birthdate', 'post']
    ordering = ['last_name']


class PostAdmin(admin.ModelAdmin):
    list_display = ['name']
    ordering = ['name']


admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Post, PostAdmin)
