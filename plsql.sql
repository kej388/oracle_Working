-- ����Ű
CREATE TABLE membertable (
    id     VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(50) NOT NULL
);

INSERT INTO membertable VALUES (
    'hkd',
    'ȫ�浿'
);

INSERT INTO membertable VALUES (
    'lss',
    '�̼���'
);

CREATE TABLE goodstable (
    gcode   CHAR(6) PRIMARY KEY,
    gname   VARCHAR(50) NOT NULL,
    price   NUMBER NOT NULL
);

INSERT INTO goodstable VALUES (
    'E00001',
    '����Ʈ��',
    1000000
);

INSERT INTO goodstable VALUES (
    'F00001',
    '�����',
    2000
);

CREATE TABLE ordertable (
    ono     CHAR(4) NOT NULL,
    id      VARCHAR(50) NOT NULL,
    gcode   CHAR(6) NOT NULL,
    ea      NUMBER NOT NULL,
    odate   DATE NOT NULL,
    CONSTRAINT pk_ordertable PRIMARY KEY ( ono,
                                           gcode )
);

DROP TABLE ordertable;

INSERT INTO ordertable VALUES (
    '0001',
    'hkd',
    'F00001',
    10,
    sysdate
);

INSERT INTO ordertable VALUES (
    '0001',
    'hkd',
    'E00001',
    10,
    sysdate
);

SELECT
    *
FROM
    ordertable;

-- �������̺�insert

CREATE TABLE ex7_3 (
    emp_id     NUMBER,
    emp_name   VARCHAR(100)
);

INSERT ALL INTO ex7_3 VALUES (
    emp_id,
    emp_name
) SELECT
      103 emp_id,
      '������' emp_name
  FROM
      dual
  UNION ALL
  SELECT
      104 emp_id,
      '�����ҹ�' emp_name
  FROM
      dual;

CREATE TABLE ex7_4 (
    emp_id     NUMBER,
    emp_name   VARCHAR(100)
);

INSERT
    ALL WHEN department_id = 30 THEN
        INTO ex7_3
        VALUES (
            employee_id,
            emp_name
        )
        WHEN department_id = 90 THEN
            INTO ex7_4
            VALUES (
                employee_id,
                emp_name
            )
SELECT
    department_id,
    employee_id,
    emp_name
FROM
    employees;

SELECT
    *
FROM
    ex7_3;

SELECT
    *
FROM
    ex7_4;

-- 8�� DML�� 267p

SET SERVEROUTPUT ON;

DECLARE 
   -- vs_emp_name varchar(80);    -- ����� ����
   -- vs_dep_name varchar(80);    -- �μ��� ����
    vs_emp_name   employees.emp_name%TYPE;
    vs_dep_name   departments.department_name%TYPE;
BEGIN
    SELECT
        a.emp_name,
        b.department_name
    INTO
        vs_emp_name,
        vs_dep_name
    FROM
        employees     a,
        departments   b
    WHERE
        a.department_id = b.department_id
        AND a.employee_id = 100;

    dbms_output.put_line(vs_emp_name
                         || ' - '
                         || vs_dep_name);
END;

-- 9�� if�� 275p

DECLARE
    vn_salary          NUMBER := 0;
    vn_department_id   NUMBER := 0;
BEGIN
    vn_department_id := round(dbms_random.value(10, 120), -1);
    SELECT
        salary
    INTO vn_salary
    FROM
        employees
    WHERE
        department_id = vn_department_id
        AND ROWNUM = 1;

    dbms_output.put_line(vn_salary);
    IF vn_salary BETWEEN 1 AND 3000 THEN
        dbms_output.put_line('����');
    ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
        dbms_output.put_line('�߰�');
    ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
        dbms_output.put_line('����');
    ELSE
        dbms_output.put_line('�ֻ���');
    END IF;

END;

SELECT DISTINCT
    department_id
FROM
    employees
ORDER BY
    department_id;

SELECT
    salary
FROM
    employees
WHERE
    department_id = 50
    AND ( ROWNUM = 1
          OR ROWNUM <= 5 );

-- case�� 278p
--case�� when ���̿� �ڵ�

DECLARE
    v_dname departments.department_name%TYPE;
BEGIN
    SELECT
        department_name
    INTO v_dname
    FROM
        departments
    WHERE
        department_id = 20;

    dbms_output.put_line(v_dname);
    CASE v_dname
        WHEN '�ѹ���ȹ��' THEN
            dbms_output.put_line('�ѹ���ȹ���Դϴ�.');
        WHEN '������' THEN
            dbms_output.put_line('�����ú��Դϴ�.');
    END CASE;

END;

-- for �� 281p

-- �Լ�ȣ�� 287p

CREATE OR REPLACE FUNCTION fn_get_country_name (
    p_country_id NUMBER
) RETURN VARCHAR IS
    vs_country_name countries.country_name%TYPE;
BEGIN
    SELECT
        country_name
    INTO vs_country_name
    FROM
        countries
    WHERE
        country_id = p_country_id;

    RETURN vs_country_name;
END;

SELECT
    fn_get_country_name(52777) coun1,
    fn_get_country_name(10000) coun2
FROM
    dual;

---
-- 1998�⿡ �Ǹŵ� �Ǽ��� �Ѱ�

SELECT
    COUNT(*)
FROM
    sales
WHERE
    substr(sales_month, 1, 4) = '1999';

SELECT
    *
FROM
    sales;

-- �������̺� ����    
create table yearCount(
    year char(4) primary key,
    counts number not null
);

--1. input�Ű������� �ִ� sp

CREATE OR REPLACE PROCEDURE proc1 ( 
    p_year CHAR 
)
is
    v_count number;
begin
    select count(*) into v_count
    from sales
    where substr(sales_month,1,4) = p_year;
    
     dbms_output.put_line(v_count);
     
     insert into yearcount values(p_year, v_count);
     commit;
end;

exec proc1('1998');
select * from yearCount;

-- 2. input, output�Ű������� �ִ� sp

CREATE OR REPLACE PROCEDURE proc2 ( 
    p_year CHAR ,
    p_count out number
)
is
    v_count number;
begin
    select count(*) into v_count
    from sales
    where substr(sales_month,1,4) = p_year;
    
     dbms_output.put_line(v_count);
     
     p_count := v_count; -- output�Ű������� ����. �ڵ����ϵ�
     
end;

declare
    r_count number; -- return ���� ���� ��������
begin 
    proc2('2000', r_count); --r_count������ ���ϰ��� �����
     dbms_output.put_line(r_count);
     
     insert into yearCount values('2000', r_count);
     commit;
end;

select * from yearCount;

create or replace procedure proc3(
    p_year char    
)
is
    r_count number; -- return ���� ���� ��������
begin 
    proc2(p_year, r_count); --r_count������ ���ϰ��� �����
     dbms_output.put_line(r_count);
     
     insert into yearCount values(p_year, r_count);
     commit;
end;

select * from yearCount;

exec proc3('2001');

-------------index
select * from employees
where department_id = 100;

select employee_id, rowid from employees;

