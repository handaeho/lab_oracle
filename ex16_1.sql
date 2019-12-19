-- EX1
create table customers ( customers_id VARCHAR2(20) primary key, 
                                    customers_pw varchar2(20) not null,
                                    customers_email varchar2(100),
                                    customers_gender number(1),
                                    customers_age number(3) DEFAULT 0,
                                    CONSTRAINT id CHECK (lengthb(customers_id) >= 8),
                                    CONSTRAINT pw CHECK (lengthb(customers_pw) >= 8),
                                    CONSTRAINT gender check (customers_gender in (0 ,1, 2)),
                                    CONSTRAINT age check (customers_age between 0 and 200));
                                    
desc customers;
--------------------------------------------------------------------------------------------------------------
-- EX2
create table orders ( order_id number(12) PRIMARY KEY,
                             order_date date DEFAULT sysdate,
                             order_method varchar2(8),
                             customer_id number(6),
                             order_status number(2) DEFAULT 0,
                             sales_rep_id number(6),
                             CONSTRAINT method check (order_method in ('direct', 'online')));

desc orders;
--------------------------------------------------------------------------------------------------------------
-- EX3
create table order_items ( order_id number(12),
                                    product_id number(10),
                                    quantity number(4) DEFAULT 0,
                                    price number(10),
                                    CONSTRAINT pk_order PRIMARY KEY(order_id, product_id));

desc order_items;     
--------------------------------------------------------------------------------------------------------------
select * from customers;
select * from orders;
select * from order_items;
--------------------------------------------------------------------------------------------------------------
insert into customers (customers_id, customers_pw)
VALUES ('admin0000', 'admin1234');
--------------------------------------------------------------------------------------------------------------
insert into customers (customers_id, customers_pw, customers_gender)
VALUES ('######78', 'pw123456', 0.5);
--------------------------------------------------------------------------------------------------------------
update customers 
set customers_gender = 2 
where customers_gender is null;
--------------------------------------------------------------------------------------------------------------
insert into orders(order_id)
VALUES (100000);
--------------------------------------------------------------------------------------------------------------
insert into orders(order_id, customer_id)
VALUES (100001, 123456);
--------------------------------------------------------------------------------------------------------------
update orders
set sales_rep_id = 100
where sales_rep_id is null;
--------------------------------------------------------------------------------------------------------------
insert into order_items
VALUES (100000, 1, 2, 1000);
--------------------------------------------------------------------------------------------------------------
insert into order_items
VALUES (100001, 123, 10, 10000);