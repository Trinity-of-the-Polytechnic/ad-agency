-- Должности
INSERT INTO Staff_Post("name") VALUES
    ('Креативный директор'),
    ('Руководитель проектов'),
    ('Аккаунт-менеджер'),
    ('Дизайнер')
;


-- Приоритеты задач
INSERT INTO Tasks_Priority("priority_level", "priority_name") VALUES
    (-1, 'сделать еще вчера'),
    (0, 'максимальный'),
    (1, 'высокий'),
    (2, 'средний'),
    (3, 'низкий'),
    (4, 'минимальный')
;


-- Статусы задач
INSERT INTO Tasks_Status("name") VALUES
    ('неактивна'),
    ('активна'),
    ('приостановлена'),
    ('выполнена'),
    ('отменена')
;


-- Типы документов
INSERT INTO Documents_DocumentType("type_name") VALUES
    ('Документ'),
    ('Отчет о проделанной работе'),
    ('Договор'),
    ('Правки'),
    ('Назначение сотрудников на проект'),
    ('Снятие сотрудников с проекта')
;


-- Сотрудники
INSERT INTO Staff_Employee("last_name", "first_name", "patronymic", "post_id", "birthdate") VALUES
    ('Гусева', 'Александра', 'Олеговна', (select p."id" from Staff_Post p where "name" = 'Креативный директор'), '1997-07-04'),
    ('Адреев', 'Прохор', 'Ярославович', (select p."id" from Staff_Post p where "name" = 'Руководитель проектов'), '1976-01-20'),
    ('Беспалова', 'Любовь', 'Адреевна', (select p."id" from Staff_Post p where "name" = 'Руководитель проектов'), '1987-10-11'),
    ('Борисенко', 'Евгений', 'Аркадьевич', (select p."id" from Staff_Post p where "name" = 'Аккаунт-менеджер'), '1983-07-21'),
    ('Борисенко', 'Татьяна', 'Максимовна', (select p."id" from Staff_Post p where "name" = 'Аккаунт-менеджер'), '1990-01-05'),
    ('Васильченко', 'Анна', 'Александровна', (select p."id" from Staff_Post p where "name" = 'Дизайнер'), '1989-10-02'),
    ('Веселов', 'Лев', 'Дмитриевич', (select p."id" from Staff_Post p where "name" = 'Дизайнер'), '1987-03-03'),
    ('Гончар', 'Дарья', 'Владимировна', (select p."id" from Staff_Post p where "name" = 'Дизайнер'), '1997-05-05'),
    ('Дмитриев', 'Максим', 'Евгеньевич', (select p."id" from Staff_Post p where "name" = 'Дизайнер'), '1993-03-03'),
    ('Смолина', 'Нататлья', 'Павловна', (select p."id" from Staff_Post p where "name" = 'Дизайнер'), '1991-10-11')
;


-- Компании
select add_company('Эвалар');
select add_company('Алтай-кокс', 'Алтайский край, Заринск, ул. Притаежная, 2');
select add_company(_name => 'Алтайский лён', _inn => '2224150670');
select add_company('Деметра-Сибирь');
select add_company('Каменский рыбозавод');
select add_company('Алтайский трактор');


-- Клиенты
INSERT INTO Clients_Client("last_name", "first_name", "patronymic", "company_id", "phone") VALUES
    ('Берёзкин', 'Александр', 'Родионович', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Килина', 'Регина', 'Антиповна', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Кулигина', 'Софья', 'Артуровна', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Бальсунова', 'Анна', 'Платоновна', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Майсак', 'Ангелина', 'Несторовна', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Домаша', 'Антонина', 'Феодосьевна', (select c."id" from Clients_Company c where "name" = 'Эвалар'), '79998761221'),
    ('Толбаев', 'Герасим', 'Мартьянович', (select c."id" from Clients_Company c where "name" = 'Алтай-кокс'), '79998761221'),
    ('Овсов', 'Игнат', 'Мечиславович', (select c."id" from Clients_Company c where "name" = 'Алтай-кокс'), '79998761221'),
    ('Мутовина', 'Екатерина', 'Юрьевна', (select c."id" from Clients_Company c where "name" = 'Алтай-кокс'), '79998761221'),
    ('Трапезников', 'Даниил', 'Проклович', (select c."id" from Clients_Company c where "name" = 'Алтайский лён'), '79998761221'),
    ('Делова', 'Розалия', 'Георгиевна', (select c."id" from Clients_Company c where "name" = 'Алтайский лён'), '79998761221'),
    ('Юрков', 'Юлий', 'Валерьянович', (select c."id" from Clients_Company c where "name" = 'Деметра-Сибирь'), '79998761221'),
    ('Кутырёв', 'Кондрат', 'Вадимович', (select c."id" from Clients_Company c where "name" = 'Деметра-Сибирь'), '79998761221'),
    ('Королёв', 'Всеслав', 'Епифанович', (select c."id" from Clients_Company c where "name" = 'Деметра-Сибирь'), '79998761221'),
    ('Низовцев', 'Вадим', 'Валериевич', (select c."id" from Clients_Company c where "name" = 'Деметра-Сибирь'), '79998761221'),
    ('Пименова', 'Владислава', 'Елизаровна', (select c."id" from Clients_Company c where "name" = 'Деметра-Сибирь'), '79998761221'),
    ('Ямков', 'Порфирий', 'Натанович', (select c."id" from Clients_Company c where "name" = 'Каменский рыбозавод'), '79998761221'),
    ('Карчагин', 'Егор', 'Елисеевич', (select c."id" from Clients_Company c where "name" = 'Алтайский трактор'), '79998761221'),
    ('Сутулин', 'Самуил', 'Геннадиевич', (select c."id" from Clients_Company c where "name" = 'Алтайский трактор'), '79998761221')
;


-- Заказы
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Берёзкин' and "first_name" = 'Александр' and "patronymic" = 'Родионович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа1'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Килина' and "first_name" = 'Регина' and "patronymic" = 'Антиповна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа2'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Кулигина' and "first_name" = 'Софья' and "patronymic" = 'Артуровна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа3'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Бальсунова' and "first_name" = 'Анна' and "patronymic" = 'Платоновна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа4'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Майсак' and "first_name" = 'Ангелина' and "patronymic" = 'Несторовна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа5'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Домаша' and "first_name" = 'Антонина' and "patronymic" = 'Феодосьевна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа6'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Толбаев' and "first_name" = 'Герасим' and "patronymic" = 'Мартьянович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа7'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Овсов' and "first_name" = 'Игнат' and "patronymic" = 'Мечиславович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа8'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Мутовина' and "first_name" = 'Екатерина' and "patronymic" = 'Юрьевна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Евгений' and "patronymic" = 'Аркадьевич'),
    'Описание заказа9'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Трапезников' and "first_name" = 'Даниил' and "patronymic" = 'Проклович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа10'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Делова' and "first_name" = 'Розалия' and "patronymic" = 'Георгиевна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа11'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Юрков' and "first_name" = 'Юлий' and "patronymic" = 'Валерьянович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа12'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Кутырёв' and "first_name" = 'Кондрат' and "patronymic" = 'Вадимович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа13'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Королёв' and "first_name" = 'Всеслав' and "patronymic" = 'Епифанович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа14'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Низовцев' and "first_name" = 'Вадим' and "patronymic" = 'Валериевич'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа15'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Пименова' and "first_name" = 'Владислава' and "patronymic" = 'Елизаровна'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа16'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Ямков' and "first_name" = 'Порфирий' and "patronymic" = 'Натанович'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа17'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Карчагин' and "first_name" = 'Егор' and "patronymic" = 'Елисеевич'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа18'
);
select add_client_order(
    (select "id" from Clients_Client where "last_name" = 'Сутулин' and "first_name" = 'Самуил' and "patronymic" = 'Геннадиевич'), 
    (select "id" from Staff_Employee where "last_name" = 'Борисенко' and "first_name" = 'Татьяна' and "patronymic" = 'Максимовна'),
    'Описание заказа19'
);



-- Проекты
select add_project_by_names(
    'Описание заказа1',
    'Адреев', 'Прохор', 'Ярославович',
    'Гусева', 'Александра', 'Олеговна',
    'Техническое задание1'
);

INSERT INTO Projects_Project("client_order_id", "project_manager_id", "creative_director_id", "technical_task") VALUES
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа2'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание2'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа3'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание3'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа4'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание4'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа5'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание5'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа6'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание6'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа7'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание7'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа8'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание8'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа9'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание9'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа10'),
        (select "id" from Staff_Employee where "last_name" = 'Адреев' and "first_name" = 'Прохор' and "patronymic" = 'Ярославович'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание10'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа2'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание11'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа10'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание12'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа11'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание13'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа12'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание14'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа13'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание15'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа14'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание16'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа15'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание17'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа16'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание18'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа17'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание19'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа18'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание20'
    ),
    (
        (select "id" from Clients_Order where "description" = 'Описание заказа19'),
        (select "id" from Staff_Employee where "last_name" = 'Беспалова' and "first_name" = 'Любовь' and "patronymic" = 'Адреевна'),
        (select "id" from Staff_Employee where "last_name" = 'Гусева' and "first_name" = 'Александра' and "patronymic" = 'Олеговна'),        
        'Техническое задание21'
    )
;

select add_project_by_names(
    'Описание заказа19',
    'Беспалова', 'Любовь', 'Адреевна',
    'Гусева', 'Александра', 'Олеговна',
    'Техническое задание22'
);


-- Задачи
select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1),
        _deadline_interval => '-4 days',
        _description => 'Логотип с полумесецем 8х16 см^2',
        _priority_name => 'высокий',
        _status_name => 'активна'
    );
select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1),
        _deadline_interval => '1 month',
        _description => 'Летняя школьная фотосессия'
    );
select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1),
        _deadline_interval => '-1 day',
        _description => 'Конвергенция на тему люминисценции в одежде',
        _status_name => 'приостановлена'
    );

select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1 offset 1),
        _deadline_interval => '-1 year',
        _description => 'Оптимизировать профиль в инстаграмме для продажи песен Кая Метова',
        _priority_name => 'низкий',
        _status_name => 'отменена'
    );
select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1 offset 1),
        _deadline_interval => '-3 month',
        _description => 'Написать текст для контестной рекламы блинов группы Пикник'
    );

select add_task_by_interval (
        _id_project => (select "id" from Projects_Project limit 1 offset 2),
        _deadline_interval => '-2 day',
        _description => 'DROP SCHEMA public CASCADE;',
        _priority_name => 'сделать еще вчера',
        _status_name => 'выполнена'
    );



-- Распределение задач по сотрудникам
insert into Tasks_EmployeeTask("task_id", "employee_id")
    select t."id", e."id"
        from Tasks_Task as t, Staff_Employee as e
        where (
                e."last_name" = 'Васильченко' and e."first_name" = 'Анна' and e."patronymic" = 'Александровна'
                and (
                    t."description" = 'Логотип с полумесецем 8х16 см^2'
                    or t."description" = 'Оптимизировать профиль в инстаграмме для продажи песен Кая Метова'
                    or t."description" = 'DROP SCHEMA public CASCADE;'
                )
            )
            or (
                e."last_name" = 'Веселов' and e."first_name" = 'Лев' and e."patronymic" = 'Дмитриевич'
                and t."description" = 'Конвергенция на тему люминисценции в одежде'
            );



-- Документы и их связь с задачами
with wr as (
    select add_work_report('work "report_id" №' || p."id", p."id") as document, p."id" as "project_id"
        from Projects_Project p
        order by p."id"
        limit 5
)
insert into Tasks_ReportingTask("report_id", "task_id")
    select wr.document, t."id"
        from wr join Tasks_Task t on (wr."project_id" = t."project_id")
    returning "report_id", "task_id";


select add_contract('contract №' || o."id", ep."post_id", o."id")
    from Clients_Order o, (Staff_Employee e join Staff_Post p on(e."post_id" = p."id")) ep
    where ep."name" = 'Креативный директор'
    order by o."id"
    limit 5;

with p as (
    select p."id" as "project_id"
        from Projects_Project p
        order by p."id"
        limit 5
        offset 5
)
select add_simple_document(
        'Simple #' || p."project_id",
        (select dt."id" from Documents_DocumentType dt where dt."type_name" = 'Документ'),
        p."project_id"
    )
    from p;
