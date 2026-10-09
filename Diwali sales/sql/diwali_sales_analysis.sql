-- ============================================
-- DIWALI SALES ANALYSIS
-- SQL ANALYSIS PROJECT
-- Database: diwali_sales_db
-- Table: diwali_sales
-- ============================================

USE diwali_sales_db;


-- ============================================
-- 1. DATA VALIDATION
-- ============================================

SELECT COUNT(*) AS Total_Rows
FROM diwali_sales;

SELECT *
FROM diwali_sales
LIMIT 5;


-- ============================================
-- 2. KEY PERFORMANCE INDICATORS (KPIs)
-- ============================================

-- Total Revenue
SELECT
    SUM(Amount) AS Total_Revenue
FROM diwali_sales;

-- Total Orders
SELECT
    SUM(Orders) AS Total_Orders
FROM diwali_sales;

-- Average Order Value
SELECT
    ROUND(SUM(Amount) / SUM(Orders), 2) AS Average_Order_Value
FROM diwali_sales;

-- Unique Customers
SELECT
    COUNT(DISTINCT User_ID) AS Unique_Customers
FROM diwali_sales;


-- ============================================
-- 3. CUSTOMER ANALYSIS
-- ============================================

-- Revenue by Gender
SELECT
    Gender,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Gender
ORDER BY Total_Revenue DESC;


-- Revenue by Age Group
SELECT
    `Age Group`,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY `Age Group`
ORDER BY Total_Revenue DESC;


-- Revenue by Occupation
SELECT
    Occupation,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Occupation
ORDER BY Total_Revenue DESC;


-- Gender-wise Customer and Revenue Analysis
SELECT
    Gender,
    COUNT(DISTINCT User_ID) AS Unique_Customers,
    SUM(Amount) AS Total_Revenue,
    AVG(Amount) AS Average_Sale_Amount
FROM diwali_sales
GROUP BY Gender
ORDER BY Total_Revenue DESC;


-- ============================================
-- 4. GEOGRAPHIC ANALYSIS
-- ============================================

-- Top 10 States by Revenue
SELECT
    State,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY State
ORDER BY Total_Revenue DESC
LIMIT 10;


-- Top 10 States by Orders
SELECT
    State,
    SUM(Orders) AS Total_Orders
FROM diwali_sales
GROUP BY State
ORDER BY Total_Orders DESC
LIMIT 10;


-- Revenue by Zone
SELECT
    Zone,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Zone
ORDER BY Total_Revenue DESC;


-- ============================================
-- 5. PRODUCT ANALYSIS
-- ============================================

-- Revenue by Product Category
SELECT
    Product_Category,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;


-- Orders by Product Category
SELECT
    Product_Category,
    SUM(Orders) AS Total_Orders
FROM diwali_sales
GROUP BY Product_Category
ORDER BY Total_Orders DESC;


-- Top 10 Products by Revenue
SELECT
    Product_ID,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Product_ID
ORDER BY Total_Revenue DESC
LIMIT 10;


-- ============================================
-- 6. CROSS ANALYSIS
-- ============================================

-- Gender × Product Category
SELECT
    Gender,
    Product_Category,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY Gender, Product_Category
ORDER BY Total_Revenue DESC;


-- Age Group × Product Category
SELECT
    `Age Group`,
    Product_Category,
    SUM(Amount) AS Total_Revenue
FROM diwali_sales
GROUP BY `Age Group`, Product_Category
ORDER BY Total_Revenue DESC;


-- ============================================
-- 7. CUSTOMER SEGMENTATION
-- ============================================

-- Segment customers according to spending
SELECT
    User_ID,
    SUM(Amount) AS Total_Spending,
    CASE
        WHEN SUM(Amount) >= 10000 THEN 'High Value'
        WHEN SUM(Amount) >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Segment
FROM diwali_sales
GROUP BY User_ID
ORDER BY Total_Spending DESC;


-- ============================================
-- 8. CUSTOMER SEGMENT SUMMARY
-- ============================================

SELECT
    Customer_Segment,
    COUNT(*) AS Customer_Count,
    SUM(Total_Spending) AS Segment_Revenue
FROM
(
    SELECT
        User_ID,
        SUM(Amount) AS Total_Spending,
        CASE
            WHEN SUM(Amount) >= 10000 THEN 'High Value'
            WHEN SUM(Amount) >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM diwali_sales
    GROUP BY User_ID
) AS customer_segments
GROUP BY Customer_Segment
ORDER BY Segment_Revenue DESC;


-- ============================================
-- 9. CUSTOMER SEGMENT REVENUE SHARE
-- ============================================

SELECT
    Customer_Segment,
    COUNT(*) AS Customer_Count,
    ROUND(SUM(Segment_Revenue), 2) AS Segment_Revenue,
    ROUND(
        SUM(Segment_Revenue) * 100 /
        (SELECT SUM(Amount) FROM diwali_sales),
        2
    ) AS Revenue_Share_Percent
FROM
(
    SELECT
        User_ID,
        SUM(Amount) AS Segment_Revenue,
        CASE
            WHEN SUM(Amount) >= 10000 THEN 'High Value'
            WHEN SUM(Amount) >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM diwali_sales
    GROUP BY User_ID
) AS customer_segments
GROUP BY Customer_Segment
ORDER BY Segment_Revenue DESC;


-- ============================================
-- END OF SQL ANALYSIS
-- ============================================