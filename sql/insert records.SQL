-- Должности
INSERT INTO Post(title) VALUES
    ('Креативный директор'),
    ('Руководитель проектов'),
    ('Аккаунт-менеджер'),
    ('Дизайнер')
;


-- Приоритеты задач
INSERT INTO Priority(level, title) VALUES
    (-1, 'сделать еще вчера'),
    (0, 'максимальный'),
    (1, 'высокий'),
    (2, 'средний'),
    (3, 'низкий'),
    (4, 'минимальный')
;


-- Статусы задач
INSERT INTO Status(title) VALUES
    ('неактивна'),
    ('активна'),
    ('приостановлена'),
    ('выполнена'),
    ('отменена')
;


-- Типы документов
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


-- Компании
INSERT INTO Company(title_company) VALUES
    ('Эвалар'),
    ('Алтай-кокс'),
    ('Алтайский лён'),
    ('Деметра-Сибирь'),
    ('Каменский рыбозавод'),
    ('Алтайский трактор')
;


-- Клиенты
INSERT INTO Client(last_name, name, patronymic, id_company, phone) VALUES
    ('Берёзкин', 'Александр', 'Родионович', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Килина', 'Регина', 'Антиповна', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Кулигина', 'Софья', 'Артуровна', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Бальсунова', 'Анна', 'Платоновна', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Майсак', 'Ангелина', 'Несторовна', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Домаша', 'Антонина', 'Феодосьевна', (select id_company from Company where title_company = 'Эвалар'), '79998761221'),
    ('Толбаев', 'Герасим', 'Мартьянович', (select id_company from Company where title_company = 'Алтай-кокс'), '79998761221'),
    ('Овсов', 'Игнат', 'Мечиславович', (select id_company from Company where title_company = 'Алтай-кокс'), '79998761221'),
    ('Мутовина', 'Екатерина', 'Юрьевна', (select id_company from Company where title_company = 'Алтай-кокс'), '79998761221'),
    ('Трапезников', 'Даниил', 'Проклович', (select id_company from Company where title_company = 'Алтайский лён'), '79998761221'),
    ('Делова', 'Розалия', 'Георгиевна', (select id_company from Company where title_company = 'Алтайский лён'), '79998761221'),
    ('Юрков', 'Юлий', 'Валерьянович', (select id_company from Company where title_company = 'Деметра-Сибирь'), '79998761221'),
    ('Кутырёв', 'Кондрат', 'Вадимович', (select id_company from Company where title_company = 'Деметра-Сибирь'), '79998761221'),
    ('Королёв', 'Всеслав', 'Епифанович', (select id_company from Company where title_company = 'Деметра-Сибирь'), '79998761221'),
    ('Низовцев', 'Вадим', 'Валериевич', (select id_company from Company where title_company = 'Деметра-Сибирь'), '79998761221'),
    ('Пименова', 'Владислава', 'Елизаровна', (select id_company from Company where title_company = 'Деметра-Сибирь'), '79998761221'),
    ('Ямков', 'Порфирий', 'Натанович', (select id_company from Company where title_company = 'Каменский рыбозавод'), '79998761221'),
    ('Карчагин', 'Егор', 'Елисеевич', (select id_company from Company where title_company = 'Алтайский трактор'), '79998761221'),
    ('Сутулин', 'Самуил', 'Геннадиевич', (select id_company from Company where title_company = 'Алтайский трактор'), '79998761221')
;


-- Заказы
INSERT INTO Customer_Order(id_client, id_account_manager, project_description) VALUES
    (
        (select id_client from Client where last_name = 'Берёзкин' and name = 'Александр' and patronymic = 'Родионович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа1'
    ),
    (
        (select id_client from Client where last_name = 'Килина' and name = 'Регина' and patronymic = 'Антиповна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа2'
    ),
    (
        (select id_client from Client where last_name = 'Кулигина' and name = 'Софья' and patronymic = 'Артуровна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа3'
    ),
    (
        (select id_client from Client where last_name = 'Бальсунова' and name = 'Анна' and patronymic = 'Платоновна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа4'
    ),
    (
        (select id_client from Client where last_name = 'Майсак' and name = 'Ангелина' and patronymic = 'Несторовна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа5'
    ),
    (
        (select id_client from Client where last_name = 'Домаша' and name = 'Антонина' and patronymic = 'Феодосьевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа6'
    ),
    (
        (select id_client from Client where last_name = 'Толбаев' and name = 'Герасим' and patronymic = 'Мартьянович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа7'
    ),
    (
        (select id_client from Client where last_name = 'Овсов' and name = 'Игнат' and patronymic = 'Мечиславович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа8'
    ),
    (
        (select id_client from Client where last_name = 'Мутовина' and name = 'Екатерина' and patronymic = 'Юрьевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа9'
    ),
    (
        (select id_client from Client where last_name = 'Трапезников' and name = 'Даниил' and patronymic = 'Проклович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа10'
    ),
    (
        (select id_client from Client where last_name = 'Делова' and name = 'Розалия' and patronymic = 'Георгиевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа11'
    ),
    (
        (select id_client from Client where last_name = 'Юрков' and name = 'Юлий' and patronymic = 'Валерьянович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа12'
    ),
    (
        (select id_client from Client where last_name = 'Кутырёв' and name = 'Кондрат' and patronymic = 'Вадимович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа13'
    ),
    (
        (select id_client from Client where last_name = 'Королёв' and name = 'Всеслав' and patronymic = 'Епифанович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа14'
    ),
    (
        (select id_client from Client where last_name = 'Низовцев' and name = 'Вадим' and patronymic = 'Валериевич'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа15'
    ),
    (
        (select id_client from Client where last_name = 'Пименова' and name = 'Владислава' and patronymic = 'Елизаровна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа16'
    )
;

select add_customer_order(
    (select id_client from Client where last_name = 'Ямков' and name = 'Порфирий' and patronymic = 'Натанович'), 
    (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
    'Описание заказа17'
);
select add_customer_order(
    (select id_client from Client where last_name = 'Карчагин' and name = 'Егор' and patronymic = 'Елисеевич'), 
    (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
    'Описание заказа18'
);
select add_customer_order(
    (select id_client from Client where last_name = 'Сутулин' and name = 'Самуил' and patronymic = 'Геннадиевич'), 
    (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
    'Описание заказа19'
);



-- Проекты
INSERT INTO Project(id_order, id_project_manager, id_creative_director, technical_specification) VALUES
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа1'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание1'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа2'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание2'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа3'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание3'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа4'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание4'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа5'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание5'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа6'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание6'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа7'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание7'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа8'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание8'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа9'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание9'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа10'),
        (select id_employee from Employee where last_name = 'Адреев' and name = 'Прохор' and patronymic = 'Ярославович'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание10'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа2'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание11'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа10'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание12'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа11'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание13'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа12'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание14'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа13'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание15'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа14'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание16'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа15'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание17'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа16'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание18'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа17'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание19'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа18'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание20'
    ),
    (
        (select id_order from Customer_Order where project_description = 'Описание заказа19'),
        (select id_employee from Employee where last_name = 'Беспалова' and name = 'Любовь' and patronymic = 'Адреевна'),
        (select id_employee from Employee where last_name = 'Гусева' and name = 'Александра' and patronymic = 'Олеговна'),        
        'Техническое задание21'
    )
;

select add_project_by_names('Описание заказа19',
                            'Беспалова', 'Любовь', 'Адреевна',
                            'Гусева', 'Александра', 'Олеговна',
                            'Техническое задание22')
;



-- Задачи
select add_task_by_interval (
        _id_project => (select id_project from Project limit 1),
        _deadline_interval => '-4 days',
        _description => 'Логотип с полумесецем 8х16 см^2',
        _priority_title => 'высокий',
        _status_title => 'активна'
    ),
    add_task_by_interval (
        _id_project => (select id_project from Project limit 1),
        _deadline_interval => '1 month',
        _description => 'Летняя школьная фотосессия'
    ),
    add_task_by_interval (
        _id_project => (select id_project from Project limit 1),
        _deadline_interval => '-1 day',
        _description => 'Конвергенция на тему люминисценции в одежде',
        _status_title => 'приостановлена'
    ),

    add_task_by_interval (
        _id_project => (select id_project from Project limit 1 offset 1),
        _deadline_interval => '-1 year',
        _description => 'Оптимизировать профиль в инстаграмме для продажи песен Кая Метова',
        _priority_title => 'низкий',
        _status_title => 'отменена'
    ),
    add_task_by_interval (
        _id_project => (select id_project from Project limit 1 offset 1),
        _deadline_interval => '-3 month',
        _description => 'Написать текст для контестной рекламы блинов группы Пикник'
    ),

    add_task_by_interval (
        _id_project => (select id_project from Project limit 1 offset 2),
        _deadline_interval => '-2 day',
        _description => 'DROP SCHEMA public CASCADE;',
        _priority_title => 'сделать еще вчера',
        _status_title => 'выполнена'
    );



-- Распределение задач по сотрудникам
insert into Task_Employee(id_task, id_employee)
    select t.id_task, e.id_employee
        from Task as t, Employee as e
        where (
                e.last_name = 'Васильченко' and e.name = 'Анна' and e.patronymic = 'Александровна'
                and (
                    t.description = 'Логотип с полумесецем 8х16 см^2'
                    or t.description = 'Оптимизировать профиль в инстаграмме для продажи песен Кая Метова'
                    or t.description = 'DROP SCHEMA public CASCADE;'
                )
            )
            or (
                e.last_name = 'Веселов' and e.name = 'Лев' and e.patronymic = 'Дмитриевич'
                and t.description = 'Конвергенция на тему люминисценции в одежде'
            );



-- Документы и их связь с задачами
with wr as (
    select add_work_report('work report №' || id_project, id_project) as id_document, id_project
        from Project
        order by id_project
        limit 5
)
insert into Task_Document(id_document, id_task)
    select id_document, id_task
        from wr join Task using (id_project);

select add_contract('contract №' || co.id_order, e.id_employee, co.id_order)
    from Customer_Order co, (Employee join Post using(id_post)) e
    where e.title = 'Креативный директор'
    order by co.id_order
    limit 5;

with p as (
    select id_project
        from Project
        order by id_project
        limit 5
        offset 5
)
select add_simple_document(
        'Simple #' || id_project,
        (select id_doc_type from Doc_Type where type_title = 'Документ'),
        id_project
    )
    from p;
