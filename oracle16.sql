create table bookRentTest (
    no number primary key,
    id varchar(10) not null,
    title varchar(10) not null,
    rDate date not null
);

insert into bookrenttest values (1,  'hkd', '����Ŭ����', sysdate);

select * from bookrenttest;

-- �������̺�
create table countrent(
   rdate char(10) primary key,
   rcount number not null
);

drop table countrent;

create or replace procedure rCount_proc
as
begin
insert into countrent
    select to_char(rdate, 'YYYY-MM-DD') as rdate, count(*) as rcount
    from bookrenttest
    where to_char(rdate, 'YYYY-MM-DD') = to_char(sysdate, 'YYYY-MM-DD')
    group by to_char(rdate, 'YYYY-MM-DD');
    
    commit;
end;

select * from countrent;

-- ��������

BEGIN
    DBMS_SCHEDULER.create_job (
        job_name            => 'rCountJob',
        job_type            => 'STORED_PROCEDURE',
        job_action          => 'rCount_proc',
        repeat_interval     => 'FREQ=DAILY; BYHOUR=11',
        comments            => '������������');
end;
-- ��Ȱ��ȭ
begin
    DBMS_SCHEDULER.enable('rCountJob');
end;

delete from bookrenttest;
commit;

select * from bookrenttest;
    