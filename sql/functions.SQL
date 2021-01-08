-- TODO:
-- +- разные функции для создания разных типов документов
-- + триггер для установки даты созданного документа
-- функция создания задачи с приоритетом, заданным числом
-- функцция для Task: принимает "срок выполнения", а в таблицу записывет дату дедлайна
-- функция, которая добавляет заказ и может генерировать его описание (кем добавлен, дата, заказчик)


CREATE OR REPLACE FUNCTION add_company (
    _title_company Company.title_company%type,
    _address Company.address%type DEFAULT NULL,
    _ogrn Company.ogrn%type DEFAULT NULL,
    _inn Company.inn%type DEFAULT NULL,
    _bank_details Company.bank_details%type DEFAULT NULL,
    _telephone Company.telephone%type DEFAULT NULL
)
RETURNS Company.id_company%type AS $$
DECLARE
    id_new_company Company.id_company%type;
BEGIN
    INSERT INTO
        company(title_company, address, ogrn, inn, bank_details, telephone)
    VALUES
        (_title_company, _address, _ogrn, _inn, _bank_details, _telephone)
    RETURNING
        id_company INTO id_new_company;
    
    RETURN id_new_company;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_client (
    _last_name Client.last_name%type,
    _name Client.name%type,
    _id_company Client.id_company%type,
    _patronymic Client.patronymic%type default NULL,
    _phone Client.phone%type default NULL,
    _email Client.email%type default NULL
)
RETURNS Client.id_client%type AS $$
DECLARE
    id_new_client Client.id_client%type;
BEGIN
    INSERT INTO
        client(last_name, name, id_company, patronymic, phone, email)
    VALUES
        (_last_name, _name, _id_company, _patronymic, _phone, _email)
    RETURNING
        id_client INTO id_new_client;
    
    RETURN id_new_company;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION add_work_report (
    _number Document.number%type,
    _id_project_manager Document.id_employee%type
)
RETURNS Document.id_document%type AS $$
DECLARE
    doc_type_title constant Doc_Type.type_title%type := 'Отчет о проделанной работе';
    employee_post constant Post.title%type := 'Руководитель проектов';

    id_cur_doc_type Document.id_doc_type%type := (
        SELECT id_doc_type
        FROM Doc_Type
        WHERE type_title = doc_type_title
    );
    id_cur_project Document.id_project%type := (
        SELECT id_project
        FROM Project
        WHERE id_project_manager = _id_project_manager
    );
    id_cur_order Document.id_order%type := (
        SELECT id_order
        FROM Project
        WHERE id_project = id_cur_project
    );
    
    id_new_report Document.id_document%type;
BEGIN
    ASSERT id_cur_doc_type is not NULL, 'Doc type does not exist: ' || doc_type_title;

    if employee_post IS DISTINCT FROM (
        select Post.title
        from Post join Employee on Post.id_post = Employee.id_post
        where Employee.id_employee = _id_project_manager
    ) then
        raise 'post must be equal "%"', employee_post;
    end if;

    INSERT INTO
        Document(number, id_doc_type, id_project, id_order, id_employee)
    VALUES
        (_number, id_cur_doc_type, id_cur_project, id_cur_order, _id_project_manager)
    RETURNING
        id_document INTO id_new_report;
    
    RETURN id_new_report;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_contract (
    _number Document.number%type,
    _id_creative_director Document.id_employee%type,
    _id_order Document.id_order%type
)
RETURNS Document.id_document%type AS $$
DECLARE
    doc_type_title constant Doc_Type.type_title%type := 'Договор';
    employee_post constant Post.title%type := 'Креативный директор';

    id_cur_doc_type Document.id_doc_type%type := (
        SELECT id_doc_type
        FROM Doc_Type
        WHERE type_title = doc_type_title
    );

    id_new_report Document.id_document%type;
BEGIN
    ASSERT id_cur_doc_type is not NULL, 'Doc type does not exist: ' || doc_type_title;

    INSERT INTO
        Document(number, id_doc_type, id_order, id_employee)
    VALUES
        (_number, id_cur_doc_type, _id_order, _id_creative_director)
    RETURNING
        id_document INTO id_new_report;
    
    RETURN id_new_report;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION stamp_doc() RETURNS trigger AS $$
BEGIN
    NEW.creation_date := current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS doc_stamp ON Document;

CREATE TRIGGER doc_stamp BEFORE INSERT ON Document
    FOR EACH ROW EXECUTE PROCEDURE stamp_doc();
