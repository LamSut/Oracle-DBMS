--project--
create user pB2111933 identified by "LS";
grant all privileges to pB2111933;
--login project account--

/* 
This is 'game database management'
*/

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

drop table medalsLOL;
drop table statsLOL;
drop table rankLOL;
drop table historyLOL;
drop table infoLOL;

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


