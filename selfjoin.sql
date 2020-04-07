-- 셀프 조인
select * from employees;

select e1.emp_name, e2.emp_name
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- 또다른 예시
create table category (
    no char(4) primary key, -- 번호
    name varchar(20) not null, -- 이름
    pNo char(4) null -- 부모번호
);

insert into category values ('0001', '식품', null);
insert into category values ('0002', '가전디지털', null);

insert into category values ('0003', '컴퓨터', '0002');
insert into category values ('0004', '휴대폰', '0002');

insert into category values ('0005', '노트북', '0003');
insert into category values ('0006', '태블릿PC', '0003');

select no, name from category where pno is null;
select no, name from category where pno = '0002';
select no, name from category where pno = '0003';

select c1.name, c2.name as parent
from category c1, category c2
where c1.pno = c2.no;

--외부조인
select * from departments; 
select * from job_history;

select a.department_id, a.department_name, b.job_id, b.department_id
from departments a, job_history b
where a.department_id = b.department_id(+);

-- ansi sql outer join
select a.department_id, a.department_name, b.job_id, b.department_id
from departments a left outer join job_history b
on a.department_id = b.department_id;

select b.employee_id, b.emp_name, a.job_id, a.department_id
from job_history a, employees b
where a.employee_id(+) = b.employee_id;

-- full outer join
create table hong_a(emp_id int);
create table hong_b(emp_id int);
insert into hong_a values(10);
insert into hong_a values(20);
insert into hong_a values(30);

insert into hong_b values(10);
insert into hong_b values(20);
insert into hong_b values(40);

select a.emp_id, b.emp_id
from hong_a a full outer join hong_b b
on a.emp_id = b.emp_id;

-- 카타시안 조인 or 카타시안 곱
select a.emp_id, b.emp_id
from hong_a a, hong_b b;

--cross join 
select a.emp_id, b.emp_id
from hong_a a cross join hong_b b;

-- sub query
select count(*)
from employees
where salary >= (select avg(salary) from employees);

select count(*)
from employees
where department_id in (select department_id
                            from departments
                            where parent_id is null);
                        
select employee_id, emp_name, job_id
from employees
where(employee_id, job_id) in (select employee_id, job_id from job_history);
commit;

update employees set salary = (select avg(salary) from employees);

rollback;

-- 연관성 있는 서브쿼리
select * from departments;

select a.department_id, a.department_name
from departments a
where exists(select 1 from job_history b where a.department_id = b.department_id);

select distinct a.department_id, a.department_name
from departments a, job_history b
where a.department_id = b.department_id;

select max(salary), min(salary) from employees;

select
(select max(salary) from employees where department_id = 10) as max_10,
(select max(salary) from employees where department_id = 20) as max_20
from dual;

-- 인라인뷰
select a.emp_name, d.department_name
from (select * from employees where salary > 10000) a join departments d
on a.department_id = d.department_id;

-- 계층형 쿼리
select department_id,
       department_name,
       0 as parent_id,
       1 as levels,
       parent_id || department_id as sort
    from departments
where parent_id is null;

select department_id, LPAD(' ', 3 * (level - 1)) || department_name as name, level
    from departments
    start with parent_id is null
connect by prior department_id = parent_id;

-- *연도별*
select to_char(hire_date, 'YYYY') years, count(*)
from employees
group by to_char(hire_date, 'YYYY')
order by years;

-- 로우를 컬럼으로
-- 같은 부서의 사람들의 이름을 ','를 붙여서 나열하기
select
    (select count(*) from employees where to_char(hire_date, 'YYYY') = '1998') as "1998",
    (select count(*) from employees where to_char(hire_date, 'YYYY') = '1999') as "1999",
    (select count(*) from employees where to_char(hire_date, 'YYYY') = '2000') as "2000"
from dual;

