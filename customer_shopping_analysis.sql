-- 1. CREATE CUSTOMERS TABLE

CREATE TABLE shopping_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    membership VARCHAR(20)
);


-- 2. INSERT CUSTOMER DATA

INSERT INTO shopping_customers
VALUES
(1, 'Ananya', 24, 'Hyderabad', 'Gold'),
(2, 'Rahul', 29, 'Bengaluru', 'Silver'),
(3, 'Priya', 26, 'Hyderabad', 'Gold'),
(4, 'Arjun', 32, 'Chennai', 'Bronze'),
(5, 'Sneha', 28, 'Bengaluru', 'Gold'),
(6, 'Kiran', 35, 'Hyderabad', 'Silver'),
(7, 'Divya', 23, 'Chennai', 'Bronze'),
(8, 'Rohit', 31, 'Bengaluru', 'Gold');


-- 3. CREATE ORDERS TABLE

CREATE TABLE shopping_orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES shopping_customers(customer_id),
    product_category VARCHAR(50),
    order_amount NUMERIC(10,2),
    order_date DATE,
    order_status VARCHAR(20)
);


-- 4. INSERT ORDER DATA

INSERT INTO shopping_orders
VALUES
(101, 1, 'Clothing', 1500, '2026-09-01', 'Completed'),
(102, 2, 'Electronics', 4500, '2026-09-02', 'Completed'),
(103, 3, 'Beauty', 800, '2026-09-03', 'Completed'),
(104, 1, 'Electronics', 3000, '2026-09-05', 'Completed'),
(105, 4, 'Clothing', 1200, '2026-09-06', 'Cancelled'),
(106, 5, 'Beauty', 1000, '2026-09-07', 'Completed'),
(107, 6, 'Electronics', 6000, '2026-09-08', 'Completed'),
(108, 7, 'Clothing', 900, '2026-09-10', 'Completed'),
(109, 2, 'Clothing', 2000, '2026-09-12', 'Completed'),
(110, 8, 'Electronics', 5500, '2026-09-14', 'Completed'),
(111, 3, 'Beauty', 1200, '2026-09-15', 'Completed'),
(112, 5, 'Clothing', 1800, '2026-09-17', 'Completed'),
(113, 1, 'Beauty', 700, '2026-09-20', 'Completed'),
(114, 6, 'Clothing', 1600, '2026-09-22', 'Completed'),
(115, 8, 'Beauty', 1300, '2026-09-25', 'Cancelled');


-- 5. VIEW ALL CUSTOMERS

SELECT *
FROM shopping_customers;


-- 6. VIEW ALL ORDERS

SELECT *
FROM shopping_orders;


-- 7. CUSTOMER ORDER DETAILS USING JOIN

SELECT
    c.customer_name,
    c.city,
    c.membership,
    o.order_id,
    o.product_category,
    o.order_amount,
    o.order_status
FROM shopping_customers c
JOIN shopping_orders o
    ON c.customer_id = o.customer_id
ORDER BY o.order_id;


-- 8. TOTAL COMPLETED REVENUE

SELECT
    SUM(order_amount) AS total_revenue
FROM shopping_orders
WHERE order_status = 'Completed';


-- 9. TOTAL SPENDING BY CUSTOMER

SELECT
    c.customer_name,
    COUNT(o.order_id) AS completed_orders,
    SUM(o.order_amount) AS total_spending
FROM shopping_customers c
JOIN shopping_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


-- 10. AVERAGE ORDER VALUE

SELECT
    ROUND(AVG(order_amount), 2) AS average_order_value
FROM shopping_orders
WHERE order_status = 'Completed';


-- 11. REVENUE BY PRODUCT CATEGORY

SELECT
    product_category,
    COUNT(*) AS completed_orders,
    SUM(order_amount) AS category_revenue
FROM shopping_orders
WHERE order_status = 'Completed'
GROUP BY product_category
ORDER BY category_revenue DESC;


-- 12. MEMBERSHIP-WISE REVENUE

SELECT
    c.membership,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS completed_orders,
    COALESCE(SUM(o.order_amount), 0) AS total_revenue
FROM shopping_customers c
LEFT JOIN shopping_orders o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
GROUP BY c.membership
ORDER BY total_revenue DESC;


-- 13. REPEAT CUSTOMERS

SELECT
    c.customer_name,
    COUNT(o.order_id) AS completed_orders,
    SUM(o.order_amount) AS total_spending
FROM shopping_customers c
JOIN shopping_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY completed_orders DESC;


-- 14. CUSTOMER SPENDING SEGMENTS

SELECT
    c.customer_name,
    SUM(o.order_amount) AS total_spending,
    CASE
        WHEN SUM(o.order_amount) >= 5000 THEN 'High Value'
        WHEN SUM(o.order_amount) >= 2500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM shopping_customers c
JOIN shopping_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


-- 15. ORDER CANCELLATION RATE

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_status = 'Cancelled'
        ) / COUNT(*),
        2
    ) AS cancellation_rate_percentage
FROM shopping_orders;


-- 16. CANCELLATIONS BY PRODUCT CATEGORY

SELECT
    product_category,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders
FROM shopping_orders
GROUP BY product_category
ORDER BY cancelled_orders DESC;


-- 17. MONTHLY REVENUE

SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(order_amount) AS monthly_revenue
FROM shopping_orders
WHERE order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- 18. CUSTOMER RANKING BY SPENDING

SELECT
    c.customer_name,
    SUM(o.order_amount) AS total_spending,
    RANK() OVER (
        ORDER BY SUM(o.order_amount) DESC
    ) AS spending_rank
FROM shopping_customers c
JOIN shopping_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY spending_rank;


-- 19. REVENUE CONTRIBUTION BY CATEGORY

SELECT
    product_category,
    SUM(order_amount) AS category_revenue,
    ROUND(
        100.0 * SUM(order_amount)
        / SUM(SUM(order_amount)) OVER (),
        2
    ) AS revenue_percentage
FROM shopping_orders
WHERE order_status = 'Completed'
GROUP BY product_category
ORDER BY category_revenue DESC;


-- 20. CUSTOMERS WITH NO COMPLETED ORDERS

SELECT
    c.customer_id,
    c.customer_name,
    c.membership
FROM shopping_customers c
LEFT JOIN shopping_orders o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
WHERE o.order_id IS NULL;


-- 21. DAILY REVENUE AND RUNNING TOTAL

SELECT
    daily_sales.order_date,
    daily_sales.daily_revenue,
    SUM(daily_sales.daily_revenue) OVER (
        ORDER BY daily_sales.order_date
    ) AS running_revenue
FROM (
    SELECT
        order_date,
        SUM(order_amount) AS daily_revenue
    FROM shopping_orders
    WHERE order_status = 'Completed'
    GROUP BY order_date
) daily_sales
ORDER BY daily_sales.order_date;


-- 22. FINAL BUSINESS KPI DASHBOARD

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'Completed'
    ) AS completed_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders,
    SUM(order_amount) FILTER (
        WHERE order_status = 'Completed'
    ) AS completed_revenue,
    ROUND(
        AVG(order_amount) FILTER (
            WHERE order_status = 'Completed'
        ),
        2
    ) AS average_order_value,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_status = 'Cancelled'
        ) / COUNT(*),
        2
    ) AS cancellation_rate_percentage
FROM shopping_orders;
