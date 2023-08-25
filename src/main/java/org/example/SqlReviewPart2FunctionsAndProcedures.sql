---------FUNCTIONS-----------


--CREATE FUNCTION
CREATE OR REPLACE FUNCTION get_department_count_by_name(dep_name varchar)
    returns int
    language plpgsql
as
$$
declare
department_count integer;
begin
select count(*)
into department_count
from employees
where department = dep_name;

return  department_count;
end;
$$

--CALL FUNCTION
select get_department_count_by_name('Sports');

--DROP FUNCTION
drop function get_department_count_by_name(dep_name varchar);
drop function get_department(p_pattern varchar);

--RETURN TABLE
CREATE OR REPLACE FUNCTION get_department(p_pattern varchar)
returns table (
    employee_name varchar,
    employee_email varchar
              )
language plpgsql
as
$$
begin
return query
select first_name, email
from employees
where department ilike p_pattern;
end;
$$

select * from get_department('Clothing');


--STORE PROCEDURE
CREATE OR REPLACE PROCEDURE update_department(emp_id int)
language plpgsql
as
$$
begin
update employees set department = 'Toys'
where employee_id = emp_id;
commit;
end;
$$;

call update_department(10);

select * from employees where employee_id=10;


--TRIGGER IS THE EVENT THAT INVOKED AUTOMATICALLY WHEN INSERT, UPDATE, DELETE EVENTS OCCURS
CREATE TABLE mentors(
                        id INT GENERATED ALWAYS AS IDENTITY,
                        first_name varchar(40) not null,
                        last_name varchar(40) not null ,
                        primary key(id)
);

CREATE TABLE mentor_audit(
                             id INT GENERATED ALWAYS AS IDENTITY,
                             mentor_id INT not null,
                             last_name varchar(40) not null ,
                             changed_on timestamp(6) not null,
                             primary key(id)
);

insert into mentors(first_name, last_name) values ('Harold','Finch');
insert into mentors(first_name, last_name) values ('Severus','Snape');

CREATE OR REPLACE FUNCTION log_last_name_changes()
    returns trigger
    language plpgsql
as
$$
begin
    IF NEW.last_name <> OLD.last_name THEN
        INSERT INTO mentor_audit(mentor_id,last_name,changed_on) VALUES
            (OLD.id,OLD.last_name,now());
end if;

Return NEW;
end
$$;

CREATE TRIGGER last_name_change
    BEFORE update
    ON mentors
    FOR EACH ROW
    EXECUTE PROCEDURE log_last_name_changes();

update mentors
set last_name ='XYZ'
where id =2;
