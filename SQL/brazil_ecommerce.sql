create database olist;
use olist;
SET GLOBAL local_infile = 1;
show variables like "secure_file_priv";
SET foreign_key_checks = 0;

-- customers table
create table customers (
	customer_id varchar(50) primary key,
    customer_unique_id varchar(50),
    customer_zip_code_prefix int,
    customer_city varchar(100),
    customer_state char(2)
);
-- populating customers table
load data infile '/var/lib/mysql-files/customers.csv'
into table customers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);

select *
from customers;

-- orders table
create table orders (
	order_id varchar(50) primary key,
    customer_id varchar(50),
    order_status varchar(20),
    order_purchase_timestamp datetime,
    order_approved_at datetime,
    order_delivered_carrier_date datetime,
    order_delivered_customer_date datetime,
    order_estimated_delivery_date datetime,
    foreign key (customer_id) references customers(customer_id)
);
-- populating orders table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/orders.csv'
into table orders
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date);


-- order items table
create table order_items (
	order_id varchar(50),
    order_item_id int,
    product_id varchar(50),
    seller_id varchar(50),
    shipping_limit_date datetime,
    price decimal(10, 2),
    freight_value decimal(10, 2),
    primary key (order_id, order_item_id)
);
-- populating order items table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/order_items.csv'
into table order_items
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value);


-- products table
create table products (
	product_id varchar(50) primary key,
    product_category_name varchar(100),
    product_name_length int,
    product_description_length int,
    product_photos_qty int,
    product_weight_g int,
    product_length_cm int,
    product_height_cm int,
    product_width_cm int
);
-- populating prducts table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/products.csv'
into table products
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(product_id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm);

-- sellers table
create table sellers (
	seller_id varchar(50) primary key,
    sellers_zip_code_prefix int,
    seller_city varchar(100),
    seller_state char(2)
);
-- populating sellers table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/sellers.csv'
into table sellers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(seller_id, sellers_zip_code_prefix, seller_city, seller_state);

-- payments table
create table order_payments (
	order_id varchar(50),
    payment_sequential int,
    payment_type varchar (30),
    payment_installments int,
    payment_value decimal(10, 2),
    primary key (order_id, payment_sequential)
);
-- populating order payments table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/order_payments.csv'
into table order_payments
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(order_id, payment_sequential, payment_type, payment_installments, payment_value);

-- reviews table
create table order_reviews (
	review_id varchar(50) primary key,
    order_id varchar(50),
    review_score int,
    review_comment_title text,
    review_comment_message text,
    review_creation_date datetime,
    review_answer_timestamp datetime
);
-- populating order_reviews table
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/order_reviews.csv'
into table order_reviews
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp);


-- product category table
create table product_category (
    product_category_name VARCHAR(100) NOT NULL PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

-- populating product_category
LOAD DATA INFILE '/var/lib/mysql-files/product_category.csv'
INTO TABLE product_category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select *
from product_category;


-- geolocation tables
create table geolocation (
	geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(9,6),
    geolocation_lng DECIMAL(9,6),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
-- populating geolocation data
load data local infile '/home/kami/Projects/Olist Brazilian E-Commerce/data/geolocation.csv'
into table geolocation
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state);

show variables like 'local_infile';

select *
from order_payments;





















