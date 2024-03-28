create user B2111933 identified by "1";
grant all privileges to B2111933;
--login to B2111933--
//
drop table car_info;
drop table car_details;
drop table car_price;
--1--

create table car_info(
    car_company varchar2(20),
    car_series varchar2(20),
    car_ver varchar2(30),
    primary key(car_company, car_series, car_ver)
);

create table car_details(
    car_company varchar2(20),
    car_series varchar2(20),
    car_ver varchar2(30),
    car_type varchar2(30) not null,
    car_engine varchar2(20) not null,
    constraint foreign1 foreign key (car_company, car_series, car_ver) references car_info(car_company, car_series, car_ver)
);

create table car_price(
    car_company varchar2(20),
    car_series varchar2(20),
    car_ver varchar2(30),
    car_listed_price number not null,
    car_real_price number not null,
    constraint foreign2 foreign key (car_company, car_series, car_ver) references car_info(car_company, car_series, car_ver)
);
//
--2--
CREATE OR REPLACE PROCEDURE add_car 
    (   pcar_company varchar2,
        pcar_series varchar2, 
        pcar_ver varchar2,
        pcar_type varchar2,
        pcar_engine varchar2,
        pcar_listed_price number, 
        pcar_real_price number
    )  
IS
BEGIN
    insert into car_info(car_company, car_series, car_ver) values (pcar_company, pcar_series, pcar_ver);
    insert into car_details(car_company, car_series, car_ver, car_type, car_engine) values (pcar_company, pcar_series, pcar_ver, pcar_type, pcar_engine);
    insert into car_price(car_company, car_series, car_ver, car_listed_price, car_real_price) values (pcar_company, pcar_series, pcar_ver, pcar_listed_price, pcar_real_price);
END; 
//
--3--
select * from car_price;
execute add_car('Nissan','Navara 2022', 'EL 2WD','Ban tai co trung','YS23 DDTT', 699000000, 752165000);
execute add_car('Nissan', 'Navara 2022', '4WD Cao cap','Ban tai co trung', 'YS23 DDTT', 945000000, 1015877000);
execute add_car('Nissan', 'Navara 2022', 'PRO4X','Ban tai co trung', 'YS23 DDTT', 970000000, 1042677000);
execute add_car('Mercedes', 'A-class 2021', 'A 35 AMG 4MATIC Sedan','Xe sang c? nh?', 'I4 2.0', 2429000000, 2742817000);
//
--4--
CREATE OR REPLACE PROCEDURE update_price 
    (   pcar_company varchar2,
        pcar_series varchar2, 
        pcar_ver varchar2,
        pcar_listed_price number, 
        pcar_real_price number
    )  
IS
BEGIN
    update car_price set car_listed_price = pcar_listed_price, car_real_price = pcar_real_price
        where car_company = pcar_company and car_series = pcar_series and car_ver = pcar_ver;
END; 

select * from car_price;
execute update_price('Nissan','Navara 2022', 'EL 2WD', 1, 1);
//
--5--
CREATE OR REPLACE FUNCTION real_price (pcar_company varchar2, pcar_series varchar2, pcar_ver varchar2) 
	RETURN number  
IS  
    presult number :=0;
BEGIN  
	select car_real_price into presult from car_price where car_company = pcar_company and car_series = pcar_series and car_ver = pcar_ver;
	return presult;  
END;

select real_price('Nissan','Navara 2022', 'EL 2WD') from dual;
//
--6--
CREATE OR REPLACE FUNCTION car_most
	RETURN varchar2  
IS  
    presult varchar2(50);
BEGIN  
	SELECT car_company || ' - ' || car_ver INTO presult FROM car_price WHERE 
        car_real_price = ( select max(car_real_price) from car_price);
	return presult;  
END;

select car_most from dual;
//
--7--
CREATE OR REPLACE PROCEDURE del_car(pcar_company varchar2, pcar_series varchar2, pcar_ver varchar2)  
IS
BEGIN  
    delete from car_details where car_company = pcar_company and car_series = pcar_series and car_ver = pcar_ver;
    delete from car_price where car_company = pcar_company and car_series = pcar_series and car_ver = pcar_ver;
    delete from car_info where car_company = pcar_company and car_series = pcar_series and car_ver = pcar_ver;
END; 

execute add_car('moo','moo', 'moo','moo','moo', 69, 96);
select * from car_info;
execute del_car('moo','moo', 'moo');
//
--8--