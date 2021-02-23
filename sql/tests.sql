-- чтобы выключить assert
-- set plpgsql.check_asserts to off;


-- test 1
delete from Documents_Document;
select add_work_report(
    _number => 'work "report_id" #1',
    _id_project => 1
);
select add_contract(
    _number => 'contract #1',
    _id_creative_director => 1,
    _id_order => 1
);
select add_simple_document(
    _number => 'Simple #1',
    _id_doc_type => 1,
    _id_project => 1
);
select * from Documents_Document;


-- test 2
select add_task (1, date '2020-02-15', 'сдать лабу');
select add_task_by_interval (2, '-4 days', 'сделать лабу');


-- test 3
select add_client_order(3, 5);


-- test 4
select cancel_expired_tasks(1);


-- test 5
update Tasks_Task as t
    set "status_id" = s."id"
    from Tasks_Status as s
    where s."name" = 'активна'
    returning t."id", t."project_id", t.""description"", t."status_id";

select t."id", t."project_id", t.""description"", t."deadline", s."name"
    from Tasks_Task as t join Tasks_Status as s on(t."status_id" = s."id");


-- test 6
select c as task_count, (e).*
    from get_most_available_employees_list(
        (select "id" from Staff_Post where "name" = 'Дизайнер')
    ) as eta(e, c);


-- test 7
select *
    from get_employee_task_list(
        (
            select "id"
                from Staff_Employee
                where "last_name" = 'Васильченко' and "first_name" = 'Анна' and "patronymic" = 'Александровна'
        )
        , 'отменена'
    );


-- ALTER TABLE tasks_task 
-- RENAME COLUMN "prority_id" TO "priority_id";
