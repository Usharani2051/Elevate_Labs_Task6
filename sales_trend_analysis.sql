CREATE DATABASE superstore_db;
USE superstore_db;

--  Extract the month from the order date
SELECT 
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month
FROM superstore
LIMIT 10;

--   Extract both year and month
-- Group the results so we can calculate aggregations per month-year
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month
FROM superstore
GROUP BY order_year, order_month
LIMIT 10;


--  Calculate total revenue for each month
-- SUM() is used to add up all sales amounts for that period
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
    SUM(Sales) AS total_revenue
FROM superstore
GROUP BY order_year, order_month;

-- Count distinct order IDs to get order volume
-- COUNT(DISTINCT) ensures that multiple products in the same order are only counted once
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
    COUNT(DISTINCT "Order ID") AS order_volume
FROM superstore
GROUP BY order_year, order_month;

-- Sort the output so it shows in chronological order
-- ORDER BY ensures results are easier to read and analyze
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
    SUM(Sales) AS total_revenue,
    COUNT(DISTINCT "Order ID") AS order_volume
FROM superstore
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

--  Filter to show results only for a certain date range
-- The WHERE clause is used here to restrict the time period
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
    SUM(Sales) AS total_revenue,
    COUNT(DISTINCT "Order ID") AS order_volume
FROM superstore
WHERE STR_TO_DATE(`Order Date`, '%m/%d/%Y') BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- Monthly Sales Trend Analysis with additional business metrics
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_month,
    Region,
    Category,
    SUM(Sales) AS total_revenue,                  -- Total sales in dollars
    COUNT(DISTINCT "Order ID") AS order_volume,   -- Unique orders
    SUM(Quantity) AS total_quantity,              -- Total items sold
    SUM(Profit) AS total_profit                    -- Total profit
FROM superstore
GROUP BY order_year, order_month, Region, Category
ORDER BY order_year, order_month, Region, Category;