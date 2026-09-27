-- ============================================================
-- BUSINESS OPERATIONS PERFORMANCE ANALYSIS
-- SQL Analysis
-- ============================================================

-- 1. View the dataset
SELECT *
FROM business_operations;


-- 2. Total Revenue
SELECT
    SUM(Revenue) AS Total_Revenue
FROM business_operations;


-- 3. Total Orders
SELECT
    COUNT(Order_ID) AS Total_Orders
FROM business_operations;


-- 4. Average Order Value
SELECT
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM business_operations;


-- 5. Revenue by Product Category
SELECT
    Product_Category,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM business_operations
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;


-- 6. Revenue by Region
SELECT
    Region,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM business_operations
GROUP BY Region
ORDER BY Total_Revenue DESC;


-- 7. Revenue by Customer Segment
SELECT
    Customer_Segment,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM business_operations
GROUP BY Customer_Segment
ORDER BY Total_Revenue DESC;


-- 8. Cancellation Rate
SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(Order_ID),
        2
    ) AS Cancellation_Rate_Percent
FROM business_operations;


-- 9. Cancellation Reasons
SELECT
    Cancellation_Reason,
    COUNT(*) AS Cancelled_Orders
FROM business_operations
WHERE Order_Status = 'Cancelled'
GROUP BY Cancellation_Reason
ORDER BY Cancelled_Orders DESC;


-- 10. Average Processing Time
SELECT
    ROUND(AVG(Processing_Time_Days), 2) AS Average_Processing_Time_Days
FROM business_operations;


-- 11. Processing Time by Product Category
SELECT
    Product_Category,
    ROUND(AVG(Processing_Time_Days), 2) AS Average_Processing_Time_Days
FROM business_operations
GROUP BY Product_Category
ORDER BY Average_Processing_Time_Days DESC;


-- 12. On-Time Delivery Rate
SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN On_Time_Flag = 'Yes' THEN 1 ELSE 0 END
        ) /
        NULLIF(
            SUM(CASE WHEN On_Time_Flag IN ('Yes', 'No') THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS On_Time_Rate_Percent
FROM business_operations;


-- 13. Monthly Revenue Trend
SELECT
    SUBSTRING(Order_Date, 1, 7) AS Order_Month,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM business_operations
GROUP BY SUBSTRING(Order_Date, 1, 7)
ORDER BY Order_Month;


-- 14. Sales Representative Performance
SELECT
    Sales_Rep,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM business_operations
GROUP BY Sales_Rep
ORDER BY Total_Revenue DESC;


-- 15. Identify High-Value Orders
SELECT
    Order_ID,
    Order_Date,
    Product_Category,
    Region,
    Customer_Segment,
    Revenue
FROM business_operations
WHERE Revenue >= 7500
ORDER BY Revenue DESC;
