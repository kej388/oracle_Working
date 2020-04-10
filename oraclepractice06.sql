create table stock(
    goodsnum char(6) not null primary key,
    goodsname varchar(50) not null,
    goodsprice number not null,
    stockcount number 
);

create table inputTable(
    inputnum char(6) not null primary key,
    goodsnum char(6) not null,
    inputcount number not null,
    inputdate varchar(10),
    CONSTRAINT pk_stock1 FOREIGN key(goodsnum)
    REFERENCES stock (goodsnum)
);

create table outputTable(
    outputnum char(6) not null primary key,
    goodsnum char(6) not null,
    outputcount number not null,
    outputdate varchar(10),
    CONSTRAINT  pk_stock2 foreign key (goodsnum)
    REFERENCES stock (goodsnum)
);

insert into stock values ('g00001', '목배개', 12000, 100);
insert into stock values ('g00002', '시계', 40000, 20);
insert into stock values ('g00003', '키링', 9000, 150);
insert into stock values ('g00004', '귀걸이', 15000, 120);
insert into stock values ('g00005', '스티커', 4000, 80);

select * from stock;

-- 4번
create or replace trigger inputtrigger
after insert on inputtable
for each row
declare newcount number;
begin
    
    update stock set stockcount = stockcount + :new.inputcount
    where goodsnum = :new.goodsnum;
end;

insert into inputtable values ('i10007', 'g00001', 40, sysdate);

-- 5번
create or replace trigger outputtrigger
after insert on outputtable
for each row
declare newcount number;
begin
    
    update stock set stockcount = stockcount - :new.outputcount
    where goodsnum = :new.goodsnum;
end;

insert into outputtable values ('i10007', 'g00001', 40, sysdate);
select * from stock;