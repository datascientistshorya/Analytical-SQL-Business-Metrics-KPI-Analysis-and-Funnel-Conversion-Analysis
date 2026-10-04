-- BATCH 2
/*Q1 — Order Completion Rate
Calculate the percentage of all orders that were completed.
Return:
•	total_orders 
•	completed_orders 
•	completion_rate */

select count(*) as total_orders,
sum(case when status='Completed' then 1 else 0 end) as completed_orders,
sum(case when status='Completed' then 1 else 0 end)/count(*)*100 as completion_rate
from orders;

/*Q2 — Cancellation Rate by Customer
For each customer, calculate their cancellation rate.
Return:
•	customer_id 
•	customer_name 
•	total_orders 
•	cancelled_orders 
•	cancellation_rate 
Sort by cancellation_rate descending.*/

with customer_data as(
	select c.customer_id,c.customer_name,
    count(o.customer_id) as total_orders,
    sum(case when o.status='Cancelled' then 1 else 0 end) as cancelled_orders
    from customers c inner join orders o 
    on c.customer_id=o.customer_id
    group by c.customer_id,c.customer_name
)
select*, 
cancelled_orders/total_orders*100 as cancellation_rate
from customer_data
order by cancellation_rate desc;

/*Q3 — Completion Rate by Product
Calculate the completion rate for each product.
Return:
•	product_id 
•	product_name 
•	total_orders 
•	completed_orders 
•	completion_rate 
Sort by completion rate descending.*/

with prod_data as(
	select p.product_id,p.product_name,
    count(o.product_id) as total_orders,
    sum(case when o.status='Completed' then 1 else 0 end) as completed_orders
    from products p inner join orders o 
    on p.product_id=o.product_id
    group by p.product_id,p.product_name
)
select*, 
completed_orders/total_orders*100 as completion_rate
from prod_data
order by completion_rate desc;

/*Q5 — Revenue Conversion
Calculate the percentage of total order value that became completed revenue.
Return:
•	total_order_value 
•	completed_revenue 
•	revenue_conversion_rate */

select count(*) as total_orders,
sum(amount) as total_order_value,
sum(case when status='Completed' then amount else 0 end) as completed_revenue,
round(sum(case when status='Completed' then amount else 0 end)/sum(amount) * 100,2) as revenue_conversion_rate
from orders;

/*Q6 — Customer Funnel
For every customer, calculate:
•	total orders 
•	completed orders 
•	cancelled orders 
•	completion rate 
•	completed revenue */

with customer_data as(
	select c.customer_id,count(c.customer_id) as total_orders,
    sum(case when o.status='Completed' then 1 else 0 end) as completed_orders,
    sum(case when o.status='Cancelled' then 1 else 0 end) as cancelled_orders
    from customers c inner join orders o 
    on c.customer_id=o.customer_id
    group by c.customer_id
)
select *,
completed_orders/total_orders*100 completion_rate,
cancelled_orders/total_orders*100 cancellation_rate
from customer_data;

/*Q7 — High Cancellation Customers
Find customers who have:
•	at least 2 orders 
•	cancellation rate greater than 50% 
Return:
•	customer_id 
•	customer_name 
•	total_orders 
•	cancelled_orders 
•	cancellation_rate*/
with customer_data as(
	select c.customer_id,count(c.customer_id) as total_orders,
    sum(case when o.status='Cancelled' then 1 else 0 end) as cancelled_orders
    from customers c inner join orders o 
    on c.customer_id=o.customer_id
    group by c.customer_id
)
select*,
cancelled_orders/total_orders*100 cancellation_rate
from customer_data
where total_orders>=2
and cancelled_orders/total_orders*100>=50 ;

/*Q8 — Product Drop-Off Analysis
Find products where:
cancelled orders > completed orders
Return:
•	product_id 
•	product_name 
•	total_orders 
•	completed_orders 
•	cancelled_orders 
•	cancellation_rate 
Sort by cancellation rate descending.*/
with prod_data as(
	select p.product_id,p.product_name,
    count(o.product_id) as total_orders,
    sum(case when o.status='Completed' then 1 else 0 end) as completed_orders,
    sum(case when o.status='Cancelled' then 1 else 0 end) as cancelled_orders
    from products p inner join orders o 
    on p.product_id=o.product_id
    group by p.product_id,p.product_name
)
select *, cancelled_orders/total_orders*100 cancellation_rate
from prod_data
where cancelled_orders>completed_orders;
 
 /*Q9 — Category Revenue Funnel
For every category, calculate:
•	total order value 
•	completed revenue 
•	cancelled order value 
•	revenue conversion rate */

select p.category, sum(o.amount) as total_rev,
 sum(case when o.status='Completed' then o.amount else 0 end) as completed_rev,
 sum(case when o.status='Cancelled' then o.amount else 0 end) as cancelled_rev,
 sum(case when o.status='Completed' then o.amount else 0 end)/sum(o.amount)*100 as rev_conversion
 from products p inner join orders o 
 on p.product_id=o.product_id
 group by p.category
 order by p.category; 
 
 /*Q10 — Business Funnel Diagnosis
Identify categories where both conditions are true:
1.	Completion rate is below the overall completion rate. 
2.	Revenue conversion rate is below the overall revenue conversion rate. 
Return:
•	category 
•	completion_rate 
•	revenue_conversion_rate*/

WITH category_data AS (
    SELECT
        p.category,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN o.status = 'Completed' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100 AS completion_rate,
        SUM(
            CASE
                WHEN o.status = 'Completed' THEN o.amount
                ELSE 0
            END
        ) / SUM(o.amount) * 100 AS revenue_conversion_rate
    FROM products p
    INNER JOIN orders o
        ON p.product_id = o.product_id
    GROUP BY p.category
),

benchmark AS (
    SELECT
        SUM(
            CASE
                WHEN status = 'Completed' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100 AS overall_completion_rate,

        SUM(
            CASE
                WHEN status = 'Completed' THEN amount
                ELSE 0
            END
        ) / SUM(amount) * 100 AS overall_revenue_conversion_rate
    FROM orders
)

SELECT
    cd.category,
    cd.completion_rate,
    cd.revenue_conversion_rate
FROM category_data cd
CROSS JOIN benchmark b
WHERE cd.completion_rate < b.overall_completion_rate
  AND cd.revenue_conversion_rate < b.overall_revenue_conversion_rate;