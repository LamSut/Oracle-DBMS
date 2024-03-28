--in sys--
create user moomoo identified by zanzu;
grant all privileges to moomoo;
--in created account--
create table CUAHANG(
    maCH int primary key,
    tench varchar2(50) not null,
    diachi varchar2(100) not null,
    Dthoai varchar2(15) check (regexp_like (Dthoai, '\d{13}'))
);
insert into CUAHANG values(1,'monkey','123','1234567890123');

create table NHANVIEN(
    Manv int primary key,
    mach int references cuahang(mach), 
    Tennv varchar2(50) not null,
    ngaysinh date not null
);

create table HOADON(
    sohd varchar2(6) primary key check (regexp_like (sohd, '\d{5}')),
    ngaylap date,
    manv int references NHANVIEN(manv),
    tongtien float check (tongtien>0)
);


create table HANGHOA(
    mahang int primary key,
    Tenhang varchar2(50) not null,
    donvitinh varchar2(20) not null,
    dongia float check (dongia>0)
);

create table CHITIETHD(
    sohd varchar2(6) references HOADON(sohd),
    mahang int references HANGHOA(mahang),
    soluong int check (soluong>0),
    dongiaban float check (dongiaban>0)
);
alter table CHITIETHD
add primary key (sohd, mahang);


alter table CUAHANG
add Email varchar2(50);

alter session set nls_date_format = 'DD-MM-YYYY'

insert into CUAHANG values(2,'dog','12345','6666567890123','dog@gmail.com');
insert into CUAHANG values(3,'cow','6798','3333567890123','cow@gmail.com');

insert into NHANVIEN values(1,'1','cho bo','24-12-2003');
insert into NHANVIEN values(2,'1','cho bo con','24-12-2004');
insert into NHANVIEN values(3,'2','cho khi','11-02-2003');

insert into HOADON values('00001','30/01/2022',1,3333.333);
insert into HOADON values('00301','28/02/2021',1,999999.11333);

insert into HANGHOA values(1,'co non','bo',10000);
insert into HANGHOA values(2,'thuc an cho cho','hop',80000);


insert into CHITIETHD values('00001',1,3,5000);
insert into CHITIETHD values('00001',2,5,450000);

--
--
--project--
create user pB2111933 identified by "LS";
grant all privileges to pB2111933;
--login project account--
create table gameacc(
    idacc int,
    nameacc varchar2(50),
    rankacc varchar2(20) not null,
    medal   varchar2(20),
    primary key (idacc, nameacc)
);

create table gamehistory(
    idgame int primary key,
    idacc int,
    nameacc varchar2(50),
    kda varchar2(13) check (regexp_like (kda, '\d{1,)/\d(1,)/\d(1,)')),
    mingame int not null,
    foreign key (idacc, nameacc) references gameacc(idacc, nameacc)
);

create table gamerank(
    idacc int,
    nameacc varchar2(50),
    points int check (points >= 0 and points <100),
    foreign key (idacc, nameacc) references gameacc(idacc, nameacc)
);