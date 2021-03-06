from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.models import Group

from transliterate import translit

from .models import Employee, Post


class EmployeeAdmin(admin.ModelAdmin):
    list_display = ['last_name', 'first_name', 'patronymic', 'birthdate', 'post']
    ordering = ['last_name']
    actions = ['migrate_employees_to_users']

    def delete_queryset(self, request, queryset):
        for obj in queryset:
            nick_name = translit(obj.first_name + '_' + obj.last_name, reversed=True) + '_' + str(obj.id)
            nick_name = nick_name.replace('\'', '')
            user = User.objects.get(username=nick_name)
            user.delete()

    def migrate_employees_to_users(self, request, queryset):
        for obj in queryset:
            nick_name = translit(obj.first_name + '_' + obj.last_name, reversed=True) + '_' + str(obj.id)
            nick_name = nick_name.replace('\'', '')

            if not User.objects.filter(username=nick_name).exists():
                if obj.post.name == 'Аккаунт-менеджер':
                    User.objects.create_user(username=nick_name, password='qwerty', is_staff=True)
                    Group.objects.get(name='Account Manager').user_set.add(User.objects.get(username=nick_name))
                elif obj.post.name == 'Дизайнер':
                    User.objects.create_user(username=nick_name, password='qwerty', is_staff=True)
                    Group.objects.get(name='Designer').user_set.add(User.objects.get(username=nick_name))
                elif obj.post.name == 'Креативный директор':
                    User.objects.create_user(username=nick_name, password='qwerty', is_staff=True)
                    Group.objects.get(name='Creative Director').user_set.add(User.objects.get(username=nick_name))
                elif obj.post.name == 'Руководитель проектов':
                    User.objects.create_user(username=nick_name, password='qwerty', is_staff=True)
                    Group.objects.get(name='Project Manager').user_set.add(User.objects.get(username=nick_name))
                else:
                    raise Exception('Unregistered post in the system. contact your administrator')

    migrate_employees_to_users.short_description = 'Зарегистироравать сотрудников как пользователей'


class PostAdmin(admin.ModelAdmin):
    list_display = ['name']
    ordering = ['name']


admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Post, PostAdmin)
