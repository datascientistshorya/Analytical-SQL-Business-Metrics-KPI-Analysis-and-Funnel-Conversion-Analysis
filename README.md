# Business SQL Analytics — From Transactions to Business Decisions

A practical, business-focused SQL analytics project built with MySQL to understand how transactional data can be transformed into meaningful business metrics, customer insights, product performance analysis, and funnel diagnosis.

This repository is designed around a simple principle:

> SQL is not just about retrieving data. It is about using data to answer business questions.

The project starts with fundamental business KPIs such as revenue, orders, completion rate, cancellation rate, and Average Order Value, then progressively moves toward customer analysis, product analysis, category performance, revenue conversion, benchmarking, and business funnel diagnosis.

The goal is to develop the ability to look at a transactional dataset from a business analyst's perspective:

**What happened? → Where did it happen? → Who or what is driving it? → How large is the problem? → What should the business investigate next?**

---

## Project Objective

The primary objective of this project is to develop practical SQL skills through realistic business analysis rather than isolated syntax exercises.

The analysis focuses on understanding:

* Revenue performance
* Order volume
* Completed versus cancelled orders
* Completion rates
* Cancellation rates
* Average Order Value
* Customer revenue contribution
* High-value customers
* High-cancellation customers
* Product-level performance
* Category-level performance
* Revenue conversion
* Product and category drop-offs
* Performance against overall business benchmarks
* Business funnel diagnosis

The project demonstrates how SQL can move from simple aggregation to analytical reasoning.

---

# Business Context

Imagine an online business receiving orders across multiple customers and products.

The business wants to understand:

* How much revenue is actually being generated?
* How many orders are successfully completed?
* How many orders are cancelled?
* Which customers generate the most revenue?
* Which customers have unusually high cancellation rates?
* Which products have poor completion performance?
* Which categories contribute the most revenue?
* Which categories are converting poorly?
* Is a category underperforming because of order completion or because of the value of the orders being lost?
* Which areas require further investigation?

Instead of manually inspecting individual transactions, SQL is used to create repeatable business metrics and comparisons.

---

# Dataset Structure

The project uses three relational tables.

## Customers

| Column          | Description                |
| --------------- | -------------------------- |
| `customer_id`   | Unique customer identifier |
| `customer_name` | Customer name              |
| `city`          | Customer city              |

## Orders

| Column        | Description                                 |
| ------------- | ------------------------------------------- |
| `order_id`    | Unique order identifier                     |
| `customer_id` | Customer associated with the order          |
| `product_id`  | Product associated with the order           |
| `amount`      | Order value                                 |
| `status`      | Order status such as Completed or Cancelled |
| `order_date`  | Date the order was placed                   |

## Products

| Column         | Description               |
| -------------- | ------------------------- |
| `product_id`   | Unique product identifier |
| `product_name` | Product name              |
| `category`     | Product category          |
| `price`        | Product price             |

### Relationships

```text
customers
    |
    | customer_id
    |
orders
    |
    | product_id
    |
products
```

The central transactional table is `orders`, which connects customers with products and contains the business outcome of each order.

---

# Business Questions

## Batch 1 — Business Metrics & KPI Analysis

### Q1 — Total Revenue

How much revenue was generated from completed orders?

**Business purpose:** Establish the core revenue KPI while excluding cancelled transactions.

---

### Q2 — Total Orders & Completed Orders

How many orders were placed, completed, and cancelled?

**Business purpose:** Understand overall transaction volume and the split between successful and unsuccessful orders.

---

### Q3 — Average Order Value

What is the Average Order Value for completed orders?

**Business purpose:** Understand the average monetary value of a successful transaction.

---

### Q4 — Cancellation Rate

What percentage of all orders were cancelled?

**Business purpose:** Quantify the scale of order failure and identify whether cancellations represent a meaningful business problem.

---

### Q5 — Revenue by Customer

How much completed revenue did each customer generate?

**Business purpose:** Identify the customers contributing most to business revenue.

---

### Q6 — Customers Above Average Revenue

Which customers generated more completed revenue than the average customer?

**Business purpose:** Establish a revenue benchmark and identify above-average customers.

---

### Q7 — Category Revenue

Which product categories generate the most completed revenue?

**Business purpose:** Understand the contribution of different product categories to overall business revenue.

---

### Q8 — Revenue Contribution %

What percentage of total completed revenue comes from each category?

**Business purpose:** Measure revenue concentration and understand the relative importance of each category.

---

### Q9 — High-Value Customers

Which customers generated more than ₹10,000 in completed revenue?

**Business purpose:** Identify commercially important customers based on an explicit revenue threshold.

---

### Q10 — Business KPI Summary

Can the most important business KPIs be summarized in one result?

Metrics include:

* Total revenue
* Total orders
* Completed orders
* Cancelled orders
* AOV
* Cancellation rate

**Business purpose:** Create a compact executive-level snapshot of business performance.

---

# Batch 2 — Funnel & Conversion Analysis

Batch 2 moves beyond basic KPIs and starts asking where business performance is breaking down.

---

### Q1 — Order Completion Rate

What percentage of all orders were successfully completed?

**Business purpose:** Measure the overall transaction completion performance.

---

### Q2 — Cancellation Rate by Customer

Which customers have the highest cancellation rates?

**Business purpose:** Identify customer-level cancellation patterns rather than looking only at the overall business rate.

---

### Q3 — Completion Rate by Product

Which products have the highest and lowest order completion rates?

**Business purpose:** Identify products associated with stronger or weaker transaction outcomes.

---

### Q4 — Product-Level Funnel Analysis

The repository uses product and transaction-level analysis to understand where order performance varies across the product portfolio.

**Business purpose:** Move from company-level KPIs toward product-specific diagnosis.

---

### Q5 — Revenue Conversion

What percentage of total order value becomes completed revenue?

**Business purpose:** Distinguish between order-count conversion and monetary-value conversion.

This is important because two categories can have similar completion rates but very different revenue outcomes.

---

### Q6 — Customer Funnel

For every customer, what are their:

* Total orders
* Completed orders
* Cancelled orders
* Completion rate
* Cancellation rate
* Completed revenue

**Business purpose:** Build a customer-level funnel view combining behavioral and financial performance.

---

### Q7 — High Cancellation Customers

Which customers have at least two orders and a cancellation rate greater than 50%?

**Business purpose:** Identify customers with repeated transaction failure rather than reacting to customers with only one isolated cancellation.

---

### Q8 — Product Drop-Off Analysis

Which products have more cancelled orders than completed orders?

**Business purpose:** Identify products where unsuccessful transactions exceed successful transactions.

These products become candidates for deeper investigation.

---

### Q9 — Category Revenue Funnel

For each category, calculate:

* Total order value
* Completed revenue
* Cancelled order value
* Revenue conversion rate

**Business purpose:** Understand category performance from both transaction and monetary perspectives.

---

### Q10 — Business Funnel Diagnosis

Which categories are underperforming against the overall business benchmark on both:

1. Completion rate
2. Revenue conversion rate

**Business purpose:** Move from descriptive reporting toward actual business diagnosis.

A category that performs below the overall benchmark on both metrics deserves further investigation because the issue is not limited to one isolated KPI.

---

# Analytical Objectives

This project is designed to answer five major analytical questions.

## 1. What happened?

Measure:

* Revenue
* Orders
* Completed orders
* Cancelled orders
* AOV
* Completion rate
* Cancellation rate

---

## 2. Who is driving performance?

Analyze:

* Customers
* High-value customers
* High-cancellation customers
* Customer-level revenue

---

## 3. What products or categories are driving performance?

Analyze:

* Product completion
* Product cancellations
* Category revenue
* Category revenue contribution
* Category conversion

---

## 4. Where is the funnel breaking?

Compare:

```text
Orders
   ↓
Completed Orders
   ↓
Completed Revenue
```

This allows the analysis to distinguish between:

* Order-volume problems
* Completion problems
* Cancellation problems
* Revenue-value problems

---

## 5. Which areas require investigation?

Use overall business benchmarks to identify:

* Below-average customers
* High-cancellation customers
* Poor-performing products
* Poor-performing categories
* Categories with weak completion and revenue conversion

The objective is not simply to produce numbers.

The objective is to identify **where the business should investigate next**.

---

# SQL Techniques Used

## Aggregation

Core aggregate functions are used extensively:

```sql
SUM()
COUNT()
AVG()
MIN()
MAX()
```

These functions transform individual transactions into business-level metrics.

---

## Conditional Aggregation

`CASE WHEN` is used to calculate metrics based on order status.

Example:

```sql
SUM(
    CASE
        WHEN status = 'Completed' THEN amount
        ELSE 0
    END
)
```

This allows completed revenue to be calculated without filtering out other orders from the analysis.

---

## CASE Expressions

`CASE` statements are used for business logic such as:

* Completed orders
* Cancelled orders
* Revenue classification
* Conditional counts
* Conditional revenue

---

## Common Table Expressions

CTEs are used to break complex analytical problems into understandable stages.

Example structure:

```sql
WITH customer_data AS (
    ...
),
benchmark AS (
    ...
)
SELECT ...
FROM customer_data;
```

This improves readability and makes multi-step business analysis easier to reason about.

---

## GROUP BY

Grouping is used to analyze performance by:

* Customer
* Product
* Category

This converts transaction-level data into business dimensions.

---

## JOINs

The project uses relational joins to combine:

```text
customers + orders
products + orders
```

This allows transactional performance to be analyzed from customer and product perspectives.

---

## CROSS JOIN for Benchmarking

`CROSS JOIN` is used when comparing grouped performance against an overall business benchmark.

For example:

```text
Category Completion Rate
        vs.
Overall Completion Rate
```

This is particularly useful for business diagnosis.

---

## Percentage Metrics

The project calculates metrics such as:

```text
Completion Rate
Cancellation Rate
Revenue Conversion Rate
Revenue Contribution %
```

These metrics provide more useful context than raw counts alone.

---

## Multi-Level Aggregation

The project frequently follows this analytical pattern:

```text
Transaction Level
       ↓
Customer / Product / Category Level
       ↓
Overall Benchmark
       ↓
Business Diagnosis
```

This is an important step toward analytical SQL rather than simply writing syntactically correct queries.

---

# Analytical Thinking Developed

The project focuses on developing the habit of asking:

### Metric

What happened?

### Comparison

Is this good or bad relative to something?

### Segmentation

Where is the problem occurring?

### Diagnosis

What could explain the difference?

### Action

What should be investigated next?

For example:

```text
Category A has a 55% completion rate.

That number alone tells us little.

Compare it with:

Overall completion rate = 72%

Now we know Category A is underperforming.

Next:

Revenue conversion rate = 41%
Overall revenue conversion = 68%

Now the evidence is stronger.

The category is underperforming on both
transaction completion and monetary conversion.
```

This is the difference between reporting a metric and performing business analysis.

---

# Key Concepts Practiced

* Business KPI design
* Revenue analysis
* Order analysis
* Customer analysis
* Product analysis
* Category analysis
* Funnel analysis
* Conversion analysis
* Cancellation analysis
* Revenue contribution
* Benchmark comparison
* Conditional aggregation
* Multi-level aggregation
* Business segmentation
* SQL-based diagnosis

---

# Repository Learning Outcomes

By completing these analyses, the project develops the ability to:

* Translate business questions into SQL problems
* Identify the correct grain of analysis
* Build KPIs from transactional data
* Separate completed and cancelled transactions
* Compare customer performance
* Compare product performance
* Analyze category contribution
* Calculate conversion metrics
* Build business funnels
* Compare segments against overall benchmarks
* Use CTEs to structure analytical queries
* Use conditional aggregation effectively
* Combine multiple relational tables
* Interpret SQL output from a business perspective

---

# Analytical Framework

The overall approach used throughout the project can be summarized as:

```text
Raw Transactions
       |
       v
Data Aggregation
       |
       v
Business KPIs
       |
       v
Customer / Product / Category Segmentation
       |
       v
Conversion & Funnel Analysis
       |
       v
Benchmark Comparison
       |
       v
Business Diagnosis
```

---

# Why This Project Matters

Many SQL projects stop at questions such as:

> "How many orders were placed?"

This project goes further.

It asks:

> "How many orders were completed?"

Then:

> "Where are cancellations concentrated?"

Then:

> "Which customers or products are affected?"

Then:

> "Are the affected categories also losing revenue?"

And finally:

> "Which categories are performing below the overall business benchmark?"

This progression reflects how SQL is used in real analytical environments.

The goal is not to demonstrate how many SQL functions can be memorized.

The goal is to demonstrate how SQL can support **structured business reasoning**.

---

# Tools

* MySQL
* MySQL Workbench
* SQL
* GitHub

---

# Project Structure

```text
business-sql-analytics/
│
├── README.md
│
├── batch-1/
│   └── business-metrics-kpi-analysis.sql
│
├── batch-2/
│   └── funnel-conversion-analysis.sql
│
├── data/
│   └── sample-data.sql
│
└── images/
    └── repository-banner.png
```

The exact folder structure can be adapted as the project expands.

---

# Future Development

The project is designed to progress from foundational business metrics toward increasingly advanced analytical SQL.

Future analysis can include:

* Customer segmentation
* Product performance benchmarking
* Advanced business cases
* Window-function-based analysis
* Ranking and comparative analysis
* More complex funnel diagnostics
* Deeper revenue and customer behavior analysis

The emphasis will remain on solving business problems rather than practicing SQL syntax in isolation.

---

# Author

**Shorya Dev Bisht**

Data Analyst | Data Scientist | Web Analyst

I am interested in using data, SQL, analytics, and machine learning to turn complex datasets into insights that support better business decisions.

### Connect with me

* LinkedIn: https://www.linkedin.com/in/shorya-bisht-a20144349/
* GitHub: https://github.com/datascientistshorya
* Medium: https://medium.com/@its.shoryabisht

---

# Final Objective

This repository represents an ongoing effort to develop from someone who can write SQL queries into an analyst who can use SQL to investigate business problems.

The ultimate workflow is:

**Understand the business question → identify the right data → write the SQL → validate the metric → compare performance → diagnose the problem → communicate the insight.**

That is the standard this project aims to build toward.
