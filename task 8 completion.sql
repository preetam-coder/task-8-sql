-- =========================================
-- DROP TABLES IF EXIST
-- =========================================

DROP VIEW IF EXISTS high_value_orders;
DROP VIEW IF EXISTS customer_order_summary;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    amount NUMERIC(10,2),
    customer_id INT REFERENCES customers(customer_id)
);

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================

INSERT INTO customers (customer_name, city) VALUES
('Rahul', 'Bangalore'),
('Amit', 'Mumbai'),
('Sneha', 'Chennai');

INSERT INTO orders (order_date, amount, customer_id) VALUES
('2026-02-01', 1500.00, 1),
('2026-02-05', 2500.00, 1),
('2026-02-10', 3000.00, 2);

-- =========================================
-- DROP PROCEDURE IF EXISTS
-- =========================================

DROP PROCEDURE IF EXISTS add_order;

-- =========================================
-- CREATE STORED PROCEDURE
-- Adds new order with validation
-- =========================================

CREATE OR REPLACE PROCEDURE add_order(
    p_order_date DATE,
    p_amount NUMERIC,
    p_customer_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if amount is positive
    IF p_amount <= 0 THEN
        RAISE NOTICE 'Order amount must be greater than zero.';
    ELSE
        INSERT INTO orders(order_date, amount, customer_id)
        VALUES (p_order_date, p_amount, p_customer_id);

        RAISE NOTICE 'Order inserted successfully.';
    END IF;
END;
$$;

-- =========================================
-- CALL PROCEDURE
-- =========================================

CALL add_order('2026-02-20', 2000, 1);
CALL add_order('2026-02-22', -500, 2);

-- =========================================
-- DROP FUNCTION IF EXISTS
-- =========================================

DROP FUNCTION IF EXISTS get_total_spent;

-- =========================================
-- CREATE FUNCTION
-- Returns total amount spent by customer
-- =========================================

CREATE OR REPLACE FUNCTION get_total_spent(p_customer_id INT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM orders
    WHERE customer_id = p_customer_id;

    -- If no orders found
    IF total IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- =========================================
-- USE FUNCTION
-- =========================================

SELECT customer_name,
       get_total_spent(customer_id) AS total_spent
FROM customers;