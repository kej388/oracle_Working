select employee_id, salary
from employees
where salary = any(2000, 3000, 4000)
order by employee_id;

-- in 많이 씀
select employee_id, salary
from employees
where salary in(2000, 3000, 4000)
order by employee_id;

select employee_id, salary
from employees
where salary = some(2000, 3000, 4000)
order by employee_id;

select employee_id, salary
from employees
where salary = all(2000, 3000, 4000)
order by employee_id;

select employee_id, salary
from employees
where not(salary>=2500) -- ()안에 결과에 반대를 하고 싶을 때 
order by employee_id;

select * 
from employees
where manager_id is null;

select employee_id, salary
from employees
where salary between 2000 and 2500
order by employee_id;

select employee_id, salary
from employees
where salary not in (2000, 3000, 4000)
order by employee_id;

select emp_name
from employees
where emp_name like '%A%'
order by emp_name;

select concat(emp_name, email)
from employees;

select ltrim('abcdefgabc', 'abc'),
       ltrim('가나다라', '가'),
       rtrim('abcdefgabc', 'abc'),
       rtrim('가나다라','라')
from dual;

select sysdate from dual;

select substrb('ABCDEFG', -2 ,4 ), substrb('데이터베이스', 1, 4)
from dual;

select emp_name, hire_date, add_months(hire_date, 12)
from employees;

select add_months(sysdate, -1) from dual;

select emp_name, hire_date
from employees
where hire_date > add_months(sysdate, -12);

select emp_name, months_between(sysdate, hire_date)
from employees;

select to_char(123456789, '999,999,999') from dual;

select to_char(sysdate, 'YYYY-MM-DD') as now from dual;

select to_char(sysdate, 'day') as jday from dual;

select to_char(sysdate, 'Q') as  quarter from dual; -- Q -> quarter

select to_date('20140101', 'YYYY-MM-DD') from dual;

select emp_name, nvl(manager_id, 0)
from employees;

-- 기본 집계 함수
-- count(expr)
select count(manager_id) from employees; -- null값 제외

-- distinct
select DISTINCT department_id from employees order by 1; 

-- sum(expr)
select sum(salary) from employees;

-- avg(expr)
select avg(salary) from employees; -- null값 제외

-- min(expr), max(expr)
select min(salary), max(salary) from employees;

create table sample1(
    korea number,
    english number
);

insert into sample1 values(100, 100);
insert into sample1 values(100, 80);
insert into sample1 values(100, null);

select * from sample1;

select count(english) from sample1;
select avg(english) from sample1;
select avg(nvl(english, 0)) from sample1;

-- group by 절
select department_id, sum(salary) from employees 
group by department_id;

select distinct department_id from employees;

select sum(salary) from employees 
where department_id = 100;

-- having
select department_id, count(*)
from employees
where department_id > 50 -- group by 보다 먼저 실행됨
group by department_id
having count(*) > 10 -- count(*)를 먼저 구한 후 10보다 큰 행만 출력
order by department_id;

select period, sum(loan_jan_amt) total_jan 
from kor_loan_status
where period like '2013%'
group by period
order by period;

select period, region, sum(loan_jan_amt) total_jan 
from kor_loan_status
where period like '2013%'
group by period, region
order by period, region;

-- rollup
select period, region, sum(loan_jan_amt) total_jan 
from kor_loan_status
where period like '2013%'
group by rollup(period, region);

select period, gubun, sum(loan_jan_amt) total_jan
from kor_loan_status
where period like '2013%'
group by rollup(period, gubun);

-- cube
select period, gubun, sum(loan_jan_amt) total_jan
from kor_loan_status
where period like '2013%'
group by cube(period, gubun)
order by period, gubun;

-- union
select 'a', 'b', 'c' from dual
union
select 'x', 'y', 'z' from dual;

--조인
--동등조인

