SELECT * FROM "Ecommerce_Data";

--Average Service Rating--
SELECT AVG("Service Rating") FROM "Ecommerce_Data";

--Average Delivery Time -- 
SELECT AVG("Delivery Time (Minutes)") FROM "Ecommerce_Data";

--Total Order value--
SELECT SUM ("Order Value (INR)") FROM "Ecommerce_Data"; 

--Complete Blinkit Data -- 
SELECT * FROM "Ecommerce_Data" AS e
WHERE e."Platform" = 'Blinkit';

--Complete Swiggy Data--
SELECT * FROM "Ecommerce_Data" AS e
WHERE e."Platform" = 'Swiggy Instamart';

--Complete Jiomart Data --
SELECT * FROM "Ecommerce_Data" AS e
WHERE e."Platform" = 'JioMart'

--Total Order Value by Platform --
SELECT e."Platform", SUM(e."Order Value (INR)") AS total_value
FROM "Ecommerce_Data" AS e
WHERE e."Order Value (INR)" > 0
GROUP BY e."Platform"
ORDER BY total_value DESC;

--Refund value by Platform --
SELECT e."Platform", SUM(e."Order Value (INR)") AS refund_value
FROM "Ecommerce_Data" AS e
WHERE e."Refund Requested" = 'Yes'
GROUP BY e."Platform"
ORDER BY refund_value DESC;

--Revenue by category of each platform  -- 
SELECT e."Platform",e."Product Category", SUM(e."Order Value (INR)") AS Revenue_by_Category
FROM "Ecommerce_Data" AS e
GROUP BY e."Platform", e."Product Category"
ORDER BY Revenue_by_Category DESC;

-- Total customers for individual product category -- 
SELECT e."Platform", e."Product Category", COUNT(*) AS Total_customers
FROM "Ecommerce_Data" AS e
GROUP BY e."Platform", e."Product Category"
ORDER BY e."Platform", e."Product Category";

-- Overall business health -- 
SELECT "Platform",COUNT(*) AS total_orders,
    SUM("Order Value (INR)") AS total_revenue,
    AVG("Order Value (INR)") AS average_order_value,
    AVG("Delivery Time (Minutes)") AS average_delivery_time,
    AVG("Service Rating") AS average_service_rating
FROM "Ecommerce_Data"
GROUP BY "Platform";

-- Platform Performance Breakdown--
SELECT
    "Platform",
    SUM("Order Value (INR)") AS total_revenue,
    COUNT("Order ID") AS number_of_orders,
    AVG("Delivery Time (Minutes)") AS avg_delivery_time,
    AVG("Service Rating") AS avg_service_rating,
    -- Calculate the percentage of orders that requested a refund
    (SUM(CASE 
	WHEN "Refund Requested" = 'Yes' THEN 1 
	ELSE 0 END) * 100.0 / COUNT("Order ID"))
	AS refund_rate_percent
FROM "Ecommerce_Data"
GROUP BY "Platform"
ORDER BY total_revenue DESC;

--Total Orders and Total revenue by Product category --
SELECT
    "Product Category",
    SUM("Order Value (INR)") AS total_revenue,
    COUNT("Order ID") AS number_of_orders
FROM "Ecommerce_Data"
GROUP BY "Product Category"
ORDER BY total_revenue DESC
LIMIT 6;

--Overall Average Service Rating -- 
SELECT  "Platform","Delivery Delay", ROUND(AVG("Service Rating"),2) AS average_service_rating
FROM "Ecommerce_Data"
GROUP BY "Delivery Delay","Platform"
ORDER BY "Delivery Delay","Platform" DESC;

-- Total Orders and Total Spent by a customer
SELECT
    "Customer ID",
    COUNT("Order ID") AS number_of_orders,
    SUM("Order Value (INR)") AS total_spent
FROM "Ecommerce_Data"
GROUP BY "Customer ID"
HAVING COUNT("Order ID") > 1
ORDER BY number_of_orders DESC;

--What do  'High Value' customers buy -- 
WITH HighValueCustomers AS (
    -- First, find the customers in the top 25% of spending
    SELECT "Customer ID"
    FROM "Ecommerce_Data"
    GROUP BY "Customer ID"
    ORDER BY SUM("Order Value (INR)") DESC
    LIMIT (SELECT COUNT(DISTINCT "Customer ID") / 4 FROM "Ecommerce_Data")
)
-- Now, find out what those customers are buying
SELECT
    e."Product Category",
    COUNT(*) AS number_of_orders
FROM "Ecommerce_Data" e
JOIN HighValueCustomers hvc ON e."Customer ID" = hvc."Customer ID"
GROUP BY e."Product Category"
ORDER BY number_of_orders DESC;

-- percentage of revenue lost to refunds -- 	
SELECT
    "Platform",
    SUM("Order Value (INR)") AS total_revenue,
    SUM(CASE WHEN "Refund Requested" = 'Yes' THEN "Order Value (INR)" ELSE 0 END) AS total_refund_value,
    -- Calculate the percentage of revenue that was refunded
    (SUM(CASE WHEN "Refund Requested" = 'Yes' THEN "Order Value (INR)" ELSE 0 END) * 100.0 / SUM("Order Value (INR)")) AS percent_revenue_refunded
FROM "Ecommerce_Data"
GROUP BY "Platform"
ORDER BY percent_revenue_refunded DESC;

--Rank Product Categories Within Each Platform --
SELECT
    "Platform",
    "Product Category",
    total_revenue,
    RANK() OVER(PARTITION BY "Platform" ORDER BY total_revenue DESC) as category_rank
FROM (
    SELECT
        "Platform",
        "Product Category",
        SUM("Order Value (INR)") AS total_revenue
    FROM "Ecommerce_Data"
    GROUP BY "Platform", "Product Category"
) AS category_revenue;









