----admin table
create table admin_t(admin_id varchar2(10) constraint pk_admin_id primary key, admin_email varchar2(50) unique, 
admin_password varchar2(50));

CREATE SEQUENCE admin_id_seq;

CREATE OR REPLACE TRIGGER admin_tgr
    BEFORE INSERT
    ON admin_t
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.admin_id IS NULL THEN
        SELECT 'A'||TO_CHAR(admin_id_seq.NEXTVAL,'0000000') INTO :NEW.admin_id FROM DUAL;
    END IF;
END;

----user table
create table user_db(user_id varchar2(20) constraint pk_user_id primary key, username varchar2(50), 
user_email varchar2(50) unique, user_password varchar2(50), date_of_reg date, user_add varchar2(50), user_contact number(11));

CREATE SEQUENCE user_id_seq;

CREATE OR REPLACE TRIGGER user_tgr
    BEFORE INSERT
    ON user_db
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.user_id IS NULL THEN
        SELECT 'U'||TO_CHAR(user_id_seq.NEXTVAL,'0000000') INTO :NEW.user_id FROM DUAL;
    END IF;
END;
----category table
create table category_tb(category_id varchar2(20) constraint pk_category_id primary key,
                        category_name varchar2(50));
drop table category_tb;
CREATE SEQUENCE category_id_seq;

CREATE OR REPLACE TRIGGER cate_tgr
    BEFORE INSERT
    ON category_tb
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.category_id IS NULL THEN
        SELECT 'CAT'||TO_CHAR(category_id_seq.NEXTVAL,'0000000') INTO :NEW.category_id FROM DUAL;
    END IF;
END;
                        
 ---- coupon table                       
create table coupon_t(coupon_id varchar2(10) constraint pk_coupon_id primary key, coupon_name varchar2(50),
discount_val number(8,2), expiry_date date);

CREATE SEQUENCE coupon_id_seq;

CREATE OR REPLACE TRIGGER coup_tgr
    BEFORE INSERT
    ON coupon_t
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.coupon_id IS NULL THEN
        SELECT 'CO'||TO_CHAR(coupon_id_seq.NEXTVAL,'0000000') INTO :NEW.coupon_id FROM DUAL;
    END IF;
END;
---- product table
create table product_t(product_id varchar2(20) constraint pk_product_id primary key, product_name varchar2(50), 
category_id varchar2(20),
product_price number(8,2), product_img varchar2(50), product_available_qty number(10),
constraint fk_category_tb foreign key (category_id) references category_tb(category_id));

CREATE SEQUENCE product_id_seq;

CREATE OR REPLACE TRIGGER product_tgr
    BEFORE INSERT
    ON product_t
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.product_id IS NULL THEN
        SELECT 'P'||TO_CHAR(product_id_seq.NEXTVAL,'0000000') INTO :NEW.product_id FROM DUAL;
    END IF;
END;

---- cart table
create table cart_t(cart_id varchar2(10) constraint pk_cart_t primary key, user_id varchar(10), 
constraint fk_user_db foreign key (user_id) references user_db(user_id));

CREATE SEQUENCE cart_id_seq;

CREATE OR REPLACE TRIGGER cart_tgr
    BEFORE INSERT
    ON cart_t
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_id IS NULL THEN
        SELECT 'CA'||TO_CHAR(cart_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_id FROM DUAL;
    END IF;
END;
----cart items table
create table cart_items(cart_items_id varchar2(20) constraint pk_cart_items_id primary key, category_id varchar2(10),
user_id varchar2(10), product_id varchar2(10), product_qty varchar2(10),
constraint fk_category_tb1 foreign key (category_id) references category_tb(category_id),
constraint fk_user_db1 foreign key (user_id) references user_db(user_id),
constraint fk_product_t1 foreign key (product_id) references product_t(product_id));

CREATE SEQUENCE cart_items_id_seq;

CREATE OR REPLACE TRIGGER cart_items_tgr
    BEFORE INSERT
    ON cart_items
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_items_id IS NULL THEN
        SELECT 'CI'||TO_CHAR(cart_items_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_items_id FROM DUAL;
    END IF;
END;
----- order table
create table orders_t(order_id varchar2(20) constraint pk_order_id primary key ,cart_id varchar2(20) not null, 
user_id varchar2(20) not null, order_date date DEFAULT sysdate, delivery_date date default sysdate + 7,
coupon_id varchar2(20) not null, bill_amount number(12,2), payment_method varchar2(2),
                  constraint fk_cart_to_order foreign key (cart_id) references cart_t(cart_id), 
                  constraint fk_cust_to_order foreign key (user_id) references user_db(user_id), 
                  constraint fk_coupon_order foreign key (coupon_id) references coupon_t(coupon_id), 
                  constraint ck_pay_meth check(payment_method in ('COD', 'CREDIT', 'DEBIT', 'E-WALLET'))
);

CREATE SEQUENCE orders_id_seq;

CREATE OR REPLACE TRIGGER order_tgr
    BEFORE INSERT
    ON orders_t
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.order_id IS NULL THEN
        SELECT 'O'||TO_CHAR(orders_id_seq.NEXTVAL,'0000000') INTO :NEW.order_id FROM DUAL;
    END IF;
END;






