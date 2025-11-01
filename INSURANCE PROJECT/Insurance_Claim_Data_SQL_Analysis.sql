SELECT *FROM "Insurance_Claim_Data" ;

--Total Claims by State--
SELECT incident_state, SUM(total_claim_amount) AS total_claims
FROM "Insurance_Claim_Data"
GROUP BY incident_state
ORDER BY total_claims DESC;

--Policy Premium Statistics--
SELECT AVG(policy_annual_premium) AS avg_premium, MIN(policy_annual_premium), MAX(policy_annual_premium)
FROM insurance_claims;

--Number of Fraud Cases--
SELECT COUNT(*) AS fraud_cases
FROM insurance_claims
WHERE fraud_reported = 'Y';

--Risk and Fraud Analysis--
SELECT incident_severity, AVG(total_claim_amount) AS avg_claim_amount, COUNT(*) AS claim_count
FROM "Insurance_Claim_Data"
GROUP BY incident_severity;

--Fraud Reporting by Vehicle Make--
SELECT auto_make, COUNT(*) AS fraud_count
FROM "Insurance_Claim_Data"
WHERE fraud_reported = 'Y'
GROUP BY auto_make
ORDER BY fraud_count DESC;

--Distribution of Educational Level among Claimants--
SELECT insured_education_level, COUNT(*) AS claim_count
FROM "Insurance_Claim_Data"
GROUP BY insured_education_level
ORDER BY claim_count DESC;

--Claims per Occupation--
SELECT insured_occupation, SUM(total_claim_amount) AS total_claims
FROM "Insurance_Claim_Data"
GROUP BY insured_occupation
ORDER BY total_claims DESC;

--Claims by Hour of Incident--
SELECT incident_hour_of_the_day, COUNT(*) AS num_claims
FROM "Insurance_Claim_Data"
GROUP BY incident_hour_of_the_day
ORDER BY incident_hour_of_the_day;

--Claims Trend by Month--
SELECT TO_CHAR(TO_DATE(incident_date, 'DD-MM-YYYY'), 'YYYY-MM') AS claim_month, COUNT(*) AS num_claims
FROM "Insurance_Claim_Data"
GROUP BY claim_month
ORDER BY claim_month;

--Impact of Witness Presence on Fraud Reporting--
SELECT witnesses, COUNT(*) AS total, SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases
FROM "Insurance_Claim_Data"
GROUP BY witnesses;

--Get sample claim details--
SELECT policy_number, insured_sex, incident_type, total_claim_amount, fraud_reported
FROM "Insurance_Claim_Data"
LIMIT 10;

-- Top Incident Types by Claim Amount--
SELECT incident_type, SUM(total_claim_amount) AS total_claims
FROM "Insurance_Claim_Data"
GROUP BY incident_type
ORDER BY total_claims DESC;

--Average Claim Amount by Vehicle Make/Model--
SELECT auto_make, auto_model, AVG(total_claim_amount) AS avg_claim
FROM "Insurance_Claim_Data"
GROUP BY auto_make, auto_model
ORDER BY avg_claim DESC
LIMIT 10;

-- Common Collision Types Leading to Major Damage--
SELECT collision_type, COUNT(*) AS occurrences
FROM "Insurance_Claim_Data"
WHERE incident_severity = 'Major Damage'
GROUP BY collision_type
ORDER BY occurrences DESC;

--Highest Injury Claims by Occupation--
SELECT insured_occupation, SUM(injury_claim) AS total_injury_claims
FROM "Insurance_Claim_Data"
GROUP BY insured_occupation
ORDER BY total_injury_claims DESC
LIMIT 10;

--Relationship Between Witnesses and Fraud Detection--
SELECT witnesses,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_cases,
       COUNT(*) AS total_cases,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 1) AS fraud_pct
FROM "Insurance_Claim_Data"
GROUP BY witnesses
ORDER BY fraud_pct DESC;

--Largest Individual Claims--
SELECT policy_csl, insured_sex, total_claim_amount, incident_date
FROM "Insurance_Claim_Data"
ORDER BY total_claim_amount DESC
LIMIT 10;

-- Claim Amount by Education Level--
SELECT insured_education_level, AVG(total_claim_amount) AS avg_claim
FROM "Insurance_Claim_Data"
GROUP BY insured_education_level
ORDER BY avg_claim DESC;






