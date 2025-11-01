SELECT * FROM telco_customers;

-- Churn Rate for Customers with a Partner:

SELECT
    "Partner",
    "Churn",
    COUNT(*) AS customer_count
FROM
    telco_customers
GROUP BY
    "Partner", "Churn"
ORDER BY
    "Partner", "Churn";

	
--  Churn Rate for Customers with Dependents:
SELECT "Dependents", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "Dependents", "Churn"
ORDER BY "Dependents", "Churn";

-- Churn Rate for Senior Citizens:
SELECT "SeniorCitizen", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "SeniorCitizen", "Churn"
ORDER BY "SeniorCitizen", "Churn";

--Gender Distribution of Churn:
SELECT gender, COUNT(*) AS churned_customers
FROM telco_customers
WHERE "Churn" = 'Yes'
GROUP BY gender;

--Combined Effect of Partners and Dependents
SELECT "Partner", "Dependents", COUNT(*) AS churn_count
FROM telco_customers
WHERE "Churn" = 'Yes'
GROUP BY "Partner", "Dependents"
ORDER BY churn_count DESC;

--  Churn by Internet Service Type:
SELECT "InternetService", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "InternetService", "Churn"
ORDER BY "InternetService", customer_count DESC;

-- Impact of Having Phone Service:
SELECT "PhoneService", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "PhoneService", "Churn";

--Churn for Customers with Multiple Lines:
SELECT "MultipleLines", "Churn", COUNT(*) AS customer_count
FROM telco_customers
WHERE "PhoneService" = 'Yes'
GROUP BY "MultipleLines", "Churn";

--Impact of Online Security Service:
SELECT "OnlineSecurity", COUNT(*) AS churn_count
FROM telco_customers
WHERE "Churn" = 'Yes'
GROUP BY "OnlineSecurity"
ORDER BY churn_count DESC;

--Impact of Online Backup Service:
SELECT "OnlineBackup", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "OnlineBackup", "Churn";

--Impact of Device Protection Service:
SELECT "DeviceProtection", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "DeviceProtection", "Churn";

--Impact of Tech Support Service:
SELECT "TechSupport", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "TechSupport", "Churn";

--Impact of Streaming TV Service:
SELECT "StreamingTV", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "StreamingTV", "Churn";


--Impact of Streaming Movies Service:
SELECT "StreamingMovies", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "StreamingMovies", "Churn";


-- Churn by Contract Type:
SELECT "Contract", COUNT(*) AS churn_count
FROM telco_customers
WHERE "Churn" = 'Yes'
GROUP BY "Contract"
ORDER BY churn_count DESC;

--Churn by Payment Method:
SELECT "PaymentMethod", COUNT(*) AS churn_count
FROM telco_customers
WHERE "Churn" = 'Yes'
GROUP BY "PaymentMethod"
ORDER BY churn_count DESC;

--Average Tenure and Monthly Charges for Churned vs. Retained Customers:
SELECT
    "Churn",
    ROUND(AVG(tenure)::numeric, 1) AS average_tenure_months,
    ROUND(AVG("MonthlyCharges")::numeric, 2) AS average_monthly_charge
FROM
    telco_customers
GROUP BY
    "Churn";

-- Churn by Paperless Billing:
SELECT "PaperlessBilling", "Churn", COUNT(*) AS customer_count
FROM telco_customers
GROUP BY "PaperlessBilling", "Churn";

--Total Revenue Lost from Churned Customers:
SELECT ROUND(SUM("TotalCharges")::numeric, 2) AS total_revenue_lost
FROM telco_customers
WHERE "Churn" = 'Yes';

--Average Monthly Charge per Internet Service:
SELECT "InternetService", ROUND(AVG("MonthlyCharges")::numeric, 2) AS average_monthly_charge
FROM telco_customers
WHERE "InternetService" != 'No'
GROUP BY "InternetService";

-- Top 10 Highest-Value Customers Who Churned:
SELECT "customerID", "MonthlyCharges", "TotalCharges", tenure
FROM telco_customers
WHERE "Churn" = 'Yes'
ORDER BY "TotalCharges" DESC
LIMIT 10;












