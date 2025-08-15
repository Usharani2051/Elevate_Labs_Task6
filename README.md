# Elevate_Labs_Task6

# Task 6: Sales Trend Analysis Using Aggregations (Superstore Dataset)

## Objective
Analyze **monthly revenue** and **order volume** from the Superstore dataset using SQL aggregation functions.  
This task helps understand **time-based sales trends** and how to group data effectively.

## Tools Used
- **MySQL Workbench** 

## Steps Performed
1. **Extract Month & Year** from `Order Date` using `EXTRACT()` / `STRFTIME()`.
2. **Group Data** by year and month to aggregate values.
3. Calculate:
   - `SUM(Sales)` → **Total Revenue**
   - `COUNT(DISTINCT Order ID)` → **Order Volume**
4. **Sort Results** using `ORDER BY` for chronological trends.
5. **Filter by Date Range** using `WHERE` for specific periods.
6. Added **extra business metrics**:
   - Region
   - Category
   - Total Quantity Sold
   - Total Profit
  
##  Repository Structure
| File Name                | Description |
|--------------------------|-------------|
| `sales_trend_analysis.sql` | SQL script containing all steps and queries with comments |
| `sales_trend_results.csv`  | Output file showing aggregated monthly sales results |
| `Superstore.csv`           | Dataset used for analysis |
| `README.md`                | Documentation for the task |

##  Example Query
```sql
SELECT 
    EXTRACT(YEAR FROM TO_DATE("Order Date", 'MM/DD/YYYY')) AS order_year,
    EXTRACT(MONTH FROM TO_DATE("Order Date", 'MM/DD/YYYY')) AS order_month,
    Region,
    Category,
    SUM(Sales) AS total_revenue,
    COUNT(DISTINCT "Order ID") AS order_volume,
    SUM(Quantity) AS total_quantity,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY order_year, order_month, Region, Category
ORDER BY order_year, order_month, Region, Category;





