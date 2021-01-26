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


create or replace function get_middle_priority_title() returns text as $$
    select text 'средний'
$$ language sql immutable parallel safe;


create or replace function get_nonactive_state_title() returns text as $$
    select text 'неактивна'
$$ language sql immutable parallel safe;

create or replace function get_active_state_title() returns text as $$
    select text 'активна'
$$ language sql immutable parallel safe;

create or replace function get_paused_state_title() returns text as $$
    select text 'приостановлена'
$$ language sql immutable parallel safe;

create or replace function get_done_state_title() returns text as $$
    select text 'выполнена'
$$ language sql immutable parallel safe;

create or replace function get_canceled_state_title() returns text as $$
    select text 'отменена'
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
    insert into Company(title_company, address, ogrn, inn, bank_details, telephone)
        values (_title_company, _address, _ogrn, _inn, _bank_details, _telephone)
        returning id_company;
$$ language sql;


create or replace function add_client (
    _last_name Client.last_name%type,
    _name Client.name%type,
    _id_company Client.id_company%type,
    _patronymic Client.patronymic%type default null,
    _phone Client.phone%type default null,
    _email Client.email%type default null
)
returns Client.id_client%type as $$
    insert into Client(last_name, name, id_company, patronymic, phone, email)
        values (_last_name, _name, _id_company, _patronymic, _phone, _email)
        returning id_client;
$$ language sql;


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
    insert into Project(id_order, id_project_manager, id_creative_director, technical_specification)
        select co.id_order, pm.id_employee, cd.id_employee, _technical_specification
            from Customer_Order as co,
                Employee as pm,
                Employee as cd
            where co.project_description = _order_description
                and pm.last_name = _project_manager_last_name
                and pm.name = _project_manager_name
                and pm.patronymic = _project_manager_patronymic
                and cd.last_name = _creative_director_last_name
                and cd.name = _creative_director_name
                and cd.patronymic = _creative_director_patronymic
        returning id_project;
$$ language sql;



--
-- insertion of special documents
--

create or replace function add_work_report (
    _number Document.number%type,
    _id_project Document.id_project%type
)
returns Document.id_document%type as $$
    insert into Document(number, id_doc_type, id_project, id_order, id_employee)
        select _number, dt.id_doc_type, id_project, p.id_order, p.id_project_manager
            from Doc_Type as dt, Project as p
            where dt.type_title = get_work_report_title()
                and p.id_project = _id_project
        returning id_document;
$$ language sql;


create or replace function add_contract (
    _number Document.number%type,
    _id_creative_director Document.id_employee%type,
    _id_order Document.id_order%type
)
returns Document.id_document%type as $$
    insert into Document(number, id_doc_type, id_order, id_employee)
        select _number, dt.id_doc_type, _id_order, _id_creative_director
            from Doc_Type as dt
            where type_title = get_contract_title()
        returning id_document;
$$ language sql;


create or replace function add_simple_document (
    _number Document.number%type,
    _id_doc_type Document.id_doc_type%type,
    _id_project Document.id_project%type
)
returns Document.id_document%type as $$
    insert into Document(number, id_doc_type, id_project)
        values (_number, _id_doc_type, _id_project)
        returning id_document;
$$ language sql;


--
-- insertion of customer order
--

create or replace function add_customer_order (
    _id_client Customer_Order.id_client%type,
    _id_account_manager Customer_Order.id_account_manager%type,
    _project_description Customer_Order.project_description%type default null
)
returns Customer_Order.id_order%type as $$
    insert into Customer_Order(id_client, id_account_manager, project_description)
        values (_id_client, _id_account_manager, _project_description)
        returning id_order;
$$ language sql;


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
    insert into Task(id_project, deadline, description, id_priority, id_status)
        select _id_project, _deadline_data, _description, p.id_priority, s.id_status
            from Priority as p, Status as s
            where p.title = _priority_title
                and s.title = _status_title
        returning id_task;
$$ language sql;


create or replace function add_task_by_interval (
    _id_project Task.id_project%type,
    _deadline_interval interval,
    _description Task.description%type,
    _priority_title Priority.title%type default 'средний',
    _status_title Status.title%type default 'неактивна'
)
returns Task.id_task%type as $$
    select add_task(
        _id_project => _id_project,
        _deadline_data => date(current_date + _deadline_interval),
        _description => _description,
        _priority_title => _priority_title,
        _status_title => _status_title
    );
$$ language sql;


--
-- change status of the tasks with expired deadline for some project
--

create or replace function cancel_expired_tasks (
    _id_project Task.id_project%type
)
returns bigint as $$
declare
    canceled_id_status bigint := (
        select id_status from Status where title = get_canceled_state_title()
    );
    done_id_status bigint := (
        select id_status from Status where title = get_done_state_title()
    );
    
    updated_amount bigint;
begin
    with ut as (
        update Task as t
            set id_status = canceled_id_status
            where t.id_project = _id_project
                and t.deadline < current_date
                and t.id_status != canceled_id_status
                and t.id_status != done_id_status
            returning t.id_task
    )
    select count(*) into updated_amount from ut;

    return updated_amount;
end;
$$ language plpgsql;



--
-- functions for the most frequent requests
--

drop type if exists Employee_with_Task_Amount cascade;

create type Employee_with_Task_Amount as (
    employee Employee,
    task_amount bigint
);

create or replace function get_most_available_employees_list (_id_post Employee.id_post%type)
returns setof Employee_with_Task_Amount as $$
declare
    ignored_id_status bigint[] := array(
        select id_status
            from Status
            where title = get_canceled_state_title()
                or title = get_done_state_title()
    );
begin
    return query select e, count(t.id_task)
        from Employee as e
            left join (
                Task_Employee join Task using (id_task)
            ) as t
            using (id_employee)
        where e.id_post = _id_post
            and array_position(ignored_id_status, t.id_status) is null
        group by e.id_employee
        order by count(t.id_task), e.last_name, e.name, e.patronymic;
    return;
end;
$$ language plpgsql;


create or replace function get_employee_task_list (
    _id_employee Employee.id_employee%type,
    _status_title Status.title%type default null
)
returns setof Task as $$
    select t.*
        from Task as t
            join Status as s using (id_status)
            join Task_Employee as te using (id_task)
        where te.id_employee = _id_employee and (
                _status_title is null
                or s.title = _status_title
            )
        group by t.id_task;
$$ language sql;



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
    
    new.creation_date := current_date;
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