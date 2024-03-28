--Committing a Transaction--
INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES (1, 'Ramesh', 'Clerk', 6999, '17-DEC-90', 696, 0, 10); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (2, 'Khilan', 'Clerk', 6969, '27-DEC-91', 626, 0, 20 ); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES (3, 'kaushik', 'Manager', 7777, '17-SEP-90', 693, 0, 10 ); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES (4, 'Chaitali', 'Clerk', 699, '17-DEC-90', 333, 0, 30 ); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (5, 'Hardik', 'Clerk', 3399, '17-DEC-90', 222, 0, 30 ); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (6, 'Komal', 'Analyst', 6333, '17-DEC-90', 696, 200, 20 ); 

COMMIT;
//
--Roll back to save point--

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (7, 'LS', 'Boss', 999,'30-JAN-70', 9999, 999, 10); 

INSERT INTO EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (8, 'Hung Gay', 'Culi', 33,'30-JAN-70', 33, 3, 10); 
SAVEPOINT sav1;
  
UPDATE EMP 
SET SAL = SAL + 1000; 
ROLLBACK TO sav1;
  
UPDATE EMP
SET SAL = SAL + 1000 
WHERE EMPNO = 7; 
UPDATE EMP
SET SAL = SAL + 1000 
WHERE EMPNO = 8; 

COMMIT;
--
//
-- Transaction Control --
COMMIT;

SET TRANSACTION NAME 'sal_update';

UPDATE emp
    SET sal = 7000 
    WHERE ename = 'Hung Gay';

SAVEPOINT after_banda_sal;

UPDATE emp
    SET sal = 12000 
    WHERE ename = 'LS';

SAVEPOINT after_greene_sal;

ROLLBACK TO SAVEPOINT
    after_banda_sal;

UPDATE emp
    SET sal = 11000 
    WHERE ename = 'LS';

ROLLBACK;

SET TRANSACTION NAME 'sal_update2';

UPDATE emp
    SET sal = 7050 
    WHERE ename = 'LS';

UPDATE emp
    SET sal = 10950 
    WHERE ename = 'LS';

COMMIT;
//
--Enqueued Transactions--
UPDATE emp
  SET sal=7000 
  WHERE ename= 
  'LS';
 	 	
SAVEPOINT 
 after_banda_sal;

UPDATE emp 
 SET sal=12000 
 WHERE ename= 'LS';

            UPDATE emp 
             SET sal=14000 
             WHERE ename='LS';
 	
ROLLBACK
 TO SAVEPOINT 
 after_banda_sal;
 	
                    UPDATE emp
                    SET sal=11000
                    WHERE ename='LS';

COMMIT;