# Customer Shopping Behavior Analysis Using SQL

## Project Overview

This project analyzes customer shopping behavior using PostgreSQL. It explores customer spending patterns, repeat purchases, membership categories, product category revenue, order cancellations, and sales trends.

The objective is to transform sample shopping data into meaningful business insights using SQL queries.

## Tools Used

- PostgreSQL
- SQL
- pgAdmin
- GitHub

## Dataset Description

The project uses two tables containing sample shopping data.

### 1. shopping_customers

Contains customer information:
- Customer ID
- Customer name
- Age
- City
- Membership type

### 2. shopping_orders

Contains order information:
- Order ID
- Customer ID
- Product category
- Order amount
- Order date
- Order status

The dataset contains 8 customers and 15 orders, including completed and cancelled orders. All data is created for practice and demonstration purposes.

## SQL Concepts Used

- CREATE TABLE and INSERT
- SELECT and WHERE
- ORDER BY
- GROUP BY and HAVING
- Aggregate functions: SUM, AVG, COUNT
- INNER JOIN and LEFT JOIN
- CASE statements
- COALESCE
- Conditional aggregation using FILTER
- Date functions and DATE_TRUNC
- Subqueries
- Window functions
- RANK()
- Running totals
- KPI calculations

## Business Questions Answered

1. What is the total completed sales revenue?
2. How much does each customer spend?
3. What is the average order value?
4. Which product category generates the highest revenue?
5. How does revenue vary by membership type?
6. Who are the repeat customers?
7. How can customers be segmented by spending?
8. What percentage of orders are cancelled?
9. Which product categories have cancelled orders?
10. What is the monthly revenue?
11. Who are the highest-spending customers?
12. What percentage of revenue comes from each category?
13. Which customers have no completed orders?
14. How does revenue accumulate over time?
15. What are the key business KPIs?

## Key Findings

- Total customers: 8
- Total orders: 15
- Completed orders: 13
- Cancelled orders: 2
- Completed revenue: ₹30,500
- Average order value: ₹2,346.15
- Cancellation rate: 13.33%
- Highest-spending customer: Kiran, with ₹7,600 in completed orders
- Highest-revenue category: Electronics, generating ₹19,000
- Electronics contributed approximately 62.30% of completed revenue.
- Gold membership generated ₹15,500 in completed revenue.
- Five customers placed more than one completed order.
- One customer, Arjun, had no completed orders.

These results reflect the sample dataset and are not real business figures.

## Project Structure

```text
customer-shopping-behavior-sql/
├── customer_shopping_analysis.sql
└── README.md
```

## How to Run the Project

1. Install PostgreSQL and open pgAdmin or another PostgreSQL-compatible SQL editor.
2. Create or select a database.
3. Open `customer_shopping_analysis.sql`.
4. Execute the SQL script from top to bottom.
5. Review the query outputs and compare them with the findings documented above.

If you have already created the tables, use a fresh database or remove the existing project tables before rerunning the complete script.

## Skills Demonstrated

This project demonstrates practical SQL skills in data extraction, data aggregation, customer analysis, revenue analysis, segmentation, ranking, and KPI reporting.

It also demonstrates how SQL can support business decisions by identifying valuable customers, high-performing product categories, and order cancellation patterns.

## Author

Bhavya
