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
set global local_infile = 1;

-- 1. total number of unique customers by year
select
	year(o.order_purchase_timestamp) as year,
    count(distinct c.customer_unique_id) as unique_customers
from orders o
join customers c
	on o.customer_id = c.customer_id
group by year
order by year desc;

-- 2. total orders per month for the last 3 years
select
	date_format(order_purchase_timestamp, "%Y-%m") as yearmonth,
    count(*) as total_orders
from orders
where order_purchase_timestamp >= date_sub(
	(select max(order_purchase_timestamp) from orders),
    interval 3 year
)
group by yearmonth
order by yearmonth;

-- 3. average number of orders per customer
select 
	round(count(o.order_id) / count(distinct c.customer_unique_id), 2)
    as avg_orders_per_customer
from orders o
join customers c
	on o.customer_id = c.customer_id
;

-- 4 top 10 customers by total spending
select
	c.customer_unique_id,
    sum(p.payment_value) as total_spent
from customers c
join orders o
	on c.customer_id = o.customer_id
join order_payments p
	on o.order_id = p.order_id
group by c.customer_unique_id
order by total_spent desc
limit 10;

-- 5. percentage of customers who made repeat purchase
with customer_orders as (
	select
		c.customer_unique_id,
        count(o.order_id) as order_count
	from customers c
    join orders o
		on c.customer_id = o.customer_id
	group by c.customer_unique_id
)
select
	round(
		100 * sum(order_count > 1) / count(*),
        2
    ) as repeat_customer_percentage
from customer_orders;

-- 6. distributions of orders by day of the week
select
	dayname(order_purchase_timestamp) as weekday,
    count(*) as total_orders
from orders
group by weekday
order by total_orders desc;

-- 7. median order value by month: no median so we use window function
with order_values as (
	select
		o.order_id,
        date_format(o.order_purchase_timestamp, '%Y-%m') as yearmonth,
        sum(p.payment_value) as order_value
	from orders o
    join order_payments p
		on o.order_id = p.order_id
	group by o.order_id, yearmonth
),
ranked as (
	select
		yearmonth,
        order_value,
        row_number() over (partition by yearmonth order by order_value) as rn,
        count(*) over (partition by yearmonth) as cnt
	from order_values
)
select
	yearmonth,
    avg(order_value) as median_order_value
from ranked
where rn in (floor((cnt + 1) / 2), floor((cnt + 2) / 2))
group by yearmonth
order by yearmonth;

-- 8. orders with the highest number of items
select
	order_id,
    count(*) as total_items
from order_items
group by order_id
order by total_items desc
limit 10;

-- 9. orders with zero or negative shipping delay
select
	order_id,
    datediff(
		order_delivered_customer_date,
        order_estimated_delivery_date
    ) as delivery_delay_dates
from orders
where
	order_delivered_customer_date is not null
    and order_estimated_delivery_date is not null
    and datediff(
		order_delivered_customer_date,
        order_estimated_delivery_date
    ) <= 0;
    
-- 10. top 10 products by total sales value
select
	p.product_id,
    sum(oi.price + oi.freight_value) as total_sales
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_id
order by total_sales desc
limit 10;

-- 11. top 10 product categories by number of orders
select
	p.product_category_name,
    count(distinct oi.order_id) as num_orders
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by num_orders desc
limit 10;

-- 12. average price per category
select
p.product_category_name,
    round(avg(oi.price), 2) as avg_price
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by avg_price desc;

-- 13. percentage of total sales contributed by each category
with category_sales as (
	select
		p.product_category_name,
        sum(oi.price + oi.freight_value) as category_total
	from order_items oi
    join products p
		on oi.product_id = p.product_id
        group by p.product_category_name
),
total_sales as (
	select
		sum(category_total) as grand_total from category_sales
)
select
	c.product_category_name,
    c.category_total,
    round(100 * c.category_total / t.grand_total, 2) as pct_total_sales
from category_sales c
cross join total_sales t
order by pct_total_sales;

-- 14. sales trend per category over time
select
	date_format(o.order_purchase_timestamp, "%Y-%m") as yearmonth,
    p.product_category_name,
    sum(oi.price + oi.freight_value) as monthly_sales
from order_items oi
join orders o
	on oi.order_id = o.order_id
join products p
	on oi.product_id = p.product_id
group by yearmonth, p.product_category_name
order by yearmonth, monthly_sales desc;

-- 15. products with a high return rate (if dataset includes return flags)
SELECT
    oi.product_id,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END) AS returns,
    ROUND(100 * SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END)/COUNT(*), 2) AS return_rate_pct
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY oi.product_id
ORDER BY return_rate_pct DESC
LIMIT 10;

-- 16. SKUs with extreme seasonality in sales
with monthly_sales as (
	select
		oi.product_id,
        date_format(o.order_purchase_timestamp, "%Y-%m") as month,
        sum(oi.price + oi.freight_value) as sales
	from order_items oi
    join orders o on oi.order_id = o.order_id
    group by oi.product_id, month
)
select
	product_id,
    max(sales) as max_monthly_sales,
    min(sales) as min_monthly_sales,
    (max(sales) - min(sales)) / nullif(max(sales), 0) as seasonality_index
from monthly_sales
group by product_id
order by seasonality_index desc
limit 10;

-- 17. products without any sales
select
	p.product_id,
    p.product_category_name
from products p
left join order_items oi on p.product_id = oi.product_id
where oi.order_id is null;

select *
from product_category
;






















