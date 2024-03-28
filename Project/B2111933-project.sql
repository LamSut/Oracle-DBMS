B2111933-project.sql
--project--
create user pB2111933 identified by "LS";
grant all privileges to pB2111933;
--login project account--

/* 
This is 'game database management'
*/
drop table medalsLOL;
drop table statsLOL;
drop table rankLOL;
drop table historyLOL;
drop table infoLOL;
--create tables
ALTER SESSION SET nls_date_format='dd-mm-yyyy';

create table infoLOL(
    idacc int primary key,
    nameacc varchar2(50) unique,
    joined date not null,
    region varchar2(13) not null check (regexp_like (region, '(NA|EUW|EUNE|BR|TR|RU|LAN|LAS|OCE|JP|SEA)'))
);

create table historyLOL(
    idacc int,
    idgame int primary key,
    kda varchar2(13) check (regexp_like (kda, '\d{1,}/\d{1,}/\d{1,}')),
    timegame int not null,
    foreign key (idacc) references infoLOL(idacc)
);

create table rankLOL(
    idacc int,
    season int check (season >=2015 and season <= 2023),
    rankacc varchar2(20) check (regexp_like (rankacc, '(Challenger|GrandMaster|Master|Diamond [1-4]|Platinum [1-4]|Gold [1-4]|Silver [1-4]|Bronze [1-4]|Iron [1-4]|Unranked)')),
    points int check (points >= 0),
    foreign key (idacc) references infoLOL(idacc),
    constraint elite check ( points <100 or (rankacc='Challenger' or rankacc='GrandMaster' or rankacc='Master'))
);

create table statsLOL(
    idacc int,
    season int check (season >=2015 and season <= 2023),
    combat varchar2(3) check (regexp_like (combat, '(S+|S|S-|A+|A|A-|B+|B|B-|C+|C|C-|D)')),
    income varchar2(3) check (regexp_like (income, '(S+|S|S-|A+|A|A-|B+|B|B-|C+|C|C-|D)')),
    teamplay varchar2(3) check (regexp_like (teamplay, '(S+|S|S-|A+|A|A-|B+|B|B-|C+|C|C-|D)')),
    foreign key (idacc) references infoLOL(idacc)
);

create table medalsLOL(
    idacc int,
    medal1 varchar(20),
    medal2 varchar(20),
    medal3 varchar(20),
    foreign key (idacc) references infoLOL(idacc)
);

--insert rows
insert into infoLOL values(1,'LS','06-09-2017','SEA');
insert into infoLOL values(2,'monkey','06-09-2017','NA');
insert into infoLOL values(3,'dog','01-01-2020','OCE');
insert into infoLOL values(4,'cow','02-03-2019','SEA');
insert into infoLOL values(5,'swim','04-07-2015','SEA');

insert into historyLOL values(4,001,'3/10/0',28);
insert into historyLOL values(4,002,'8/21/2',45);
insert into historyLOL values(5,003,'4/9/1',15);
insert into historyLOL values(1,006,'20/1/16',40);
insert into historyLOL values(2,007,'3/4/8',60);
insert into historyLOL values(3,008,'2/5/3',20);

insert into rankLOL values(5,2023,'Iron 2',99);
insert into rankLOL values(1,2021,'Master',111);
insert into rankLOL values(4,2023,'Silver 4',99);
insert into rankLOL values(5,2022,'Bronze 3',69);
insert into rankLOL values(3,2023,'Unranked',0);
insert into rankLOL values(2,2023,'Gold 4',1);

insert into statsLOL values(1,2023,'S','S-','S');
insert into statsLOL values(2,2023,'B+','A','B');
insert into statsLOL values(3,2023,'B','B-','B');
insert into statsLOL values(4,2023,'D','B','C+');
insert into statsLOL values(5,2023,'C','B-','B-');

insert into medalsLOL values(1,'monkey killer','cow killer','dog killer');
insert into medalsLOL values(2,'siuuuu ngau','only farm','y kien y co');
insert into medalsLOL values(3,'sigai','bo game','newbie');
insert into medalsLOL values(4,'ngok nghek','tuong minh dang iu','4v5');
insert into medalsLOL values(5,'ngoo','hen','de tien');


-- grant privilleges to users:
CREATE USER test1 IDENTIFIED BY test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON infoLOL TO test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON historyLOL TO test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON rankLOL TO test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON statsLOL TO test1;
GRANT SELECT, INSERT, UPDATE, DELETE ON medalsLOL TO test1;

CREATE USER test2 IDENTIFIED BY test2;
GRANT SELECT, UPDATE ON infoLOL TO test2;
GRANT SELECT, UPDATE ON historyLOL TO test2;
GRANT SELECT, UPDATE ON rankLOL TO test2;
GRANT SELECT, UPDATE ON statsLOL TO test2;
GRANT SELECT, UPDATE ON medalsLOL TO test2;

CREATE USER test3 IDENTIFIED BY test3;
GRANT ALL PRIVILEGES ON infoLOL TO test3;
GRANT ALL PRIVILEGES ON historyLOL TO test3;
GRANT ALL PRIVILEGES ON rankLOL TO test3;
GRANT ALL PRIVILEGES ON statsLOL TO test3;
GRANT ALL PRIVILEGES ON medalsLOL TO test3;
//

--Procedure--

--delete user--
CREATE OR REPLACE PROCEDURE del_user(pIDACC number)  
IS
BEGIN  
	delete from statslol where IDACC=pIDACC;
    delete from medalslol where IDACC=pIDACC;
    delete from ranklol where IDACC=pIDACC;
    delete from historylol where IDACC=pIDACC;
    delete from infolol where IDACC=pIDACC;
END; 

select * from infolol;
execute del_user(4);
//

--add user--
CREATE OR REPLACE PROCEDURE add_user(pIDACC number, pnameacc varchar2, pregion varchar2)  
IS
	seas number;
BEGIN  
	SELECT EXTRACT(YEAR FROM sysdate) into seas; 
	insert into infoLOL values(pIDACC, pnameacc, sysdate, pregion);
	insert into rankLOL values(3,seas,'Unranked',0);
END; 

//

--add match--
CREATE OR REPLACE PROCEDURE add_match(pIDACC number, pidgame number, pkda varchar2, pmin number)  
IS
BEGIN  
	insert into historyLOL values(pidacc,pidgame,pkda,pmin);
END; 

//
--
//
--Trigger--

--1. Delete User--
create table del_log(
    delUser varchar2(60),
    delDate TIMESTAMP,
    IDACC number(38,0)
);

CREATE OR REPLACE TRIGGER del_trigger 
 AFTER DELETE ON infolol
 FOR EACH ROW
 BEGIN 
   insert into del_log values(user,sysdate,:old.IDACC);
 END; 

select * from infolol;
execute del_user(4);
select * from del_log;
//

--update name--
create table name_log(
    editUser varchar2(60),
    editDate TIMESTAMP,
    IDACC number(38,0),
    oldname varchar2(50),
    newname varchar2(50)
);

CREATE OR REPLACE TRIGGER name_trigger 
 AFTER UPDATE OF nameacc on infolol 
 FOR EACH ROW
 BEGIN 
   insert into name_log values(user,sysdate,:old.IDACC,:old.nameacc,:new.nameacc);
 END; 

select * from infolol;
update infolol set nameacc='swim ngu' where idacc=5;
select * from infolol;
select * from name_log;
//

--update rank--
drop table rank_log;

create table rank_log(
    editUser varchar2(60),
    editDate TIMESTAMP,
    IDACC number(38,0),
    season number(38,0),
    oldrank varchar2(20),
    newrank varchar2(20),
    oldpoints number(38,0),
    newpoints number(38,0)
);

CREATE OR REPLACE TRIGGER rank_trigger 
 AFTER UPDATE OF rankacc, points on ranklol 
 FOR EACH ROW
 BEGIN 
   insert into rank_log values(user,sysdate,:old.IDACC,:old.season,:old.rankacc,:new.rankacc,:old.points,:new.points);
 END; 

select * from ranklol;
update ranklol set rankacc='Iron 1', points=0 where idacc=5 and season=2023;
select * from rabklol;
select * from rank_log;