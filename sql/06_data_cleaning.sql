USE ipo_analysis;

SELECT 'Missing IPO name' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE ipo_name IS NULL OR TRIM(ipo_name) = '';

SELECT 'Missing IPO date' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE ipo_date IS NULL;

SELECT 'Missing subscriptions' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE total_subscription IS NULL
   OR qib_subscription IS NULL
   OR hni_subscription IS NULL
   OR rii_subscription IS NULL;

SELECT ipo_name, ipo_date, COUNT(*) AS duplicate_count
FROM ipo_data
GROUP BY ipo_name, ipo_date
HAVING COUNT(*) > 1;

SELECT 'Negative issue size' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE issue_size_crores < 0;

SELECT 'Negative offer price' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE offer_price < 0;

SELECT 'Negative listing price' AS check_name, COUNT(*) AS issue_count
FROM ipo_data
WHERE list_price < 0;

WITH ranked_current_gains AS (
  SELECT ipo_name, current_gains,
         ROW_NUMBER() OVER (ORDER BY current_gains DESC) AS rn,
         COUNT(*) OVER () AS total_rows
  FROM ipo_data
  WHERE current_gains IS NOT NULL
)
SELECT ipo_name, current_gains
FROM ranked_current_gains
WHERE rn <= CEIL(total_rows * 0.95)
ORDER BY current_gains DESC;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN ipo_name IS NULL OR TRIM(ipo_name) = '' THEN 1 ELSE 0 END) AS missing_ipo_name,
  SUM(CASE WHEN ipo_date IS NULL THEN 1 ELSE 0 END) AS missing_ipo_date,
  SUM(CASE WHEN total_subscription IS NULL THEN 1 ELSE 0 END) AS missing_total,
  SUM(CASE WHEN current_gains IS NULL THEN 1 ELSE 0 END) AS missing_current_gains
FROM ipo_data;
