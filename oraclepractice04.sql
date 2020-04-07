-- 1번
create table dongari (
    dongariId char(5) not null,
    donariname varchar(20) not null
);

-- 2번
create table dongarienter (
    dongarinum number not null,
    id varchar(10) not null primary key,
    studentname varchar(20) not null,
    dongariId char(5)
);

drop table dongarienter;

-- insert dongari
insert into dongari values ('d0001', 'boardgame');
insert into dongari values ('d0002', 'library');
insert into dongari values ('d0003', 'cook');
insert into dongari values ('d0004', 'baseball');

-- insert dongarienter
insert into dongarienter values (1, '20160001', '홍길동', 'd0001');
insert into dongarienter values (2, '20162233', '이순신', 'd0001');
insert into dongarienter values (3, '20161245', '왕건', null);
insert into dongarienter values (4, '20160001', '홍길동', 'd0003');
insert into dongarienter values (5, '20162233', '이순신', 'd0002');

-- 3번
select d.donariname, da.studentname, da.studentid
from dongari d
inner join dongarienter da
    on(d.dongariid = da.dongariId)
where da.dongariid is not null;

-- 4번
select studentname
from dongarienter
where dongariid is null;

select * from dongarienter;
-- 5번
select donariname
from dongari 
where dongariid not in(select DISTINCT d.dongariid
                        from dongari d, dongarienter f
                        where d.dongariid = f.dongariid);

-- 6번
create table book (
    bid varchar(10) not null primary key,
    title varchar(20) not null
);

insert into book values('0001', '자바');
insert into book values('0002', 'Oracle');
insert into book values('0003', 'HTML');
insert into book values('0004', 'JSP');

-- 7번
create table bookrent(
    no number not null primary key,
    id varchar(10) not null,
    bid varchar(10) not null,
    rdate date,
    constraint book_pk foreign key (bid)
    references book(bid),
    constraint student foreign key (id)
    references dongarienter(id)
);
drop table bookrent;

-- 8번
insert into bookrent values (1, '20160001', '0001', '2016-12-01');
insert into bookrent values (2, '20162233', '0002', '2016-12-02');

-- 9번
select br.id, da.studentname, b.title, br.rdate
from bookrent br, dongarienter da, book b
where br.id = da.id
and br.bid = b.bid;

-- 10번
select title
from book
where bid not in (select DISTINCT a.bid
                  from book a, bookrent b
                  where a.bid = b.bid);