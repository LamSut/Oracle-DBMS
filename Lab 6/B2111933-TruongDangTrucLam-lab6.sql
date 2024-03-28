set serveroutput on;
declare 
    total_sales     number(15,2);
    emp_id          varchar2(9);
    company_number  number default 10;
begin
    total_sales     := 350000;
    emp_id          := 3;
    dbms_output.put_line('Employee ' || emp_id || 
                        ', sold total product value: '|| total_sales);
end; 

--
set serveroutput on;
declare 
    ten varchar2(10);
begin
    ten:= &Nhap_vao_ten_cua_ban;
    dbms_output.put_line ('chao ban ' || ten);
end;

--HR--
--
CREATE USER hr IDENTIFIED BY "&pass";

ALTER USER hr DEFAULT TABLESPACE &tbs
QUOTA UNLIMITED ON &tbs;

ALTER USER hr TEMPORARY TABLESPACE &ttbs;

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO hr;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO hr;

GRANT execute ON sys.dbms_stats TO hr;
--
--Login To HR--
/* Following after Step 1 & Step 2 in introduction */
set serveroutput on;
declare
    vEname employees.last_name%TYPE;
    vSalary employees.salary%TYPE;
begin
    select last_name,salary into vEname,vSalary
    from employees
    where employee_id=100;
    dbms_output.put_line('Name: ' ||vEname||'. Salary:'|| vSalary);
end;

--
set serveroutput on;
declare
    vEname employees.first_name%TYPE;
begin
    select first_name into vEname
    from employees
    where employee_id=120;
    
    if vEname='Matthew' then
        dbms_output.put_line('Hello' || vEname);
    else
         dbms_output.put_line('Hello' || vEname);
    end if;
end;

--
set serveroutput on;
declare
    vArea varchar2(20);
begin
    select region_id into vArea
    from countries
    where country_id='CA';
    case vArea
        when 1 then vArea:='Europe';
        when 2 then vArea:='America';
        when 3 then vArea:='Asia';
        else vArea:='Other';
    end case;
        dbms_output.put_line('The Area is ' || vArea);
end;

--
set serveroutput on;
declare
    counter number;
begin
    for counter in 1..4
    loop
        dbms_output.put_line(counter);
    end loop;
    dbms_output.new_line;
    for counter in reverse 1..4
    loop
        dbms_output.put(counter);
    end loop;
    dbms_output.new_line ;
end;
--

