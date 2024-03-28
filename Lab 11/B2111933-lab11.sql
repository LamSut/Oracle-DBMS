alter user scott account unlock;
alter user scott identified by tiger;
--connect to Scott--

--1. Write a trigger to store who/when/whom deleted an employee (emp table). Test it--
create table del_log(
    delUser varchar2(60),
    delDate TIMESTAMP,
    empno number(4)
);

CREATE OR REPLACE TRIGGER del_trigger 
 AFTER DELETE ON emp 
 FOR EACH ROW
 BEGIN 
   insert into del_log values(user,sysdate,:old.empno);
 END; 

select * from emp;
delete from emp where empno=7369;
select * from del_log;
//

--2.  Write a trigger to trace who/when edited the “comm” of an employee in the emp table. Store old and new values.--
create table edit_comm_log(
    editUser varchar2(60),
    editDate TIMESTAMP,
    empno number(4),
    oldcomm number(7,2),
    newcomm number (7,2)
);

CREATE OR REPLACE TRIGGER edit_comm_trigger 
 AFTER UPDATE OF comm ON emp 
 FOR EACH ROW
 BEGIN 
   insert into edit_comm_log values(user,sysdate,:old.empno,:old.comm,:new.comm);
 END; 

select * from emp;
update emp set comm=696 where empno=7499;
select * from emp;
select * from edit_comm_log;