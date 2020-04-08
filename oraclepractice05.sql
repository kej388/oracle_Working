-- 1��
create table stock(
    goodsnum char(6) not null primary key,
    goodsname varchar(50) not null,
    goodsprice number not null,
    stockcount number 
);

-- 2��
create table inputTable(
    inputnum char(6) not null primary key,
    goodsnum char(6) not null,
    inputcount number not null,
    inputdate varchar(10),
    CONSTRAINT pk_stock1 FOREIGN key(goodsnum)
    REFERENCES stock (goodsnum)
);

--3��
create table outputTable(
    outputnum char(6) not null primary key,
    goodsnum char(6) not null,
    outputcount number not null,
    outputdate varchar(10),
    CONSTRAINT  pk_stock2 foreign key (goodsnum)
    REFERENCES stock (goodsnum)
);

--4��
insert into stock values ('g00001', '��谳', 12000, 100);
insert into stock values ('g00002', '�ð�', 40000, 20);
insert into stock values ('g00003', 'Ű��', 9000, 150);
insert into stock values ('g00004', '�Ͱ���', 15000, 120);
insert into stock values ('g00005', '��ƼĿ', 4000, 80);

select * from stock;
-- 5��
create or replace procedure my_new_goods_proc 
(
    p_inputnum in inputTable.inputnum%type,
    p_goodsnum in inputTable.goodsnum%type,
    p_inputcount in inputtable.inputcount%type,
    p_inputdate in inputtable.inputdate%type
)
is
    
begin
    insert into inputTable values (p_inputnum, p_goodsnum, p_inputcount, p_inputdate);
    update stock set stock.stockcount = stock.stockcount + p_inputcount
    where p_goodsnum = goodsnum;
    commit;
end;

exec my_new_goods_proc ('i10004', 'g00002', 30);
select * from inputtable;

-- 6��
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

-- 7��
-- �Ű����������� �ϸ� insert������ �ݵ�� �Ű������� ��� �Ѵ�. ���� table.������ �ƴ� �Ű������� ��� �Ѵ�.

-- 8��
select goodsname, stockcount
from stock
where stockcount in (select max(stockcount) from stock);

-- 9��
select a.goodsname, count(a.goodsnum) AS suminputcnt
from stock a
where count(goodsnum = (select max(count(goodsnum))
                from inputtable
                group by goodsnum)
having a.goodsname;


        
-- 10��
select a.goodsname
from stock a
where goodsname = (select substr(b.inputdate, 1, 2)
        from inputtable b
        where a.goodsnum = b.goodsnum);
        
-- 11��
