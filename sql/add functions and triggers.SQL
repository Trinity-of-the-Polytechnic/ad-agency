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

create or replace function get_account_manager_post_title() returns text as $$
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
    _name Clients_Company."name"%type,
    _address Clients_Company."address"%type default null,
    _ogrn Clients_Company."OGRN"%type default null,
    _inn Clients_Company."INN"%type default null,
    _requisites Clients_Company."requisites"%type default null,
    _phone Clients_Company."phone"%type default null
)
returns Clients_Company."id"%type as $$
    insert into Clients_Company("name", "address", "OGRN", "INN", "requisites", "phone")
        values (_name, _address, _ogrn, _inn, _requisites, _phone)
        returning "id";
$$ language sql;


create or replace function add_client (
    _last_name Clients_Client."last_name"%type,
    _first_name Clients_Client."first_name"%type,
    _company Clients_Client."company_id"%type,
    _patronymic Clients_Client."patronymic"%type default null,
    _phone Clients_Client."phone"%type default null,
    _email Clients_Client."email"%type default null
)
returns Clients_Client."id"%type as $$
    insert into Clients_Client("last_name", "first_name", "company_id", "patronymic", "phone", "email")
        values (_last_name, _first_name, _company, _patronymic, _phone, _email)
        returning "id";
$$ language sql;


create or replace function add_project_by_names (
    _order_description TEXT,

    _project_manager_last_name TEXT,
    _project_manager_first_name TEXT,
    _project_manager_patronymic TEXT,

    _creative_director_last_name TEXT,
    _creative_director_first_name TEXT,
    _creative_director_patronymic TEXT,

    _technical_task Projects_Project."technical_task"%type
)
returns Projects_Project."id"%type as $$
    insert into Projects_Project("client_order_id", "project_manager_id", "creative_director_id", "technical_task")
        select co."id", pm."id", cd."id", _technical_task
            from Clients_Order as co,
                Staff_Employee as pm,
                Staff_Employee as cd
            where co."description" = _order_description
                and pm."last_name" = _project_manager_last_name
                and pm."first_name" = _project_manager_first_name
                and pm."patronymic" = _project_manager_patronymic
                and cd."last_name" = _creative_director_last_name
                and cd."first_name" = _creative_director_first_name
                and cd."patronymic" = _creative_director_patronymic
        returning "id";
$$ language sql;



--
-- insertion of special documents
--

create or replace function add_work_report (
    _number Documents_Document."number"%type,
    _id_project Documents_Document."project_id"%type
)
returns Documents_Document."id"%type as $$
    insert into Documents_Document("number", "document_type_id", "project_id", "client_order_id", "responsible_id")
        select _number, dt."id", p."id", p."client_order_id", p."project_manager_id"
            from Documents_DocumentType as dt, Projects_Project as p
            where dt."type_name" = get_work_report_title()
                and p."id" = _id_project
        returning "id";
$$ language sql;


create or replace function add_contract (
    _number Documents_Document."number"%type,
    _id_creative_director Documents_Document."id"%type,
    _id_order Documents_Document."client_order_id"%type
)
returns Documents_Document."id"%type as $$
    insert into Documents_Document("number", "document_type_id", "client_order_id", "responsible_id")
        select _number, dt."id", _id_order, _id_creative_director
            from Documents_DocumentType as dt
            where dt."type_name" = get_contract_title()
        returning "id";
$$ language sql;


create or replace function add_simple_document (
    _number Documents_Document."number"%type,
    _id_doc_type Documents_Document."document_type_id"%type,
    _id_project Documents_Document."project_id"%type
)
returns Documents_Document."id"%type as $$
    insert into Documents_Document("number", "document_type_id", "project_id")
        values (_number, _id_doc_type, _id_project)
        returning "id";
$$ language sql;


--
-- insertion to Clients_Order
--

create or replace function add_client_order (
    _id_client Clients_Order."client_id"%type,
    _id_account_manager Clients_Order."manager_id"%type,
    _project_description Clients_Order."description"%type default null
)
returns Clients_Order."id"%type as $$
    insert into Clients_Order("client_id", "manager_id", "description")
        values (_id_client, _id_account_manager, _project_description)
        returning "id";
$$ language sql;


--
-- insertion of "task_id": two variants
--

create or replace function add_task (
    _id_project Tasks_Task."project_id"%type,
    _deadline_data Tasks_Task."deadline"%type,
    _description Tasks_Task."description"%type,
    _priority_name Tasks_Priority."priority_name"%type default 'средний',
    _status_name Tasks_Status."name"%type default 'неактивна'
)
returns Tasks_Task."id"%type as $$
    insert into Tasks_Task("project_id", "deadline", "description", "priority_id", "status_id")
        select _id_project, _deadline_data, _description, p."id", s."id"
            from Tasks_Priority as p, Tasks_Status as s
            where p."priority_name" = _priority_name
                and s."name" = _status_name
        returning "id";
$$ language sql;


create or replace function add_task_by_interval (
    _id_project Tasks_Task."project_id"%type,
    _deadline_interval interval,
    _description Tasks_Task."description"%type,
    _priority_name Tasks_Priority."priority_name"%type default 'средний',
    _status_name Tasks_Status."name"%type default 'неактивна'
)
returns Tasks_Task."id"%type as $$
    select add_task(
        _id_project => _id_project,
        _deadline_data => date(current_date + _deadline_interval),
        _description => _description,
        _priority_name => _priority_name,
        _status_name => _status_name
    );
$$ language sql;


--
-- change "status_id" of the tasks with expired "deadline" for some "project_id"
--

create or replace function cancel_expired_tasks (
    _id_project Tasks_Task."project_id"%type
)
returns bigint as $$
declare
    canceled_id_status bigint := (
        select s."id" from Tasks_Status s where s."name" = get_canceled_state_title()
    );
    done_id_status bigint := (
        select s."id" from Tasks_Status s where s."name" = get_done_state_title()
    );
    
    updated_amount bigint;
begin
    with ut as (
        update Tasks_Task as t
            set "status_id" = canceled_id_status
            where t."project_id" = _id_project
                and t."deadline" < current_date
                and t."status_id" != canceled_id_status
                and t."status_id" != done_id_status
            returning t."id"
    )
    select count(*) into updated_amount from ut;

    return updated_amount;
end;
$$ language plpgsql;



--
-- functions for the most frequent requests
--

drop type if exists BusyEmployee cascade;

create type BusyEmployee as (
    "employee_id" Staff_Employee,
    task_amount bigint
);

create or replace function get_most_available_employees_list (_id_post Staff_Employee."post_id"%type)
returns setof BusyEmployee as $$
declare
    ignored_id_status bigint[] := array(
        select s."id"
            from Tasks_Status s
            where "name" = get_canceled_state_title()
                or "name" = get_done_state_title()
    );
begin
    return query select e, count(ett."task_id")
        from Staff_Employee as e
            left join (
                Tasks_EmployeeTask et join Tasks_Task t on (et."task_id" = t."id")
            ) as ett
            on (e."id" = ett."employee_id")
        where e."post_id" = _id_post
            and array_position(ignored_id_status, ett."status_id") is null
        group by e."id"
        order by count(ett."task_id"), e."last_name", e."first_name", e."patronymic";
    return;
end;
$$ language plpgsql;


create or replace function get_employee_task_list (
    _id_employee Staff_Employee."id"%type,
    _status_name Tasks_Status."name"%type default null
)
returns setof Tasks_Task as $$
    select t.*
        from Tasks_Task as t
            join Tasks_Status as s on (t."status_id" = s."id")
            join Tasks_EmployeeTask as et on (et."task_id" = t."id")
        where et."employee_id" = _id_employee and (
                _status_name is null
                or s."name" = _status_name
            )
        group by t."id";
$$ language sql;



--
-- triggers
--

create or replace function on_insert_doc() returns trigger as $$
declare
    work_report_id constant Documents_DocumentType."id"%type := (
        select dt."id" from Documents_DocumentType dt where dt."type_name" = get_work_report_title()
    );
    contract_id constant Documents_DocumentType."id"%type := (
        select dt."id" from Documents_DocumentType dt where dt."type_name" = get_contract_title()
    );
    
    project_manager_post_id constant Staff_Post."id"%type := (
        select p."id" from Staff_Post p where p."name" = get_project_manager_post_title()
    );
    creative_director_post_id constant Staff_Post."id"%type := (
        select p."id" from Staff_Post p where p."name" = get_creative_director_post_title()
    );

    cur_post_id Staff_Post."id"%type := (
        select p."id"
            from Staff_Employee e join Staff_Post p on (e."post_id" = p."id")
            where e."id" = new."responsible_id"
    );

begin
    assert work_report_id is not null,
        'missing document type: ' || get_work_report_title();
    assert contract_id is not null,
        'missing document type: ' || get_contract_title();
    assert project_manager_post_id is not null,
        'missing "employee_id" "post_id": ' || get_project_manager_post_title();
    assert creative_director_post_id is not null,
        'missing "employee_id" "post_id": ' || get_creative_director_post_title();


    if new."document_type_id" = work_report_id and cur_post_id is distinct from project_manager_post_id then
        raise exception
            'document ("number" = "%") of type "%" must have "employee_id" with "post_id" "%" instead of "%"',
            new."number", get_work_report_title(), get_project_manager_post_title(),
            (select "name" from Staff_Post where "post_id" = cur_post_id);
    end if;
    
    if new."document_type_id" = contract_id and cur_post_id is distinct from creative_director_post_id then
        raise exception
            'document ("number" = "%") of type "%" must have "employee_id" with "post_id" "%" instead of "%"',
            new."number", get_contract_title(), get_creative_director_post_title(),
            (select "name" from Staff_Post where "post_id" = cur_post_id);
    end if;
    
    if new."creation_date" is null then
        new."creation_date" := current_date;
    end if;
    
    return new;
end;
$$ language plpgsql;


drop trigger if exists on_insert_doc_trigger on Documents_Document;

create trigger on_insert_doc_trigger BEFORE INSERT on Documents_Document
    for each row execute procedure on_insert_doc();



create or replace function on_insert_client_order() returns trigger as $$
declare
    account_manager_post_id constant Staff_Post."id"%type := (
        select p."id" from Staff_Post p where p."name" = get_account_manager_post_title()
    );
    cur_post_id Staff_Post."id"%type := (
        select p."id"
            from Staff_Employee e join Staff_Post p on (e."post_id" = p."id")
            where e."id" = new."manager_id"
    );
begin
    assert account_manager_post_id is not null,
        'missing "employee_id" "post_id": ' || get_account_manager_post_title();

    if cur_post_id is distinct from account_manager_post_id then
        raise exception
            'Clients_Order must have "employee_id" with "post_id" "%" instead of "%"',
            get_account_manager_post_title(),
            (select p."name" from Staff_Post p where p."id" = cur_post_id);
    end if;

    if new."description" is null then
        select concat(
                'Аккаунт-менеджежер: ', e."last_name", ' ', e."first_name", '\n',
                'Заказчик: ', c."last_name", ' ', c."first_name", ' ', c."patronymic", '\n',
                'Дата: ', current_date
            )
            from Staff_Employee as e, Clients_Client as c
            into new."description"
            where e."id" = new."manager_id"
                and c."id" = new."client_id";
    end if;

    return new;
end;
$$ language plpgsql;


drop trigger if exists on_insert_client_order_trigger on Clients_Order;

create trigger on_insert_client_order_trigger BEFORE INSERT on Clients_Order
    for each row execute procedure on_insert_client_order();