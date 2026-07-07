USE ipo_analysis;

CREATE OR REPLACE VIEW vw_top_performing_ipos AS
SELECT
  ipo_name,
  ipo_date,
  current_gains,
  listing_gain,
  total_subscription
FROM ipo_data
WHERE current_gains IS NOT NULL;

CREATE OR REPLACE VIEW vw_high_subscription_ipos AS
SELECT
  ipo_name,
  ipo_date,
  total_subscription,
  qib_subscription,
  hni_subscription,
  rii_subscription,
  current_gains
FROM ipo_data
WHERE total_subscription >= 10;

CREATE OR REPLACE VIEW vw_loss_making_ipos AS
SELECT
  ipo_name,
  ipo_date,
  listing_gain,
  current_gains,
  total_subscription
FROM ipo_data
WHERE listing_gain < 0 OR current_gains < 0;

CREATE OR REPLACE VIEW vw_ipo_performance_summary AS
SELECT
  YEAR(ipo_date) AS ipo_year,
  COUNT(*) AS ipo_count,
  ROUND(AVG(total_subscription), 2) AS avg_subscription,
  ROUND(AVG(current_gains), 2) AS avg_current_gain,
  ROUND(AVG(listing_gain), 2) AS avg_listing_gain
FROM ipo_data
GROUP BY YEAR(ipo_date);

CREATE OR REPLACE VIEW vw_premium_ipos AS
SELECT
  ipo_name,
  ipo_date,
  offer_price,
  list_price,
  (list_price - offer_price) AS premium_amount,
  ROUND(((list_price - offer_price) / offer_price) * 100, 2) AS premium_pct
FROM ipo_data
WHERE offer_price > 0
  AND list_price > offer_price;

CREATE OR REPLACE VIEW vw_dashboard_kpis AS
SELECT
  COUNT(*) AS total_ipos,
  ROUND(AVG(listing_gain), 2) AS avg_listing_gain,
  ROUND(AVG(current_gains), 2) AS avg_current_gain,
  ROUND(AVG(total_subscription), 2) AS avg_subscription,
  SUM(CASE WHEN list_price > offer_price THEN 1 ELSE 0 END) AS premium_listings,
  SUM(CASE WHEN list_price < offer_price THEN 1 ELSE 0 END) AS discount_listings
FROM ipo_data;

CREATE OR REPLACE VIEW vw_subscription_summary AS
SELECT
  ROUND(AVG(total_subscription), 2) AS avg_total_subscription,
  ROUND(AVG(qib_subscription), 2) AS avg_qib_subscription,
  ROUND(AVG(hni_subscription), 2) AS avg_hni_subscription,
  ROUND(AVG(rii_subscription), 2) AS avg_rii_subscription,
  MAX(total_subscription) AS highest_subscription,
  MIN(total_subscription) AS lowest_subscription
FROM ipo_data;
