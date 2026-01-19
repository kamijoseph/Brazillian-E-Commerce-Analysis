create database olist;
use olist;


-- customers table
create table customers (
	customer_id varchar(50) primary key,
    customer_unique_id varchar(50),
    customer_zip_code_prefix int,
    customer_city varchar(100),
    customer_state char(2)
);

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

-- sellers table
create table sellers (
	seller_id varchar(50) primary key,
    sellers_zip_code_prefix int,
    seller_city varchar(100),
    seller_state char(2)
);

-- payments table
create table payments (
	order_id varchar(50),
    payment_sequential int,
    payment_type varchar (30),
    payment_installments int,
    payment_value decimal(10, 2),
    primary key (order_id, payment_sequential)
);






















