# ✔ Recommended Dataset (Primary)

**Olist Brazilian E-Commerce Public Dataset**
A real, relational, e-commerce dataset with **orders, products, sellers, customers, payments, reviews, and geolocation information**. It’s way better for SQL schema design, joins, grouping, time-series, and deeper analysis than toy datasets. ([Built In][1])

🔗 **Download Link (Kaggle):**
[https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**What makes this great:**

* Multiple tables (orders, order_items, payments, customers, products, sellers, reviews, geolocation)
* Good size (~100,000+ orders, many linked CSVs)
* Real operational data (not synthetic)
* Perfect for database normalization and SQL querying
* Fits dashboarding questions around customer behavior, sales, performance, and geography
* Profile-worthy project — very few people build SQL + dashboard projects with this dataset ([Built In][1])

---

### **Customer & Order Behavior**

1. Total number of unique customers by year.
2. Total orders per month for the last three years.
3. Average number of orders per customer.
4. Top 10 customers by total spending.
5. Percentage of customers who made repeat purchases.
6. Distribution of orders by day of the week.
7. Median order value by month.
8. Orders with the highest number of items.
9. Orders with zero or negative shipping delay.
10. Breakdown of customers by state (using geolocation).

### **Product & Sales Analytics**

11. Top 20 products by total sales value.
12. Top 20 product categories by number of orders.
13. Average price per category.
14. Percentage of total sales contributed by each category.
15. Sales trend per category over time.
16. Products with a high return rate (if dataset includes return flags).
17. Correlation between price and quantity sold.
18. SKUs with extreme seasonality in sales.
19. Products without any sales (inventory inefficiencies).
20. Sales spikes during specific holidays or events.

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