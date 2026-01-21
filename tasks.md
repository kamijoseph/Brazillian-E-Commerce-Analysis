# Tasks and Solutions

## **Customer & Order Behavior**

### 1. Total number of unique customers by year.
'2018', '52749'
'2017', '43713'
'2016', '326'


### 2. Total orders per month for the last three years.
'2016-09', '4'
'2016-10', '324'
'2016-12', '1'
'2017-01', '800'
'2017-02', '1780'
'2017-03', '2682'
'2017-04', '2404'
'2017-05', '3700'
'2017-06', '3245'
'2017-07', '4026'
'2017-08', '4331'
'2017-09', '4285'
'2017-10', '4631'
'2017-11', '7544'
'2017-12', '5673'
'2018-01', '7269'
'2018-02', '6728'
'2018-03', '7211'
'2018-04', '6939'
'2018-05', '6873'
'2018-06', '6167'
'2018-07', '6292'
'2018-08', '6512'
'2018-09', '16'
'2018-10', '4'


### 3. Average number of orders per customer.
1.03


### 4. Top 10 customers by total spending.
'0a0a92112bd4c708ca5fde585afaa872', '13664.08'
'46450c74a0d8c5ca9395da1daac6c120', '9553.02'
'da122df9eeddfedc1dc1f5349a1a690c', '7571.63'
'763c8b1c9c68a0229c42c9fc6f662b93', '7274.88'
'dc4802a71eae9be1dd28f5d788ceb526', '6929.31'
'459bef486812aa25204be022145caa62', '6922.21'
'ff4159b92c40ebe40454e3e6a7c35ed6', '6726.66'
'4007669dec559734d6f53e029e360987', '6081.54'
'5d0a2980b292d049061542014e8960bf', '4809.44'
'eebb5dda148d3893cdaf5b5ca3040ccb', '4764.34'


### 5. Percentage of customers who made repeat purchases.
very low at 3.12%

### 6. Distribution of orders by day of the week.
'Monday', '16196'
'Tuesday', '15963'
'Wednesday', '15552'
'Thursday', '14761'
'Friday', '14122'
'Sunday', '11960'
'Saturday', '10887'


### 7. Median order value by month.
'2016-09', '75.060000'
'2016-10', '112.650000'
'2016-12', '19.620000'
'2017-01', '106.130000'
'2017-02', '105.155000'
'2017-03', '102.640000'
'2017-04', '104.350000'
'2017-05', '104.450000'
'2017-06', '100.820000'
'2017-07', '102.015000'
'2017-08', '100.330000'
'2017-09', '104.370000'
'2017-10', '105.710000'
'2017-11', '103.550000'
'2017-12', '106.380000'
'2018-01', '104.870000'
'2018-02', '102.435000'
'2018-03', '107.140000'
'2018-04', '109.590000'
'2018-05', '108.520000'
'2018-06', '112.090000'
'2018-07', '108.920000'
'2018-08', '101.250000'
'2018-09', '122.080000'
'2018-10', '143.630000'



### 8. Orders with the highest number of items.
'8272b63d03f5f79c56e9e4120aec44ef', '21'
'ab14fdcfbe524636d65ee38360e22ce8', '20'
'1b15974a0141d54e36626dca3fdc731a', '20'
'9ef13efd6949e4573a18964dd1bbe7f5', '15'
'428a2f660dc84138d969ccd69a0ab6d5', '15'
'9bdc4d4c71aa1de4606060929dee888c', '14'
'73c8ab38f07dc94389065f7eba4f297a', '14'
'37ee401157a3a0b28c9c6d0ed8c3b24b', '13'
'2c2a19b5703863c908512d135aa6accc', '12'
'3a213fcdfe7d98be74ea0dc05a8b31ae', '12'


### 9. Orders with zero or negative shipping delay.
they are so many to paste here, run the mysql command to find out

```SQL
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
```


### 10. Breakdown of customers by state (using geolocation).
impasse



## **Product & Sales Analytics**

### 11. Top 10 products by total sales value.
'bb50f2e236e5eea0100680137654686c', '67606.10'
'd1c427060a0f73f6b889a5c7c61f2ac4', '60976.03'
'6cdd53843498f92890544667809f1595', '59093.99'
'99a4788cb24856965c36a24e339b6058', '51071.60'
'd6160fb7873f184099d9bc95e30376af', '50326.18'
'3dd2a17168ec895c781a9191c1e95ad7', '48212.22'
'aca2eb7d00ea1a7b8ebd4e68314663af', '44820.76'
'5f504b3a1c75b73d6151be81eb05bdc9', '41725.81'
'25c38557cf793876c5abdd5931f922db', '40311.95'
'53b36df67ebb7c41585e8d54d6772e08', '39957.93'


### 12. Top 10 product categories by number of orders.
'cama_mesa_banho', '9417'
'beleza_saude', '8836'
'esporte_lazer', '7720'
'informatica_acessorios', '6689'
'moveis_decoracao', '6449'
'utilidades_domesticas', '5884'
'relogios_presentes', '5624'
'telefonia', '4199'
'automotivo', '3897'
'brinquedos', '3886'


### 13. Average price per category.
output too long, run the query yourself pal

### 14. Percentage of total sales contributed by each category.
output too long, run the query yourself pal


### 15. Sales trend per category over time.
output too long, run the query yourself pal


### 16. Products with a high return rate (if dataset includes return flags).
'03b10f5e3ef07cfc27a025adca3fd0be', '1', '1', '100.00'
'0418d6ca9336c4a7ef9667aac0be1976', '1', '1', '100.00'
'07883aa96515a898e1b9ddf0537a1b56', '1', '1', '100.00'
'059fd0cc43081303f7c0d7770ab53d52', '1', '1', '100.00'
'05f97ad4ce078ed1de8882e1824eb07f', '1', '1', '100.00'
'0350ac874c8937571b129554110ec3b6', '1', '1', '100.00'
'0915ff4c13dc62982f2a0a3ae788945c', '1', '1', '100.00'
'03dc797f6faaa324fb633c518ff3f326', '1', '1', '100.00'
'01886ce599b5837b3e1966cdafacd080', '1', '1', '100.00'
'05fa60020215fd65f8f8b9dd441f864b', '1', '1', '100.00'


### 17. Correlation between price and quantity sold.
check query and pandas


### 18. SKUs with extreme seasonality in sales.
'53b36df67ebb7c41585e8d54d6772e08', '11831.08', '125.44', '0.989397'
'54d9ac713e253fa1fae9c8003b011c2a', '3498.48', '41.23', '0.988215'
'422879e10f46682990de24d770e7f83d', '6322.84', '77.57', '0.987732'
'42a2c92a0979a949ca4ea89ec5c7b934', '5660.69', '90.89', '0.983944'
'f1c7f353075ce59d8a6f3cf58f419c9c', '13404.56', '223.76', '0.983307'
'e53e557d5a159f5aa2c5e995dfdf244b', '6613.85', '125.42', '0.981037'
'2948658cb6abc82847412be7201bfc4c', '7267.74', '141.68', '0.980506'
'7e0dc102074f8285580c9777f79c90cf', '2221.63', '43.62', '0.980366'
'aca2eb7d00ea1a7b8ebd4e68314663af', '10692.90', '223.66', '0.979083'
'5411e9269501a870cabf632f05655131', '5397.32', '116.43', '0.978428'


19. Products without any sales (inventory inefficiencies).
None


### **Payments & Revenue**

21. Payment type breakdown (credit_card, boleto, etc.).
22. Average payment installment count by payment type.
23. Payment method reliability — refunds or chargebacks.
24. Revenue lost due to payment failures.
25. Trends in payment type adoption over time.
26. Average discount given per order.
27. Orders with payment delays.
28. Percentage of orders fully paid vs partially paid.
29. Most profitable payment type overall.
30. Payment fraud indicators (if available).

### **Seller Performance**

31. Total sales by seller.
32. Number of products sold per seller.
33. Seller ranking by average product review score.
34. Sellers with high cancellation rates.
35. Average fulfillment time per seller.
36. Seller contribution to total revenue.
37. Variance in seller performance over quarters.
38. Sellers with zero sales.
39. Sellers with multi-category inventory.
40. Seller geographic performance clusters.

### **Reviews & Ratings**

41. Average review score by product category.
42. Distribution of review scores (histogram shape).
43. Percentage of reviews mentioning delivery issues (text mining if available).
44. Review count per month (trend).
45. Correlation between review score and sales.
46. Heatmap of review scores by product and month.
47. Products with high review variance.
48. Percentage of returned orders that have a negative review.
49. Review scores by geographic region.
50. Average time between delivery and review posting.

---