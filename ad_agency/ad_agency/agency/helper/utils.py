import re
import transliterate as t


def translit(string):
    translated = t.translit(string, language_code='ru', reversed=True)
    return translated.replace('\'', '')


def extract_employee_id(username):
    id_extractor = re.search(r'\d+$', username)
    if id_extractor is None:
        return None
    return id_extractor.group(0)


if __name__ == '__main__':
    first_name = 'Олег'
    last_name = 'Qarpek'
    id = 7

    fullname = f'{first_name}_{last_name}_{id}'
    transleted = translit(fullname)
    number = extract_employee_id(transleted)

    print(number)


def russify_columns(target, to_russian):
    def view_generator(key, value):
        MAX_FIELD_LEN = 30

        def column_view(obj):
            field_value = str(getattr(obj, key))
            if(len(field_value) > MAX_FIELD_LEN):
                field_value = field_value[:MAX_FIELD_LEN] + '...'
            return field_value

        column_view.short_description = value
        return column_view

    for [key, value] in to_russian:
        setattr(target, f'{key}_view', view_generator(key, value))

    target.list_display = [*map(lambda item: f'{item[0]}_view', to_russian)]
