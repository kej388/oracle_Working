-- index
select department_id, emp_name from employees where department_id = 100;
-- * ��� department_id�� ���� ��ȹ ������ table access�� ����.
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
before insert on t_order --  t_order���� insert�� �߻��ϱ� ���� ����
begin
-- Ư���ð� 18:40 ~ 18:50 ���� insert�� �ǵ��� 
    if (to_char(sysdate, 'HH24:MI') not between '18:40' and '18:50') then
        raise_application_error(-20100, '���ð��� �ƴմϴ�');
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
    dbms_output.put_line('Ʈ���� tr2�� �����մϴ�');
end;

delete from t_order where no='002'; -- Ʈ���Ű� �߻��ϱ� ���� ��������(�̺�Ʈ)
drop trigger tr2;
-- ���� ���� Ʈ����
-- :now, :old����ϱ�
create or replace trigger tr3
after insert or delete or update on t_order
for each row -- :new, :old ����ϱ� ���ؼ� �ʿ�
begin
    dbms_output.put_line(:new.no || ',' || :new.ord_code || ',' || :new.ord_date);
    dbms_output.put_line(:old.no || ',' || :old.ord_code || ',' || :old.ord_date);
end;

insert into t_order values(9, '009', sysdate);
delete from t_order where no = 9;
update t_order set ord_code = '009' where no = 7;
select * from t_order;

-- ����ó��
declare vi_num number := 0;
begin
    vi_num := 10 / 0;
    dbms_output.put_line('Success!');
    
exception when others then
    dbms_output.put_line('������ �߻��߽��ϴ�!');
end;

-- Cursor
