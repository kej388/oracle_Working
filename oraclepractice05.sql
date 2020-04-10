-- 1번
create table stock(
    goodsnum char(6) not null primary key,
    goodsname varchar(50) not null,
    goodsprice number not null,
    stockcount number 
);

-- 2번
create table inputTable(
    inputnum char(6) not null primary key,
    goodsnum char(6) not null,
    inputcount number not null,
    inputdate varchar(10),
    CONSTRAINT pk_stock1 FOREIGN key(goodsnum)
    REFERENCES stock (goodsnum)
);

--3번
create table outputTable(
    outputnum char(6) not null primary key,
    goodsnum char(6) not null,
    outputcount number not null,
    outputdate varchar(10),
    CONSTRAINT  pk_stock2 foreign key (goodsnum)
    REFERENCES stock (goodsnum)
);

--4번
insert into stock values ('g00001', '목배개', 12000, 100);
insert into stock values ('g00002', '시계', 40000, 20);
insert into stock values ('g00003', '키링', 9000, 150);
insert into stock values ('g00004', '귀걸이', 15000, 120);
insert into stock values ('g00005', '스티커', 4000, 80);

select * from stock;
-- 5번
create or replace procedure my_new_goods_proc 
(
    p_inputnum in inputTable.inputnum%type,
    p_goodsnum in inputTable.goodsnum%type,
    p_inputcount in inputtable.inputcount%type
)
is
    
begin
    insert into inputTable values (p_inputnum, p_goodsnum, p_inputcount, sysdate);
    update stock set stock.stockcount = stock.stockcount + p_inputcount
    where p_goodsnum = goodsnum;
    commit;
end;

exec my_new_goods_proc ('i10004', 'g00003', 30);
select * from inputtable;

-- 6번
create or replace procedure my_new_goods_proc 
(
    p_outputnum in outputTable.outputnum%type,
    p_goodsnum in outputTable.goodsnum%type,
    p_outputcount in outputtable.outputcount%type,
    p_outputdate in outputtable.outputdate%type
)
is
    
begin
    insert into outputTable values (p_outputnum, p_goodsnum, p_outputcount, p_outputdate);
    update stock set stock.stockcount = stock.stockcount - p_outputcount
    where p_goodsnum = goodsnum;
    commit;
end;

exec my_new_goods_proc ('i10003', 'g00003', 50);
select * from stock where goodsnum = 'g00003';

-- 7번
-- 매개변수선언을 하면 insert문에서 반드시 매개변수를 써야 한다. 또한 table.변수가 아닌 매개변수를 써야 한다.

-- 8번
select goodsname, stockcount
from stock
where stockcount in (select max(stockcount) from stock);

-- 9번

select a.goodsname, count(b.goodsnum)
from stock a, inputtable b
where a.goodsnum = b.goodsnum
group by a.goodsname
having count(b.goodsnum) = (select max(count(goodsnum)) from inputtable group by goodsnum);

-- 10번
insert into inputtable values ('i10005', 'g00004', 40, '2017/04/09');
insert into inputtable values ('i10006', 'g00004', 40, '2017/04/09');

select a.goodsname
from stock a, inputtable b
where b.goodsnum = a.goodsnum
and b.inputdate like '2017%';
        
-- 11번
insert into outputtable values('o10001', 'g00001', 30, '2019/04/09');
insert into outputtable values('o10002', 'g00002', 50, '2019/04/09');
insert into outputtable values('o10003', 'g00002', 50, '2019/04/10');
insert into outputtable values('o10004', 'g00001', 50, '2020/01/10');

-- 11-1

select b.outputdate, a.goodsname, sum(b.outputcount)
from stock a, outputtable b
where a.goodsnum = b.goodsnum
group by b.outputdate, a.goodsname
order by outputdate;

-- 11-2 goodsname별 총합
select a.goodsname, sum(b.outputcount)
from stock a, outputtable b
where a.goodsnum = b.goodsnum
group by a.goodsname;

-- 11-3 연도 중복0, goodsname 중복x ex) 2019 시계 
select SUBSTR(a.outputdate, 1, 4) as years, b.goodsname, sum(a.outputcount) as outputcnt
from outputtable a, stock b
where a.goodsnum = b.goodsnum
group by SUBSTR(a.outputdate, 1, 4), b.goodsname;

select * from outputtable;

-- 12 번
create or replace function manager_name_fuc (p_manager_id number)
return varchar
is manager_name employees.emp_name%type;
begin
    select emp_name
    into manager_name
    from employees
    where employee_id = p_manager_id;
    
    return manager_name;
end;

select emp_name, manager_name_fuc(124) from employees;

-- 13번
create table employees2 as 
select *
from employees
where 1 = 2; 

drop table employees2;

select * from employees2;

--14번
create or replace procedure employee_proc
is
begin

    insert into employees2 select *
    from employees
    where employees.salary >= 3000;
        
end;

exec employee_proc

select * from employees2;