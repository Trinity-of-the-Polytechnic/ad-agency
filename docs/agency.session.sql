-- Должности
INSERT INTO staff_post(name) VALUES
    ('Креативный директор'),
    ('Руководитель проектов'),
    ('Аккаунт-менеджер'),
    ('Дизайнер')
;


-- Приоритеты задач
INSERT INTO tasks_priority(priority_level, priority_name) VALUES
    (-1, 'сделать еще вчера'),
    (0, 'максимальный'),
    (1, 'высокий'),
    (2, 'средний'),
    (3, 'низкий'),
    (4, 'минимальный')
;