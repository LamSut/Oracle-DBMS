alter user scott account unlock;
alter user scott identified by tiger;
//
-- ex1 -- 
CREATE OR REPLACE PROCEDURE update_sal(psal number, pempno number)  
IS
BEGIN  
	update emp set sal=psal where empno=pempno;
END; 

select * from emp;
execute update_sal(1000, 7369);
//
-- ex2 -- 
CREATE OR REPLACE PROCEDURE update_sal_comm(psal number,pcomm number, pempno number)  
IS
BEGIN  
	update emp set sal=psal where empno=pempno;
    update emp set comm=pcomm where empno=pempno;
END; 

select * from emp;
execute update_sal_comm(1000,200,7369);
//
--ex3--
CREATE OR REPLACE PROCEDURE del_emp(pempno number)  
IS
BEGIN  
	delete from emp where empno=pempno;
END; 

select * from emp;
execute del_emp(7499);
//
--ex4--
CREATE OR REPLACE PROCEDURE add_emp 
    ( pempno number, 
    pename varchar2, 
    pjob varchar2, 
    pmgr number, 
    phiredate date, 
    psal number, 
    pcomm number, 
    pdeptno number )  
IS
BEGIN
	insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values (pempno, pename, pjob, pmgr, phiredate, psal, pcomm, pdeptno);  
END; 

select * from emp;
execute add_emp(7696, 'HUYHAO', 'COW', 1, '25-DEC-99', 1, 1, 10); 
//
--ex 5--
CREATE OR REPLACE PROCEDURE increase_sal (percentage number, pdeptno number)  
IS
BEGIN
    update emp set sal = sal + (sal*percentage/100) where deptno = pdeptno;
END;	

select * from emp;
execute increase_sal(20,30);
//
--ex6--
CREATE OR REPLACE FUNCTION total_sal (pdeptno number) 
	RETURN number  
IS  
    total_sal number :=0;
BEGIN  
	select sum(sal) into total_sal from emp where pdeptno = deptno;
	Return total_sal;  
END;

select total_sal(10) from dual;
//
--ex7--
desc SCOTT.emp;
CREATE OR REPLACE FUNCTION get_emp_name_job(p_empno IN NUMBER)
    RETURN VARCHAR2 
IS
    p_name_job VARCHAR2(40);
BEGIN
  SELECT ename || '-' || job INTO p_name_job FROM SCOTT.emp WHERE empno = p_empno;
  RETURN p_name_job;
END;

SELECT get_emp_name_job(7369) FROM dual;


