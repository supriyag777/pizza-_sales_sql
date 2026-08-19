# 🍕 Pizza Sales Analysis

A MySQL-based data analysis project that explores pizza sales performance, total revenue, customer ordering patterns, and category trends. Raw sales data is processed and analyzed using advanced SQL techniques to derive actionable business insights.

---

## 🛠️ Key SQL Techniques Used
* **Database Setup & Schema Creation:** DDL commands (`CREATE TABLE`, `PRIMARY KEY`, data constraints).
* **Data Aggregation & Grouping:** `COUNT()`, `SUM()`, `AVG()`, `GROUP BY`, `ORDER BY`.
* **Multi-Table Joins:** Combining sales data using `INNER JOIN` across multiple related tables.
* **Advanced Analytics:** 
  * **Common Table Expressions (CTEs)** for structured subquery handling.
  * **Window Functions** (`RANK()`, `DENSE_RANK()`) to determine top-performing items by category.

---

## ❓ Key Business Questions Solved
1. What is the total revenue generated from pizza sales?
2. Which pizza types and sizes generate the highest revenue?
3. Which pizza categories are the most popular among customers?
4. What are the peak ordering days and hours?
5. What are the top 3 pizza types by revenue within each category?

---

## 📊 Summary of Findings
* **Top Revenue Drivers:** Large-size pizzas contributed significantly higher revenue compared to small and medium sizes.
* **Category Performance:** The **Classic** and **Supreme** categories lead overall sales volume and revenue generation.
* **Peak Ordering Hours:** Order volume peaks during lunch (12 PM – 2 PM) and dinner (6 PM – 8 PM) hours, highlighting key operational timeframes.

---

## 🚀 How to Run
1. Install **MySQL Server** and **MySQL Workbench**.
2. Clone or download this repository.
3. Open `schema.sql` in MySQL Workbench and execute to create the database and tables.
4. Import the dataset CSV files from the `/data` directory into their respective tables.
5. Execute the analysis queries in `queries.sql` to inspect results.
