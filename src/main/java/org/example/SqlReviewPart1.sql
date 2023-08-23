select * from employees;
SELECT * FROM departments;
SELECT * FROM regions;

SELECT employee_id,first_name,department
FROM employees;

SELECT * FROM employees
WHERE department = 'Sports';

SELECT * FROM employees
WHERE department like '%nit%';

SELECT * FROM employees
WHERE department like 'G%';

SELECT * FROM employees
WHERE department like 'G____';

SELECT * FROM employees
WHERE salary >= 100000;

SELECT * FROM employees
WHERE salary <= 100000;

-- show me the employees who is working in Clothing dep and making > 90000
select first_name,last_name,department,salary from employees
where department = 'Clothing'
and salary > 90000;

-- show me the employees who is working in Clothing or Pharmacy dep and making < 40000
select first_name,last_name,department,salary from employees
where (department = 'Clothing' OR department = 'Pharmacy')
and salary < 40000;

--show me everything that is not belongs to Sports department
select * from employees
where department != 'Sports';

select * from employees
where department <> 'Sports';

select * from employees
where not department <> 'Sports';

select first_name, email
from employees
where email is null;

select first_name, email
from employees
where email is not null;

select * from employees
where salary between 80000 and 100000;

--write a query that returns the first name and email of females that work in the Tools department
--having a salary greater than 110,000

select first_name, email from employees
where department = 'Tools'
and salary > 110000
and gender='F';

select *
from employees
order by employee_id desc;

select *
from employees
order by employee_id desc
limit 5;

select *
from employees
order by employee_id desc
FETCH FIRST 5 ROWS ONLY;

-- HOW TO SEE ONLY UNIQUE DEPARTMENTS
SELECT DISTINCT department
FROM employees;

SELECT SALARY AS ANNUAL_SALARY
FROM employees;

--WRITE A QUERY THAT DISPLAYES THE NAME AND AGES OF THE TOP 4 OLDEST STUDENTS
SELECT student_name, age FROM students
ORDER BY age DESC
LIMIT 4;

--STRING MANIPULATION
SELECT upper(first_name), LOWER(last_name)
FROM employees;

SELECT length(first_name), first_name
FROM employees;

SELECT TRIM('   HELLO THERE    ');
SELECT LENGTH('   HELLO THERE    ');
SELECT LENGTH(TRIM('   HELLO THERE    '));

--CREATE FULL NAME COLUMN AND DISPLAY
SELECT first_name || ' '||last_name AS FULL_NAME
FROM employees;

--BOOLEAN VALUES
SELECT salary, (salary>140000) AS GREATER_THAN_140K
FROM employees
ORDER BY salary DESC;


--SUBSTRING(STRING, START_POSITION, LENGTH)
SELECT substring('THIS IS TEST DATA', 1, 4) AS TEST_DATA;
SELECT substring('THIS IS TEST DATA' FROM 1 FOR 4) AS TEST_DATA;

--DISPLAY ONE INITIALS COLUMN
SELECT substring(first_name,1,1) ||' '||substring(last_name,1,1) AS INITIALS
FROM employees;

SELECT department, replace(department,'Clothing','Clothes')
from departments;

--aggregate functions
select max(salary)
from employees;

select min(salary)
from employees;

select avg(salary)
from employees;

select round(avg(salary),2)
from employees;

select count(*)
from employees;

select count(email)
from employees;

select sum(salary)
from employees
where department='Clothing';

--who is making lowest salary?
select min(salary)
from employees;

select * from employees
where salary = (
    select min(salary)
    from employees
);

select * from employees
where salary = (
    select max(salary)
    from employees
);

--show me all unique email domains
select email
from employees;

select substring(email from '@(.*)$') as domain, count(*)
from employees
group by domain;

--how many employees are working in pharmacy department
select count(*)
from employees
where department = 'Pharmacy';

--how many employees are working for each department
select department, count(*),max(salary),min(salary),sum(salary),round(avg(salary),2)
from employees
group by department;

--list the departments having more than 40 employees except 'Garden' department
select department, count(*),max(salary),min(salary),sum(salary),round(avg(salary),2)
from employees
where department != 'Garden'
group by department having count(*)>40
order by department;

--list the departments having max salary > 160000
select department, count(*),max(salary),min(salary),sum(salary),round(avg(salary),2)
from employees
group by department having max(salary)>160000;

--show me the duplicate email domains and how many times they are repeat
select substring(email from '@(.*)$') as domain, count(*)
from employees
where email is not null
group by domain
having count(*)>1
order by count desc;

select substring(email,position('@' IN email)+1) as domain, count(*)
from employees
where email is not null
group by domain
having count(*)>1
order by count desc;

--CASE (IF ELSE CONDITIONS)
SELECT first_name, salary,
    CASE
        WHEN salary < 80000 THEN 'UNDER PAID'
        WHEN salary > 80000 THEN 'PAID WELL'
        ELSE 'UNPAID'
    END AS category
FROM employees;