create user B2111933 identified by "1";
grant all privileges to B2111933;

drop table booking;
drop table tea;
drop table customer;

create table tea(
    idtea int primary key,
    typetea varchar2(20) check ( regexp_like(typetea, '(noi bat|milktea|macchiato|special|new|topping)')),
    nametea varchar2(30) not null,
    price int check (price > 0),
    bestseller varchar2(10) check ( regexp_like( bestseller, '(yes|no)'))
);

insert into tea values(1,'milktea','tra sua truyen thong',23000,'yes');
insert into tea values(2,'milktea','tra sua matcha',26000,'yes');
insert into tea values(3,'topping','ngoc trai',7000,'no');
insert into tea values(4,'topping','tran chau hoang kim',4000,'no');
insert into tea values(5,'special','sua utoi tran chau duong den',27000,'no');

select nametea from tea where bestseller = 'yes'; 

create table customer(
    idorder int primary key,	
    namecus varchar2(50) not null,
    phonecus varchar2(12) check ( regexp_like(phonecus, '^0[0-9]{8,10}') ),
    emailcus varchar2(50) not null,
    totalprice int default 0,
    bookday date default sysdate
);

insert into customer values(1,'Truong Dang Truc Lam','0907543817','lamsut0007@gmail.com',0,'20-DEC-22');
insert into customer values(2,'Lam Sut','0907543818','lambobby007@yahoo.com',0,sysdate);
insert into customer values(3,'Anti Moo Moo','0907543819','lambobby0007@yahoo.com',0,sysdate);
insert into customer values(4,'Truong Dang Truc Lam','0907543817','lamsut0007@gmail.com',0,sysdate);
insert into customer values(5,'Truong Dang Truc Lam','0907543817','lamsut0007@gmail.com',0,'21-DEC-22');

create table booking(
    idorder int references customer(idorder),
    idtea int references tea(idtea),
    quantity int check (quantity >= 0),
    sumprice int default 0
);
insert into booking values (3 , 1, 2, 46000);
insert into booking values (3 , 2, 2, 54000);
insert into booking values (3 , 3, 2, 14000);


-- 2 -- Bao gom tinh tong so tien cho tung mon (2 ly truyen thong 46k) va tong so tien cho ca hoa don ( 2 ly truyen thong + 1 ngoc trai 53k )
create or replace procedure startbooking (p_idorder int, p_idtea int, p_quantity int)
as p_sumprice int := 0;
begin
    select price into p_sumprice from tea where idtea = p_idtea;
    p_sumprice := p_sumprice*p_quantity;
    insert into booking values (p_idorder , p_idtea, p_quantity, p_sumprice);
    update customer set totalprice = totalprice + p_sumprice where idorder = p_idorder;
end;

execute startbooking(1,1,3);
execute startbooking(1,1,1);
execute startbooking(1,2,2);
execute startbooking(2,2,2);
execute startbooking(4,3,2);
select * from tea;
select * from customer;
select * from booking;

-- 3 --
create or replace function gettotal (p_idorder int)
    return varchar2
is
    res varchar2(300);
    temptotal int := 0;
begin
    select distinct customer.totalprice || ' vnd - Phone number: ' || customer.phonecus into res from booking inner join customer on 
    booking.idorder = customer.idorder where customer.idorder = p_idorder;
    return res;
end;

select gettotal(1) from dual;
select gettotal(2) from dual;
select gettotal(3) from dual; -- =0 do khong dung ham ex2