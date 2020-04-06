-- member2
create table member2 (
    id varchar(10) not null primary key,
    name varchar(20) not null,
    gender varchar(10)
    CONSTRAINT check4 check(gender in ('m', 'f')),
    joinDate varchar(10)
);

insert into member2 values('hkd','홍길동','m','2001-01-01');
insert into member2 values('lss','이순신','m','2003-02-01');
insert into member2 values('hj','황진이','f','2002-11-13');
insert into member2 values('wg','왕건','m','2005-12-21');
insert into member2 values('pms','박문수','m','2006-11-09');

create table goods (
    gNo number not null primary key,
    gName varchar(20) not null,
    price number not null
);

drop table goods;

insert into goods values(1,'mp3',10000);
insert into goods values(2,'camera',50000);
insert into goods values(3,'pc',700000);

create table orders (
    oNo number not null primary key,
    id varchar(10) not null,
    oDate varchar(20),
    constraint order_pk foreign key(id)
    REFERENCES member2 (id)
);

drop table orders;

insert into  orders values(1,'hkd','2001-03-27');
insert into orders values(2,'wg','2005-04-17');
insert into orders values(3,'hkd','2006-02-07');

create table ordersDetail (
    no number,
    oNo number not null,
    gNo number not null,
    ea number,
    constraint order_num foreign key(oNo)
    references orders(oNo),
    constraint goods_num foreign key(gNo)
    references goods(gNo)
);

insert into ordersDetail values(1,1,1,1);
insert into ordersDetail values(2,1,3,1);
insert into ordersDetail values(3,2,2,2);
insert into ordersDetail values(4,3,2,1);

select count(*) from member2;
select count(gender) as gender, count(*) member 
from member2
where gender like 'm';

--4번
select g.gname, sum(ord.ea) 
from goods g, ordersDetail ord
where g.gno = ord.gno
group by g.gname
order by sum(ea) desc;

--6번
select name from member2 where name like '홍%';

--5번
select ord.id, g.gname, orde.ea
from orders ord, goods g, ordersDetail orde
where ord.ono = orde.ono and g.gno = orde.gno;


-- 7번
select substr(ord.oDate, 1, 4) as orderdate, g.gname, orde.ea
from orders ord, goods g, ordersDetail orde
where ord.ono = orde.ono and g.gno = orde.gno
order by orderdate;