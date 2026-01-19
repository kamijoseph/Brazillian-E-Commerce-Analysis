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

-- order items
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






















