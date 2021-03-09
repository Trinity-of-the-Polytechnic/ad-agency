from django.contrib import admin
from django.conf.urls import url
from django.http import HttpResponseRedirect
from django.db.models import Q
from django.contrib.auth.models import User
from django.contrib.auth.models import Group

from transliterate import translit

from .models import Employee, Post
from helper.utils import translit, russify_columns


class EmployeeAdmin(admin.ModelAdmin):
    ordering = ['last_name']
    actions = ['migrate_employees_to_users']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['last_name', 'Фамилия'], ['first_name', 'Имя'], ['patronymic', 'Отчество'],
                      ['birthdate', 'Дата рождения'], ['post', 'Должность']]
        russify_columns(self, to_russian)

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
    ordering = ['name']
    change_list_template = "admin/check_change_list.html"
    view_mode = '0'
    accessible_groups = ['Аккаунт-менеджер', 'Дизайнер', 'Креативный директор', 'Руководитель проектов']

    def get_queryset(self, request):
        if self.view_mode == '0':
            return super().get_queryset(request)
        elif self.view_mode == '1':
            return super().get_queryset(request).filter(name__in=self.accessible_groups)
        elif self.view_mode == '2':
            return super().get_queryset(request).filter(~Q(name__in=self.accessible_groups))

    def get_urls(self):
        urls = super(PostAdmin, self).get_urls()
        custom_urls = [url('^check/$', self.check_verification, name='check_verification')]
        return custom_urls + urls

    def check_verification(self, request):
        self.view_mode = str(request)[-3]
        return HttpResponseRedirect("../")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # short descriptions
        to_russian = [['name', 'Наименование должности']]
        russify_columns(self, to_russian)


admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Post, PostAdmin)
