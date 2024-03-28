create user swim identified by "ngu";
grant all privileges to swim;

--

create table swim.game (
    gameid int,
    kda varchar(20),
    min int
);
alter table swim.game
add primary key (gameid);

--

create table swim.gamein4 as select swim.game.gameid from swim.game
alter table swim.gamein4
add gold int;
alter table swim.gamein4
add vision int;
alter table swim.gamein4
add damage int;
alter table swim.gamein4
add foreign key (gameid) references swim.game(gameid);

--

insert into swim.game
values (1, '0/10/2', 45);
insert into swim.game
values (2, '2/12/8', 40);
insert into swim.game
values (3, '5/6/0', 18);
insert into swim.game
values (4, '12/10/6', 42);
insert into swim.game
values (5, '1/17/3', 28);

--

insert into swim.gamein4
values (1, 4985, 9, 2124);
insert into swim.gamein4
values (2, 6954, 17, 5864);
insert into swim.gamein4
values (3, 5413, 6, 3215);
insert into swim.gamein4
values (4, 12678, 13, 8126);
insert into swim.gamein4
values (5, 4985, 10, 5133);