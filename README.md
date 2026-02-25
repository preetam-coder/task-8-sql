📖 Project Objective

The objective of this project is to understand how to create and use:

Stored Procedures

Functions

Parameters

Conditional Logic

This project demonstrates how to modularize SQL logic using reusable database blocks in PostgreSQL.

🛠 Tools Used

PostgreSQL

pgAdmin 4

🗂 Database Schema

This project uses two related tables:

1️⃣ Customers Table
Column	Type	Description
customer_id	SERIAL (PK)	Unique customer ID
customer_name	VARCHAR(100)	Name of customer
city	VARCHAR(100)	Customer city
2️⃣ Orders Table
Column	Type	Description
order_id	SERIAL (PK)	Unique order ID
order_date	DATE	Date of order
amount	NUMERIC(10,2)	Order amount
customer_id	INT (FK)	References customers(customer_id)

Relationship:

One customer can place multiple orders (One-to-Many)

🔁 Stored Procedure
Procedure Name:

add_order

Purpose:

Insert a new order with validation.

Features:

Accepts parameters (order_date, amount, customer_id)

Uses conditional logic

Prevents insertion if amount ≤ 0

Displays success or error message

Example Call:
CALL add_order('2026-02-20', 2000, 1);
🔢 Function
Function Name:

get_total_spent

Purpose:

Returns the total amount spent by a specific customer.

Features:

Accepts customer_id as parameter

Uses SUM() aggregation

Returns 0 if no orders found

Can be used inside SELECT statement

Example Usage:
SELECT customer_name,
       get_total_spent(customer_id) AS total_spent
FROM customers;
🔎 Procedure vs Function
Stored Procedure	Function
Called using CALL	Used inside SELECT
May not return value	Must return value
Used for operations (INSERT/UPDATE)	Used for calculations
Can contain complex logic	Returns computed result
🎯 Learning Outcomes

After completing this project, you will:

Understand procedural SQL (PL/pgSQL)

Use parameters in procedures and functions

Apply conditional logic (IF statements)

Create reusable SQL blocks

Modularize database logic

Differentiate between procedure and function
