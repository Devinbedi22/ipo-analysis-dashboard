USE ipo_analysis;

SELECT COUNT(*) AS total_ipos
FROM ipo_data;

SELECT ROUND(AVG(listing_gain), 2) AS avg_listing_gain
FROM ipo_data
WHERE listing_gain IS NOT NULL;

SELECT ROUND(AVG(current_gains), 2) AS avg_current_gain
FROM ipo_data
WHERE current_gains IS NOT NULL;

SELECT ROUND(AVG(offer_price), 2) AS avg_offer_price
FROM ipo_data
WHERE offer_price IS NOT NULL;

SELECT ipo_name, issue_size_crores
FROM ipo_data
ORDER BY issue_size_crores DESC
LIMIT 1;

SELECT ipo_name, total_subscription
FROM ipo_data
ORDER BY total_subscription DESC
LIMIT 1;

SELECT ipo_name, total_subscription
FROM ipo_data
ORDER BY total_subscription ASC
LIMIT 1;

SELECT ROUND(AVG(qib_subscription), 2) AS avg_qib_subscription
FROM ipo_data
WHERE qib_subscription IS NOT NULL;

SELECT ROUND(AVG(hni_subscription), 2) AS avg_hni_subscription
FROM ipo_data
WHERE hni_subscription IS NOT NULL;

SELECT ROUND(AVG(rii_subscription), 2) AS avg_rii_subscription
FROM ipo_data
WHERE rii_subscription IS NOT NULL;

SELECT ipo_name, total_subscription
FROM ipo_data
WHERE total_subscription > (
  SELECT AVG(total_subscription)
  FROM ipo_data
  WHERE total_subscription IS NOT NULL
)
ORDER BY total_subscription DESC;

SELECT ipo_name, ipo_date, listing_gain, offer_price, list_price
FROM ipo_data
WHERE listing_gain IS NOT NULL
ORDER BY listing_gain DESC
LIMIT 10;

SELECT ipo_name, ipo_date, listing_gain, offer_price, list_price
FROM ipo_data
WHERE listing_gain IS NOT NULL
ORDER BY listing_gain ASC
LIMIT 10;

SELECT ipo_name, ipo_date, offer_price, list_price,
       (list_price - offer_price) AS premium_amount
FROM ipo_data
WHERE list_price > offer_price
ORDER BY premium_amount DESC
LIMIT 10;

SELECT ipo_name, ipo_date, offer_price, list_price,
       (offer_price - list_price) AS discount_amount
FROM ipo_data
WHERE list_price < offer_price
ORDER BY discount_amount DESC
LIMIT 10;

SELECT ipo_name, ipo_date, current_gains
FROM ipo_data
WHERE current_gains > 0
ORDER BY current_gains DESC
LIMIT 10;

SELECT ipo_name, ipo_date, current_gains
FROM ipo_data
WHERE current_gains < 0
ORDER BY current_gains ASC
LIMIT 10;

WITH return_stats AS (
  SELECT AVG((current_gains / offer_price) * 100) AS avg_return_pct
  FROM ipo_data
  WHERE offer_price > 0
    AND current_gains IS NOT NULL
)
SELECT ipo_name, offer_price, current_gains,
       ROUND(((current_gains / offer_price) * 100), 2) AS return_pct
FROM ipo_data, return_stats
WHERE offer_price > 0
  AND current_gains IS NOT NULL
  AND ((current_gains / offer_price) * 100) > avg_return_pct
ORDER BY return_pct DESC;

SELECT ipo_name, ipo_date, current_gains,
       ROW_NUMBER() OVER (ORDER BY current_gains DESC) AS gain_rank
FROM ipo_data
WHERE current_gains IS NOT NULL
ORDER BY current_gains DESC;

SELECT ipo_name, ipo_date, listing_gain,
       RANK() OVER (ORDER BY listing_gain DESC) AS listing_rank
FROM ipo_data
WHERE listing_gain IS NOT NULL
ORDER BY listing_rank, ipo_name;

SELECT YEAR(ipo_date) AS ipo_year,
       ipo_name,
       listing_gain,
       DENSE_RANK() OVER (
         PARTITION BY YEAR(ipo_date) ORDER BY listing_gain DESC
       ) AS listing_rank
FROM ipo_data
WHERE listing_gain IS NOT NULL
ORDER BY ipo_year, listing_rank, ipo_name;

SELECT ipo_name, current_gains
FROM ipo_data
WHERE current_gains > (
  SELECT AVG(current_gains)
  FROM ipo_data
  WHERE current_gains IS NOT NULL
)
ORDER BY current_gains DESC;

WITH ranked_ipos AS (
  SELECT ipo_name,
         total_subscription,
         current_gains,
         RANK() OVER (ORDER BY total_subscription DESC) AS sub_rank
  FROM ipo_data
  WHERE total_subscription IS NOT NULL
)
SELECT ipo_name, total_subscription, current_gains
FROM ranked_ipos
WHERE sub_rank <= 10
ORDER BY total_subscription DESC;

SELECT YEAR(ipo_date) AS ipo_year,
       COUNT(*) AS ipo_count,
       ROUND(AVG(total_subscription), 2) AS avg_subscription,
       ROUND(AVG(current_gains), 2) AS avg_current_gain
FROM ipo_data
GROUP BY YEAR(ipo_date)
HAVING COUNT(*) >= 5
ORDER BY ipo_year;

SELECT CASE
         WHEN current_gains > 0 THEN 'Profitable'
         ELSE 'Not Profitable'
       END AS gain_bucket,
       COUNT(*) AS ipo_count,
       ROUND(AVG(total_subscription), 2) AS avg_subscription
FROM ipo_data
GROUP BY gain_bucket
ORDER BY ipo_count DESC;
