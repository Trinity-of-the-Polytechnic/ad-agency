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
