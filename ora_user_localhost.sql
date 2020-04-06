create table userTable (
    id varchar2(20) primary key,
    pw varchar2(20) not null,
    name varchar2(20) not null,
    email varchar2(50) not null,
    address varchar2(100),
    phone varchar2(20)
);

--insert

insert into userTable values ('hkd', '1234', '홍길동', 'hkd@hkd.com', '서울', '010-1111-2222');
insert into userTable values ('hkd1', '1234', '홍길돈', 'hkd@hkd.com', '서울', '010-1111-2222');
insert into userTable(id, pw, name, email) values ('lss', '2345', '이순신', 'lss@lss.com');

select * from userTable;

create table goodsTable(
    gCode char(8) not null,
    gName varchar(50) not null,
    price number not null,
    constraint pk_goodsTable primary key(gCode)
);

insert into goodsTable values('20200403', '맛동산', 2000);
insert into goodsTable values('20200403', '새우깡', 2000);

create table orderTable (
    oNo char(12) primary key,
    id varchar2(20) not null,
    gCode char(8) not null,
    oDate date not null,
    constraint fk_orderTable foreign key(id)
    references userTable (id) on delete cascade -- on delete cascade : 부모도 같이 지워줌
);

drop table orderTable;

insert into orderTable values('202004030001', 'hkd', '20200403', sysdate);

select * from orderTable;
select * from userTable;

create table ex2_9 (
    num1 number constraint check1 check(num1 between 1 and 10),
    gender varchar2(10) constraint check2 check(gender in('MALE','FEMALE'))
);

alter table ex2_9 rename column num1 to num;

desc ex2_9;

insert into ex2_9 values(10, 'MALE');
insert into ex2_9 values(5, 'MALE');

create table ex2_9_copy as select * from ex2_9;

select * from ex2_9_copy;

delete from userTable where id = 'hkd';

-- 시퀀스

create table boardTable (
    no number primary key,
    title varchar2(1000) not null
);

create sequence seq_boardTable;

insert into boardTable values(seq_boardTable.nextval, 'sql이란?');

select * from boardTable;

-- select

select employee_id, emp_name, manager_id from employees where salary > 20000;
select * from employees where salary > 5000 and salary < 10000 order by salary asc;

select emp_name, salary from employees 
order by salary desc; -- desc : 내림차순 , asc : 올림차순

select emp_name, department_id, salary from employees order by department_id asc, salary asc;

select * from employees where department_id = 50 and salary > 7000;

--insert ~ select

create table employeesCopy as select * from employees;

select * from employeesCopy;

create table employeesCopy2 as select * from employees where salary > 10000;

select * from employeesCopy2;

insert into employeesCopy2 select * from employees where salary >= 7000 
and salary <= 10000;

-- 데이터 없이 구조만 복사
create table employeesCopy3 as select * from employees where 1 != 1;

select * from employeesCopy3;

-- update
select * from exserTable;

commit;

select * from userTable;

update userTable set name = '왕건' where id = 'hkd1';

update userTable set name = '왕건1', address='서울' where id = 'hkd1';


-- commit, lollback

delete from userTable where id = 'hkd1';

select * from userTable;

rollback;

select * from employees where department_id != 50;

select emp_name || ', E-mail : ' || email as name -- alias
from employees;

-- 표현식

select employee_id, salary, 
    case when salary <= 5000 then 'C등급'
        when salary > 5000 and salary <= 15000 then 'B등급' 
        else 'A등급'
    end as salary_grade
from employees;

select prod_id, channel_id, decode(channel_id, 3, 'Direct',
                                               9, 'Direct',
                                               5, 'Indirect',
                                               4, 'Indirect',
                                                  'Others') as  decodes 
from sales
where rownum < 10;

select prod_id, channel_id,  
    case channel_id when 3 then 'Direct'
                    when 4 then 'Indirect'
                    when 5 then 'Indirect'
                    when 9 then 'Direct'
                    else 'Others'
    end as decodes 
from sales
where rownum < 10;