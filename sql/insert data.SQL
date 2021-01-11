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

-- Компании

INSERT INTO Company(title_company) VALUES
    ('Эвалар'),
    ('Алтай-кокс'),
    ('Алтайский лён'),
    ('Деметра-Сибирь'),
    ('Каменский рыбозавод'),
    ('Алтайский трактор')
;

--Клиенты

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
        (select id_client from Client where client.last_name = 'Берёзкин' and client.name = 'Александр' and client.patronymic = 'Родионович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа1'
    ),
    (
        (select id_client from Client where client.last_name = 'Килина' and client.name = 'Регина' and client.patronymic = 'Антиповна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа2'
    ),
    (
        (select id_client from Client where client.last_name = 'Кулигина' and client.name = 'Софья' and client.patronymic = 'Артуровна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа3'
    ),
    (
        (select id_client from Client where client.last_name = 'Бальсунова' and client.name = 'Анна' and client.patronymic = 'Платоновна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа4'
    ),
    (
        (select id_client from Client where client.last_name = 'Майсак' and client.name = 'Ангелина' and client.patronymic = 'Несторовна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа5'
    ),
    (
        (select id_client from Client where client.last_name = 'Домаша' and client.name = 'Антонина' and client.patronymic = 'Феодосьевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа6'
    ),
    (
        (select id_client from Client where client.last_name = 'Толбаев' and client.name = 'Герасим' and client.patronymic = 'Мартьянович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа7'
    ),
    (
        (select id_client from Client where client.last_name = 'Овсов' and client.name = 'Игнат' and client.patronymic = 'Мечиславович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа8'
    ),
    (
        (select id_client from Client where client.last_name = 'Мутовина' and client.name = 'Екатерина' and client.patronymic = 'Юрьевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Евгений' and patronymic = 'Аркадьевич'),
        'Описание заказа9'
    ),
    (
        (select id_client from Client where client.last_name = 'Трапезников' and client.name = 'Даниил' and client.patronymic = 'Проклович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа10'
    ),
    (
        (select id_client from Client where client.last_name = 'Делова' and client.name = 'Розалия' and client.patronymic = 'Георгиевна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа11'
    ),
    (
        (select id_client from Client where client.last_name = 'Юрков' and client.name = 'Юлий' and client.patronymic = 'Валерьянович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа12'
    ),
    (
        (select id_client from Client where client.last_name = 'Кутырёв' and client.name = 'Кондрат' and client.patronymic = 'Вадимович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа13'
    ),
    (
        (select id_client from Client where client.last_name = 'Королёв' and client.name = 'Всеслав' and client.patronymic = 'Епифанович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа14'
    ),
    (
        (select id_client from Client where client.last_name = 'Низовцев' and client.name = 'Вадим' and client.patronymic = 'Валериевич'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа15'
    ),
    (
        (select id_client from Client where client.last_name = 'Пименова' and client.name = 'Владислава' and client.patronymic = 'Елизаровна'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа16'
    ),
    (
        (select id_client from Client where client.last_name = 'Ямков' and client.name = 'Порфирий' and client.patronymic = 'Натанович'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа17'
    ),
    (
        (select id_client from Client where client.last_name = 'Карчагин' and client.name = 'Егор' and client.patronymic = 'Елисеевич'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа18'
    ),
    (
        (select id_client from Client where client.last_name = 'Сутулин' and client.name = 'Самуил' and client.patronymic = 'Геннадиевич'), 
        (select id_employee from Employee where last_name = 'Борисенко' and name = 'Татьяна' and patronymic = 'Максимовна'),
        'Описание заказа19'
    )
;

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
