--
-- constants
--

create or replace function get_work_report_title() returns text as $$
    select text 'Отчет о проделанной работе'
$$ language sql immutable parallel safe;

create or replace function get_contract_title() returns text as $$
    select text 'Договор'
$$ language sql immutable parallel safe;


create or replace function get_project_manager_post_title() returns text as $$
    select text 'Руководитель проектов'
$$ language sql immutable parallel safe;

create or replace function get_creative_director_post_title() returns text as $$
    select text 'Креативный директор'
$$ language sql immutable parallel safe;

create or replace function get_accaunt_manager_post_title() returns text as $$
    select text 'Аккаунт-менеджер'
$$ language sql immutable parallel safe;


--
-- simple functions for insertion
--

create or replace function add_company (
    _title_company Company.title_company%type,
    _address Company.address%type default null,
    _ogrn Company.ogrn%type default null,
    _inn Company.inn%type default null,
    _bank_details Company.bank_details%type default null,
    _telephone Company.telephone%type default null
)
returns Company.id_company%type as $$
declare
    id_new_company Company.id_company%type;
begin
    insert into company(title_company, address, ogrn, inn, bank_details, telephone)
        values (_title_company, _address, _ogrn, _inn, _bank_details, _telephone)
        returning id_company into id_new_company;
    
    return id_new_company;
end;
$$ language plpgsql;


create or replace function add_client (
    _last_name Client.last_name%type,
    _name Client.name%type,
    _id_company Client.id_company%type,
    _patronymic Client.patronymic%type default null,
    _phone Client.phone%type default null,
    _email Client.email%type default null
)
returns Client.id_client%type as $$
declare
    id_new_client Client.id_client%type;
begin
    insert into client(last_name, name, id_company, patronymic, phone, email)
        values (_last_name, _name, _id_company, _patronymic, _phone, _email)
        returning id_client into id_new_client;
    
    return id_new_company;
end;
$$ language plpgsql;


create or replace function add_project_by_names (
    _order_description TEXT,

    _project_manager_last_name TEXT,
    _project_manager_name TEXT,
    _project_manager_patronymic TEXT,

    _creative_director_last_name TEXT,
    _creative_director_name TEXT,
    _creative_director_patronymic TEXT,

    _technical_specification Project.technical_specification%type
)
returns Project.id_project%type as $$
declare
    id_new_project Project.id_project%type;
begin
    insert into Project(id_order, id_project_manager, id_creative_director, technical_specification)
    values (
        (
            select id_order
                from Customer_Order
                where project_description = _order_description
        ),
        (
            select id_employee
                from Employee
                where last_name = _project_manager_last_name and
                    name = _project_manager_name and
                    patronymic = _project_manager_patronymic
        ),
        (
            select id_employee
                from Employee
                where last_name = _creative_director_last_name and
                    name = _creative_director_name and
                    patronymic = _creative_director_patronymic
        ),        
        _technical_specification
    )
    returning id_project into id_new_project;
    
    return id_new_project;
end;
$$ language plpgsql;



--
-- insertion of special documents
--

create or replace function add_work_report (
    _number Document.number%type,
    _id_project_manager Document.id_employee%type
)
returns Document.id_document%type as $$
declare
    id_cur_doc_type Document.id_doc_type%type := (
        select id_doc_type from Doc_Type where type_title = get_work_report_title()
    );
    id_cur_project Document.id_project%type;
    id_cur_order Document.id_order%type;
    
    id_new_report Document.id_document%type;
begin
    select id_project, id_order
        from Project
        into id_cur_project, id_cur_order
        where id_project_manager = _id_project_manager;

    insert into Document(number, id_doc_type, id_project, id_order, id_employee)
        values (_number, id_cur_doc_type, id_cur_project, id_cur_order, _id_project_manager)
        returning id_document into id_new_report;
    
    return id_new_report;
end;
$$ language plpgsql;


create or replace function add_contract (
    _number Document.number%type,
    _id_creative_director Document.id_employee%type,
    _id_order Document.id_order%type
)
returns Document.id_document%type as $$
declare
    id_cur_doc_type Document.id_doc_type%type := (
        select id_doc_type from Doc_Type where type_title = get_contract_title()
    );

    id_new_report Document.id_document%type;
begin
    insert into Document(number, id_doc_type, id_order, id_employee)
        values (_number, id_cur_doc_type, _id_order, _id_creative_director)
        returning id_document into id_new_report;
    
    return id_new_report;
end;
$$ language plpgsql;


create or replace function add_simple_document (
    _number Document.number%type,
    _id_doc_type Document.id_doc_type%type,
    _id_project Document.id_project%type
)
returns Document.id_document%type as $$
declare
    id_new_report Document.id_document%type;
begin
    insert into Document(number, id_doc_type, id_project)
        values (_number, _id_doc_type, _id_project)
        returning id_document into id_new_report;
    
    return id_new_report;
end;
$$ language plpgsql;


--
-- insertion of task: two variants
--

create or replace function add_task (
    _id_project Task.id_project%type,
    _deadline_data Task.deadline%type,
    _description Task.description%type,
    _priority_title Priority.title%type default 'средний',
    _status_title Status.title%type default 'неактивна'
)
returns Task.id_task%type as $$
declare
    id_new_task Task.id_task%type;
begin
    insert into Task(id_project, deadline, description, id_priority, id_status)
        values (
            _id_project,
            _deadline_data,
            _description,
            (select id_priority from Priority where title = _priority_title),
            (select id_status from Status where title = _status_title)
        )
        returning id_task into id_new_task;
    
    return id_new_task;
end;
$$ language plpgsql;


create or replace function add_task_by_interval (
    _id_project Task.id_project%type,
    _deadline_interval interval,
    _description Task.description%type,
    _priority_title Priority.title%type default 'средний',
    _status_title Status.title%type default 'неактивна'
)
returns Task.id_task%type as $$
begin
    return add_task(
        _id_project => _id_project,
        _deadline_data => date(current_date + _deadline_interval),
        _description => _description,
        _priority_title => _priority_title,
        _status_title => _status_title
    );
end;
$$ language plpgsql;


--
-- insertion of customer order
--

create or replace function add_customer_order (
    _id_client Customer_Order.id_client%type,
    _id_account_manager Customer_Order.id_account_manager%type,
    _project_description Customer_Order.project_description%type default null
)
returns Customer_Order.id_order%type as $$
declare
    id_new_order Customer_Order.id_order%type;
begin
    raise notice '% %', _id_client, _id_account_manager;

    insert into Customer_Order(id_client, id_account_manager, project_description)
        values (_id_client, _id_account_manager, _project_description)
        returning id_order into id_new_order;
    
    return id_new_order;
end;
$$ language plpgsql;


--
-- triggers
--

create or replace function on_insert_doc() returns trigger as $$
declare
    work_report_id constant Doc_Type.id_doc_type%type := (
        select id_doc_type from Doc_Type where type_title = get_work_report_title()
    );
    contract_id constant Doc_Type.id_doc_type%type := (
        select id_doc_type from Doc_Type where type_title = get_contract_title()
    );
    
    project_manager_post_id constant Post.id_post%type := (
        select id_post from Post where title = get_project_manager_post_title()
    );
    creative_director_post_id constant Post.id_post%type := (
        select id_post from Post where title = get_creative_director_post_title()
    );

    cur_post_id Post.id_post%type := (
        select id_post
            from Employee natural join Post
            where id_employee = new.id_employee
    );

begin
    assert work_report_id is not null,
        'missing document type: ' || get_work_report_title();
    assert contract_id is not null,
        'missing document type: ' || get_contract_title();
    assert project_manager_post_id is not null,
        'missing employee post: ' || get_project_manager_post_title();
    assert creative_director_post_id is not null,
        'missing employee post: ' || get_creative_director_post_title();


    if new.id_doc_type = work_report_id and cur_post_id is distinct from project_manager_post_id then
        raise exception
            'document (number = "%") of type "%" must have employee with post "%" instead of "%"',
            new.number, get_work_report_title(), get_project_manager_post_title(),
            (select title from Post where id_post = cur_post_id);
    end if;
    
    if new.id_doc_type = contract_id and cur_post_id is distinct from creative_director_post_id then
        raise exception
            'document (number = "%") of type "%" must have employee with post "%" instead of "%"',
            new.number, get_contract_title(), get_creative_director_post_title(),
            (select title from Post where id_post = cur_post_id);
    end if;
    
    new.creation_date := current_timestamp;
    return new;
end;
$$ language plpgsql;


drop trigger if exists on_insert_doc_trigger on Document;

create trigger on_insert_doc_trigger BEFORE INSERT on Document
    for each row execute procedure on_insert_doc();



create or replace function on_insert_customer_order() returns trigger as $$
declare
    accaunt_manager_post_id constant Post.id_post%type := (
        select id_post from Post where title = get_accaunt_manager_post_title()
    );
    cur_post_id Post.id_post%type := (
        select id_post
            from Employee natural join Post
            where id_employee = new.id_account_manager
    );
begin
    assert accaunt_manager_post_id is not null,
        'missing employee post: ' || get_accaunt_manager_post_title();

    if cur_post_id is distinct from accaunt_manager_post_id then
        raise exception
            'customer order must have employee with post "%" instead of "%"',
            get_accaunt_manager_post_title(),
            (select title from Post where id_post = cur_post_id);
    end if;

    if new.project_description is null then
        select concat(
                'Аккаунт-менеджежер: ', e.last_name, ' ', e.name, '\n',
                'Заказчик: ', c.last_name, ' ', c.name, ' ', c.patronymic, '\n',
                'Дата: ', current_date
            )
            from Employee as e, Client as c
            into new.project_description
            where e.id_employee = new.id_account_manager
                and c.id_client = new.id_client;
    end if;

    return new;
end;
$$ language plpgsql;


drop trigger if exists on_insert_customer_order_trigger on Customer_Order;

create trigger on_insert_customer_order_trigger BEFORE INSERT on Customer_Order
    for each row execute procedure on_insert_customer_order();