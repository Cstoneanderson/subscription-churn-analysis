 -- Subscription Churn Analysis by Segment Over Time
 -- Author: Chelsea Stone
 -- Description: This project calculates churn rates for two customer segments (87 and 30) over Jan-Mar 2017
 
 -- Preview data
 SELECT *
 FROM subscriptions
 LIMIT 10;

-- Get overall date range
SELECT 
  MIN(subscription_start),
  MAX(subscription_end)
FROM subscriptions;

-- Step 1: Define time windows (Jan-Mar 2017)
WITH months AS (
  SELECT '2017-01-01' AS first_day, '2017-01-31' AS last_day
  UNION ALL
  SELECT '2017-02-01' AS first_day, '2017-02-28' AS last_day
  UNION ALL
  SELECT '2017-03-01' AS first_day, '2017-03-31' AS last_day
),

-- Step 2: Cross join each subscription to each month
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months
),

-- Step 3: Determine if user was active or canceled in each month by segment
status AS (
  SELECT 
    id, 
    first_day AS month,

    -- Active in segment 87
    CASE
      WHEN (subscription_start < first_day)
        AND (subscription_end > first_day OR (subscription_end IS NULL AND segment = 87)) 
        THEN 1 ELSE 0 
    END AS is_active_87,
    
    --Active in segment 30
    CASE
      WHEN (subscription_start < first_day)
        AND (subscription_end > first_day OR (subscription_end IS NULL AND segment = 30)) 
      THEN 1 ELSE 0 
    END AS is_active_30,

    -- Canceled in month, segment 87
    CASE
      WHEN subscription_end BETWEEN first_day AND last_day AND segment = 87
      THEN 1 ELSE 0
    END AS is_canceled_87,

    -- Canceled in month, segment 30
    CASE
      WHEN subscription_end BETWEEN first_day AND last_day AND segment = 30
      THEN 1 ELSE 0
    END AS is_canceled_30
  FROM cross_join
),

-- Step 4: Aggregate metrics
status_aggregate AS (
  SELECT
    month,
    SUM(is_active_87) AS sum_active_87,
    SUM(is_active_30) AS sum_active_30,
    SUM(is_canceled_87) AS sum_canceled_87,
    SUM(is_canceled_30) AS sum_canceled_30
  FROM status
  GROUP BY month
)

-- Step 5: Calculate churn rates by segment
SELECT 
  month,
  round(1.0 * sum_canceled_87 / sum_active_87, 4) AS churn_rate_87,
  round(1.0 * sum_canceled_30 / sum_active_30, 4) AS churn_rate_30
FROM status_aggregate;