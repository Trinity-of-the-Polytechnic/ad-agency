from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.models import Group

from transliterate import translit

from .models import Employee, Post
from helper.utils import translit

class EmployeeAdmin(admin.ModelAdmin):
    list_display = ['last_name', 'first_name', 'patronymic', 'birthdate', 'post']
    ordering = ['last_name']
    actions = ['migrate_employees_to_users']

    def delete_model(self, request, obj):
        self.delete_related_user(request, obj)
        obj.delete()

    def delete_queryset(self, request, queryset):
        for obj in queryset:
            self.delete_related_user(request, obj)
            obj.delete()

    def delete_related_user(self, request, obj):
        nick_name = translit(f'{obj.first_name}_{obj.last_name}_{str(obj.id)}')
        try:
            user = User.objects.get(username=nick_name)
            user.delete()
        except User.DoesNotExist:
            return

    def migrate_employees_to_users(self, request, queryset):
        for obj in queryset:
            nick_name = translit(f'{obj.first_name}_{obj.last_name}_{str(obj.id)}')

            if not User.objects.filter(username=nick_name).exists():
                group = None
                if obj.post.name == 'Аккаунт-менеджер':
                    group = 'Account Manager'
                elif obj.post.name == 'Дизайнер':
                    group = 'Designer'
                elif obj.post.name == 'Креативный директор':
                    group = 'Creative Director'
                elif obj.post.name == 'Руководитель проектов':
                    group = 'Project Manager'
                else:
                    raise Exception('Unregistered post in the system. contact your administrator')
                User.objects.create_user(username=nick_name, password='qwerty', is_staff=True,
                                         first_name=obj.first_name, last_name=obj.last_name)
                Group.objects.get(name=group).user_set.add(User.objects.get(username=nick_name))

    migrate_employees_to_users.short_description = 'Зарегистироравать сотрудников как пользователей'


class PostAdmin(admin.ModelAdmin):
    list_display = ['name']
    ordering = ['name']


admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Post, PostAdmin)
