-- index
select department_id, emp_name from employees where department_id = 100;
-- * 대신 department_id를 쓰면 계획 설명에서 table access가 없다.
create index idx_employees_department_id on employees(department_id);

-- composit index
create index idx_employees2 on employees(department_id, emp_name);

drop index idx_employees_department_id;

--trigger
create table t_order(
    no number,
    ord_code varchar(10),
    ord_date date
);

-- before trigger
create or replace trigger tr_order
before insert on t_order --  t_order에서 insert가 발생하기 전에 실행
begin
-- 특정시간 18:40 ~ 18:50 에만 insert가 되도록 
    if (to_char(sysdate, 'HH24:MI') not between '18:40' and '18:50') then
        raise_application_error(-20100, '허용시간이 아닙니다');
    end if;
end;

commit;

insert into t_order values (1, '001', sysdate);

select * from t_order;

drop trigger tr_order;

set serveroutput on;
-- after trigger
create or replace trigger tr2
after delete on t_order
begin 
    dbms_output.put_line('트리거 tr2가 동작합니다');
end;

delete from t_order where no='002'; -- 트리거가 발생하기 위한 선행조건(이벤트)
drop trigger tr2;
-- 과제 관련 트리거
-- :now, :old사용하기
create or replace trigger tr3
after insert or delete or update on t_order
for each row -- :new, :old 사용하기 위해서 필요
begin
    dbms_output.put_line(:new.no || ',' || :new.ord_code || ',' || :new.ord_date);
    dbms_output.put_line(:old.no || ',' || :old.ord_code || ',' || :old.ord_date);
end;

insert into t_order values(9, '009', sysdate);
delete from t_order where no = 9;
update t_order set ord_code = '009' where no = 7;
select * from t_order;

-- 예외처리
declare vi_num number := 0;
begin
    vi_num := 10 / 0;
    dbms_output.put_line('Success!');
    
exception when others then
    dbms_output.put_line('오류가 발생했습니다!');
end;

-- Cursor
