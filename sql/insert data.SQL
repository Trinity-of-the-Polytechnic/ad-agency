INSERT INTO Post(title) VALUES
    ('Креативный директор'),
    ('Руководитель проектов'),
    ('Аккаунт-менеджер'),
    ('Дизайнер')
;


INSERT INTO Priority(level, title) VALUES
    (-1, 'сделать еще вчера'),
    (0, 'максимальный'),
    (1, 'высокий'),
    (2, 'средний'),
    (3, 'низкий'),
    (4, 'минимальный')
;


INSERT INTO Status(title) VALUES
    ('Неактивна'),
    ('Активна'),
    ('Приостановлена'),
    ('Выполнена')
;


INSERT INTO Doc_Type(type_title) VALUES
    ('Документ'),
    ('Отчет о проделанной работе'),
    ('Договор'),
    ('Правки'),
    ('Назначение сотрудников на проект'),
    ('Снятие сотрудников с проекта')
;

-- Сотрудники

INSERT INTO Employee(last_name, name, patronymic, id_post, birthday) VALUES
    ('Гусева', 'Александра', 'Олеговна', (select id_post from Post where title = 'Креативный директор'), '1997-07-04'),
    ('Адреев', 'Прохор', 'Ярославович', (select id_post from Post where title = 'Руководитель проектов'), '1976-01-20'),
    ('Беспалова', 'Любовь', 'Адреевна', (select id_post from Post where title = 'Руководитель проектов'), '1987-10-11'),
    ('Борисенко', 'Евгений', 'Аркадьевич', (select id_post from Post where title = 'Аккаунт-менеджер'), '1983-07-21'),
    ('Борисенко', 'Татьяна', 'Максимовна', (select id_post from Post where title = 'Аккаунт-менеджер'), '1990-01-05'),
    ('Васильченко', 'Анна', 'Александровна', (select id_post from Post where title = 'Дизайнер'), '1989-10-02'),
    ('Веселов', 'Лев', 'Дмитриевич', (select id_post from Post where title = 'Дизайнер'), '1987-03-03'),
    ('Гончар', 'Дарья', 'Владимировна', (select id_post from Post where title = 'Дизайнер'), '1997-05-05'),
    ('Дмитриев', 'Максим', 'Евгеньевич', (select id_post from Post where title = 'Дизайнер'), '1993-03-03'),
    ('Смолина', 'Нататлья', 'Павловна', (select id_post from Post where title = 'Дизайнер'), '1991-10-11')
;