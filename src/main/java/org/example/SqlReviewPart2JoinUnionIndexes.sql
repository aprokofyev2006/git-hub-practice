SELECT * FROM employees;

--JOINS
SELECT e.first_name, e.last_name, r.country
FROM employees e
         JOIN regions r
              on e.region_id = r.region_id;

--list first name, email, division for employees who has email address
select e.first_name, e.email, d.division
from employees e
         JOIN departments d
              on e.department = d.department
where e.email is not null;

--list first name, email, division and country for all employees
select e.first_name, e.email, d.division, r.country
from employees e
         JOIN departments d
              on e.department = d.department
         JOIN regions r
              on e.region_id = r.region_id;

--LEFT OUTER JOIN
select distinct department
from employees;

select distinct e.department, d.department
from employees e
         left join departments d on e.department = d.department;

select distinct e.department, d.department
from employees e
         left join departments d on e.department = d.department
where d.department is null;

--RIGHT OUTER JOIN
select distinct department
from employees;

select distinct e.department, d.department
from employees e
         right join departments d on e.department = d.department;

--FULL OUTER JOIN
select distinct department
from employees;

select distinct e.department, d.department
from employees e
         FULL join departments d on e.department = d.department;

--return all employees that work in electronic division
select e.*, d.division from employees e
                                join departments d on e.department = d.department
where d.division = 'Electronics';

--can we get the same result with subqueries
select * from employees where department in (
    select department from departments where division='Electronics'
);

--UNION (will combine results from 2 tables, remove duplicates)
select department from employees
union
select department from departments;

--UNION ALL (will combine results from 2 tables, and keep duplicates)
select department from employees
union all
select department from departments;

--EXCEPT (will give a difference between 2 tables)
select department from employees
except
select department from departments;

--INTERSECT (will give a matching values between 2 tables)
select department from employees
INTERSECT
select department from departments;

--Indexes
CREATE TABLE Towns (
                       id SERIAL UNIQUE NOT NULL,
                       code VARCHAR(10) NOT NULL, -- not unique
                       article TEXT,
                       name TEXT NOT NULL -- not unique
);

insert into towns (
    code, article, name
)
select
    left(md5(i::text), 10),
    md5(random()::text),
    md5(random()::text)
from generate_series(1, 1000000) s(i);

select count(*)
from towns;

select *
from towns;

explain analyze
select * from towns
where article ='c4a13c0c4d90938203792f276a71bf81';
--Execution Time: 385.952 ms


explain analyze
select * from towns
where name ='8da48f5fd7df321e3bb7b811cae56cb9';
--Execution Time: 243.317 ms. Before creating index.
--Execution Time: 0.038 ms

explain analyze
select * from towns
where id ='232434'; --Execution Time: 0.066 ms. Because it has index.

--Create index
create index idx_towns_name on towns(name);
create index idx_article_name on towns(article);

--Drop index
drop index if exists idx_towns_name;

SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
        schemaname = 'public'
ORDER BY
    tablename,
    indexname;



