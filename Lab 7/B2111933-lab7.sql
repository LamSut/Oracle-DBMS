SET TERMOUT OFF
SET ECHO OFF

rem CONGDON    Invoked in RDBMS at build time.	 29-DEC-1988
rem OATES:     Created: 16-Feb-83
CREATE USER B2111933 IDENTIFIED BY "swimngu";
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO B2111933 IDENTIFIED BY "swimngu";
ALTER USER B2111933 DEFAULT TABLESPACE USERS;
ALTER USER B2111933 TEMPORARY TABLESPACE TEMP;
CONNECT B2111933/"swimngu"


DROP TABLE DEPT;
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
DROP TABLE BONUS;
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

SET TERMOUT ON
SET ECHO ON
//
//Exercise 1:
DECLARE 
   CURSOR c_Emp IS 
   select * from emp
   where extract(year from sysdate) - extract(year from hiredate)>= 30 
    	and sal <=2000;  
BEGIN 
    FOR emp_rec IN c_Emp
    LOOP  
		if emp_rec.comm is null then     
 			emp_rec.comm:=500;
		else 
			emp_rec.comm:=emp_rec.comm+500;
		end if;
		UPDATE Emp 
		SET comm = emp_rec.comm
		WHERE empno = emp_rec.empno;
		INSERT INTO BONUS(ename, job, sal, comm) 
		VALUES (emp_rec.ename, emp_rec.job, emp_rec.sal, emp_rec.comm); 
    END LOOP; 
END;
//
//
//Exercise2//
//
CREATE TABLE  EMP_RETIRE(
 EMPNO   NUMBER(4) NOT NULL,
 ENAME   VARCHAR2(10),
 JOB     VARCHAR2(9),
 MGR     NUMBER(4),
 HIREDATE DATE,
 SAL      NUMBER(7,2),
 COMM     NUMBER(7,2),
 DEPTNO   NUMBER(2)   
);


DECLARE 
	CURSOR cEmpRetire IS
        Select * 
        From  emp
        where extract(year from sysdate) - 
              extract(year from hiredate) >= 43
        FOR UPDATE;
        A cEmpRetire%rowtype;
BEGIN
    Open cEmpRetire;
    LOOP
    FETCH cEmpRetire INTO A; 
    EXIT WHEN cEmpRetire%notfound;
		INSERT INTO Emp_Retire(Empno, EName, Job, Mgr, 
					Hiredate, Sal, Comm, Deptno)
        VALUES (A.Empno, A.EName, A.Job, A.Mgr, A.Hiredate, A.Sal, A.Comm, A.Deptno);
	    DELETE FROM Emp 
      		  WHERE CURRENT OF cEmpRetire;
 	END LOOP;
    COMMIT;
CLOSE cEmpRetire;
END;

