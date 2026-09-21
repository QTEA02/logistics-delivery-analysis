USE LogisticsAnalysis;
GO

-- 1. Overall delay rate
-- Calculates the total number of deliveries, delayed deliveries,
-- and the percentage of deliveries that were delayed.
SELECT
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries;


-- 2. Delay rate by weather condition
-- Compares delay rates across different weather conditions
-- to determine whether weather is associated with delivery delays.
SELECT
    weather_condition,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY weather_condition
ORDER BY delay_rate_pct DESC;


-- 3. Delay rate by distance group
-- Measures how delay rates change as delivery distance increases.
SELECT
    distance_group,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY distance_group
ORDER BY delay_rate_pct DESC;


-- 4. Delay rate by vehicle type
-- Checks whether certain vehicle types experience higher delay rates.
SELECT
    vehicle_type,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY vehicle_type
ORDER BY delay_rate_pct DESC;


-- 5. Delay rate by region
-- Compares delivery performance across geographic regions.
SELECT
    region,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY region
ORDER BY delay_rate_pct DESC;


-- 6. Delay rate by package type
-- Determines whether the type of package is associated with delivery delays.
SELECT
    package_type,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY package_type
ORDER BY delay_rate_pct DESC;


-- 7. Average customer rating by delay status
-- Compares customer ratings for delayed and non-delayed deliveries
-- to measure the relationship between delays and customer satisfaction.
SELECT
    delayed,
    COUNT(*) AS total_deliveries,
    CAST(
        AVG(CAST(delivery_rating AS DECIMAL(10,2)))
        AS DECIMAL(5,2)
    ) AS avg_delivery_rating
FROM dbo.deliveries
GROUP BY delayed;

-- 8. Delay rate by weather condition and distance group
-- Examines the combined effect of weather and delivery distance
-- to identify conditions associated with the highest delay rates.
SELECT
    weather_condition,
    distance_group,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) AS delayed_deliveries,
    CAST(
        100.0 * SUM(CASE WHEN delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_rate_pct
FROM dbo.deliveries
GROUP BY
    weather_condition,
    distance_group
ORDER BY delay_rate_pct DESC;


-- 9. Actual vs. expected delivery time by delay status
-- Compares actual and expected delivery times for delayed and non-delayed deliveries.
-- Zero-hour delivery records are excluded because they were flagged during data cleaning.
SELECT
    delayed,
    COUNT(*) AS total_deliveries,
    CAST(AVG(CAST(delivery_time_hours_clean AS DECIMAL(10,2)))
        AS DECIMAL(5,2)) AS avg_actual_hours,
    CAST(AVG(CAST(expected_time_hours_clean AS DECIMAL(10,2)))
        AS DECIMAL(5,2)) AS avg_expected_hours,
    CAST(
        AVG(
            CAST(delivery_time_hours_clean AS DECIMAL(10,2))
            - CAST(expected_time_hours_clean AS DECIMAL(10,2))
        )
        AS DECIMAL(5,2)
    ) AS avg_time_difference_hours
FROM dbo.deliveries
WHERE delivery_time_hours_clean > 0
GROUP BY delayed;