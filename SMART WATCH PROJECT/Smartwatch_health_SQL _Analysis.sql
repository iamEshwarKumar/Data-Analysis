SELECT * FROM "Cleaned_smart_watch";

--Basic Health Summary --
SELECT
    AVG("Heart Rate (BPM)") AS "Average Heart Rate",
    AVG("Blood Oxygen Level (%)") AS "Average Blood Oxygen",
    SUM("Step Count") AS "Total Step Count",
    AVG("Sleep Duration (hours)") AS "Average Sleep Duration",
    AVG("Stress Level") AS "Average Stress Level"
FROM
    "Cleaned_smart_watch";

-- Activity and Fitness Analysis--
SELECT
    "Activity Level",
    AVG("Step Count") AS "Average Steps",
    AVG("Heart Rate (BPM)") AS "Average Heart Rate"
FROM
    "Cleaned_smart_watch"
GROUP BY
    "Activity Level"
ORDER BY
    "Average Steps" DESC;
	
--The number of users in each activity level --
SELECT
    "Activity Level",
    COUNT(DISTINCT "User ID") AS "NumberOfUsers"
FROM
    "Cleaned_smart_watch"
GROUP BY
    "Activity Level";

--Sleep Analysis--
SELECT
    "Sleep Quality",
    AVG("Sleep Duration (hours)") AS "Average Sleep Duration",
    AVG("Stress Level") AS "Average Stress Level"
FROM
    "Cleaned_smart_watch"
GROUP BY
    "Sleep Quality";

-- Stress and Well-being Analysis -- 
SELECT
    CASE
        WHEN "Stress Level" >= 7 THEN 'High Stress'
        WHEN "Stress Level" <= 3 THEN 'Low Stress'
        ELSE 'Moderate Stress'
    END AS "StressCategory",
    COUNT("User ID") AS "NumberOfUsers",
    AVG("Heart Rate (BPM)") AS "Average Heart Rate"
FROM
    "Cleaned_smart_watch"
GROUP BY
    "StressCategory";

--users with higher-than-average stress and lower-than-average sleep--
WITH UserAverages AS (
    SELECT
        "User ID",
        AVG("Stress Level") as "AvgStress",
        AVG("Sleep Duration (hours)") as "AvgSleep"
    FROM
        "Cleaned_smart_watch"
    GROUP BY
        "User ID"
)
SELECT
    "User ID",
    "AvgStress",
    "AvgSleep"
FROM
    UserAverages
WHERE
    "AvgStress" > (SELECT AVG("Stress Level") FROM "Cleaned_smart_watch")
    AND "AvgSleep" < (SELECT AVG("Sleep Duration (hours)") FROM "Cleaned_smart_watch");

--Identifying Outliers and Extreme Values-- 
WITH Stats AS (
    SELECT
        AVG("Heart Rate (BPM)") as AvgHeartRate,
        STDDEV("Heart Rate (BPM)") as StdevHeartRate, -- Corrected function name
        AVG("Blood Oxygen Level (%)") as AvgBloodOxygen,
        STDDEV("Blood Oxygen Level (%)") as StdevBloodOxygen -- Corrected function name
    FROM
        "Cleaned_smart_watch"
)
SELECT
    "User ID",
    "Heart Rate (BPM)",
    "Blood Oxygen Level (%)"
FROM
    "Cleaned_smart_watch", Stats
WHERE
    "Heart Rate (BPM)" > Stats.AvgHeartRate + (3 * Stats.StdevHeartRate)
    OR "Blood Oxygen Level (%)" < Stats.AvgBloodOxygen - (3 * Stats.StdevBloodOxygen);

-- Ranking Users by Performance -- 
WITH UserAverageSteps AS (
    SELECT
        "User ID",
        AVG("Step Count") as "AverageSteps"
    FROM
        "Cleaned_smart_watch"
    GROUP BY
        "User ID"
)
SELECT
    "User ID",
    "AverageSteps",
    RANK() OVER (ORDER BY "AverageSteps" DESC) AS "StepRank"
FROM
    UserAverageSteps;