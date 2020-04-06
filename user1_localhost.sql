create table student (
    id varchar(10) primary key not null,
    name varchar(20) not null,
    department varchar(30) not null,
    address varchar(50) not null
);

insert into student values ('20160001', 'ȫ�浿', '��ǻ�Ͱ��а�', '����� ��������');
insert into student values ('20162233', '�̼���', '��Ƽ�̵���а�', '�λ�� ����');
insert into student values ('20161177', '�հ�', '��Ƽ�̵���а�', '������ ��ô��');

select id, name, department from student;

select name from student where department = '��ǻ�Ͱ��а�';

select name from student where address = '����� ��������';

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
select id, name, department, address from student where department = '��Ƽ�̵���а�';