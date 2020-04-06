create table student (
    id varchar(10) primary key not null,
    name varchar(20) not null,
    department varchar(30) not null,
    address varchar(50) not null
);

insert into student values ('20160001', '홍길동', '컴퓨터공학과', '서울시 영등포구');
insert into student values ('20162233', '이순신', '멀티미디어학과', '부산시 남구');
insert into student values ('20161177', '왕건', '멀티미디어학과', '강원도 삼척시');

select id, name, department from student;

select name from student where department = '컴퓨터공학과';

select name from student where address = '서울시 영등포구';

select * from student order by id asc;

select * from student order by name desc;

select department, id from student order by department asc, id asc;

create table student_MultiMedia (
    id varchar(10) not null,
    name varchar(20) not null,
    department varchar(30) not null,
    address varchar(50) not null
);


insert into student_MultiMedia (id, name, department, address)
select id, name, department, address from student where department = '멀티미디어학과';