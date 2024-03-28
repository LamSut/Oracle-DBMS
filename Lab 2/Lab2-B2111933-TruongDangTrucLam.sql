CREATE USER Test1 IDENTIFIED BY Test1;
--
GRANT CREATE SESSION TO Test1;
--
ALTER USER Test1 IDENTIFIED BY pTest1;
--
GRANT CREATE TABLE, CREATE USER, CREATE SESSION TO Test1 WITH ADMIN OPTION;
--
ALTER USER Test1 default tablespace users quota 2M on users;
--
CREATE USER your_own IDENTIFIED BY your_own;
GRANT ALL PRIVILEGES TO your_own;
--
--
--
--
--
/* Test1 */
--
CREATE TABLE Students(
StudentID char(7) PRIMARY KEY,
		StudentName Varchar2(30)
);
--
INSERT INTO Students VALUES('1940000','Phung Phung Phi');
INSERT INTO Students VALUES('1940001','Tao Tung Thieu');
SELECT * FROM STUDENTS;
--
--
--
CREATE USER Test2 IDENTIFIED BY Test2
DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;
--
GRANT CREATE SESSION TO Test2;
--
GRANT CREATE TABLE TO Test2 WITH ADMIN OPTION
--
--
--
CREATE TABLE Teachers(
    TeacherID char(7) PRIMARY KEY,
    TeacherName Varchar2(30)
);
--
--
--
GRANT SELECT, UPDATE ON students TO Test2 WITH GRANT OPTION;
--
REVOKE SELECT, UPDATE ON Students FROM Test2;
--
--
--
--
/* Test2 */
--
CREATE TABLE Products(	PID char(3) PRIMARY KEY,
						PName Varchar2(30));
INSERT INTO Products VALUES('P01','Kem Danh Rang P/S');
INSERT INTO Products VALUES('P02','Khan Giay Puppy');
SELECT * FROM PRODUCTS;
--
CREATE TABLE Products1(	PID1 char(3) PRIMARY KEY,
						PName1 Varchar2(30));
--
--
--
SELECT * FROM Test1.Students;
--
DELETE FROM Test1.Students;
--
GRANT SELECT, UPDATE ON Test1.students TO Test3;
--
GRANT DELETE ON Test1.students TO Test3;
--
--
--
--
/*Test 3*/
--
UPDATE Test1.Students SET studentname='blablabla' WHERE studentid='1940001';
SELECT * FROM Test1.Students;
--
--
--
--
/* your_own */
--
REVOKE CREATE TABLE FROM Test1;
--
CREATE USER Test3 IDENTIFIED BY Test3
DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;
--
GRANT CREATE SESSION TO Test3;
--
GRANT CREATE TABLE TO Test3 WITH ADMIN OPTION
--
--
--
--
/* Role Management */
--
CREATE USER user1 IDENTIFIED BY user1 
	DEFAULT TABLESPACE USERS QUOTA 1M ON USERS;
CREATE USER user2 IDENTIFIED BY user2 
	DEFAULT TABLESPACE USERS QUOTA 1M ON USERS;
--
CREATE ROLE TTOracle;
--
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE TRIGGER TO TTOracle;
--
GRANT TTOracle TO user1,user2;
--
REVOKE TTOracle FROM user1;
//
//
//
//
/* user1 */
//
create table monkey(
    name char(10)
);
create table dog(
    name char(10)
);
//
//
//
//
/* user2 */
//
create table monkey(
    name char(10)
);
//
//
//
//











