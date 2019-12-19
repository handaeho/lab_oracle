-- 1
desc employees;
-- 2
SELECT employee_id, last_name, first_name, CONCAT(last_name, first_name) as Full_name
FROM employees where first_name like 'J%';
-- 3
SELECT employee_id, last_name, first_name, phone_number, CONCAT(last_name, first_name) as Full_name
FROM employees where phone_number like '011%';
-- 4
SELECT employee_id, last_name, first_name, manager_id, department_id, CONCAT(last_name, first_name) as Full_name
FROM employees where manager_id = 120;
--5
SELECT * FROM employees where employee_id =120;
--6
SELECT employee_id, last_name, first_name, CONCAT(last_name, first_name) as Full_name, salary
from employees where salary BETWEEN 3000 and 5000;
--7
SELECT employee_id, last_name, first_name, CONCAT(last_name, first_name) as Full_name, salary, commission_pct, (salary*12) + (salary*commission_pct) as ÃÑ¿¬ºÀ
from employees where commission_pct is not null; 

