----insert into admin
insert into admin_t( admin_email, admin_password)  values('joerenu@gmail.com', '12345');

----insert into users
select * from user_db;
insert into user_db( username, user_email, user_password,date_of_reg,user_add,user_contact) 
values('Nina', 'Nkosaka@gmail','12345', sysdate,'japan',096754);

----categories
INSERT INTO category_tb (category_name) VALUES ('Hardware');
select * from category_tb;

----products
select * from product_t;
INSERT INTO product_t (
    product_name,
    category_id,
    product_price,
    product_img,
    product_available_qty
) VALUES (
    'Screw Driver',
    'CAT 0000013',
    200.00,
    'SD.jpg',
    39
);