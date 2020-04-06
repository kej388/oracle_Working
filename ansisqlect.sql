select * from employees;

select * from jobs;

select e.employee_id, e.emp_name, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
order by employee_id;

-- ansi sql
select e.employee_id, e.emp_name, j.job_title
from employees e inner join jobs j
on e.job_id = j.job_id;

select e.emp_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

--ansi sql
select e.emp_name, d.department_name, j.job_title
from employees e join departments d
on e.department_id = d.department_id
     join jobs j
     on e.job_id = j.job_id;
     
-- view
create or replace view v1
as
select e.emp_name, d.department_name, j.job_title
from employees e join departments d
on e.department_id = d.department_id
     join jobs j
on e.job_id = j.job_id;

select * from v1;