drop table booking;
drop table airline;
drop table customer;



drop table airline;
create table airline(
    idchuyen int primary key,
    loai varchar2(20) not null check ( regexp_like(loai, '(khu hoi|mot chieu)')),
    diemdi varchar2(20) not null,
    diemden varchar2(20) not null,
    ngaydi date not null,
    ngayve date,
    giadi int check (giadi>0),
    thuedi int check (thuedi>0),  
    giave int check (giave>=0),
    thueve int check (thueve>=0)
);

insert into airline values(1,'khu hoi','Ha Noi','Can Tho','30-JAN-24','2-FEB-24',50000,100000,60000,120000);
insert into airline values(2,'mot chieu','Ha Noi','Can Tho','29-JAN-24','',40000,100000,0,0);


drop table customer;
create table customer(
    idkhach int primary key,
    gioitinh int, -- 1 la Nam, 0 la Nu --
    ho varchar2(15) not null,
    ten varchar2(40) not null,
    ngaysinh date not null,
    quocgia varchar2(20) not null,
    diachi varchar2(40),
    tinh varchar2(20),
    quoctich varchar2(20),
    mail varchar2(50) unique not null,
    phone1 varchar2(11) unique check ( regexp_like(phone1, '^0[0-9]{8,10}') ),
    phone2 varchar2(11) unique check ( regexp_like(phone2, '^0[0-9]{8,10}') ),
    code varchar2(14) unique check ( regexp_like(code, '[0-9]{12}') ),
    checkyes int -- 0 la khong, 1 la co --
);
insert into customer values(1,1,'Truong','Dang Truc Lam','30-JAN-03','VN','169','Can Tho','VN','lamb2111933@student.ctu.edu.vn','0907543817','0907543818','111111111111',0);
insert into customer values(2,1,'Truong','Thanh Tung','30-JAN-67','VN','169','Can Tho','VN','lambobby007@student.ctu.edu.vn','0907543819','0907543820','111111111110',0);

drop table booking;
create table booking(
    idve int primary key,
    idkhach int references customer(idkhach),
    idchuyen int references airline(idchuyen),
    songuoilon int check (songuoilon >= 0),
    sotre1 int check (sotre1 >= 0),
    sotre2 int check (sotre2 >= 0),
    propass int
);

insert into booking values (1,1,1,1,0,0,111111111111);
insert into booking values (2,2,2,1,1,0,111111111111);

-- 2 --
create or replace procedure bookingticket (p_idve int, p_idkhach int, p_idchuyen int, p_songuoilon int, p_sotre1 int, p_sotre2 int, p_propass int)
is
begin
    insert into booking values (p_idve , p_idkhach , p_idchuyen, p_songuoilon , p_sotre1 , p_sotre2 , p_propass );
end;

execute bookingticket(1,1,1,1,0,0,111111111111);
select * from booking;

-- 3 --
create or replace function searchtour (p_diemdi varchar2, p_diemden varchar2, p_ngaydi date, p_ngayve date)
    return varchar2
is
    res varchar2(200);
begin
    select idchuyen || '-' || loai || '-' || diemdi || '-' || diemden || '-' || ngaydi || '-' || ngayve || '-' || idchuyen || '-' || giadi || '-' || thuedi || '-' || giave || '-' ||
    thueve into res from airline where diemdi=p_diemdi and diemden=p_diemden and ngaydi=p_ngaydi and ngayve=p_ngayve;
    return res;
end;

select searchtour('Ha Noi','Can Tho','30-JAN-24','2-FEB-24') from dual;
