USE ipo_analysis;

DELIMITER $$

CREATE PROCEDURE get_top_n_ipos(IN p_limit INT)
BEGIN
  SELECT ipo_name, ipo_date, current_gains, listing_gain, total_subscription
  FROM ipo_data
  WHERE current_gains IS NOT NULL
  ORDER BY current_gains DESC
  LIMIT p_limit;
END$$

CREATE PROCEDURE search_ipo(IN p_keyword VARCHAR(255))
BEGIN
  SELECT ipo_name, ipo_date, total_subscription, current_gains, listing_gain
  FROM ipo_data
  WHERE LOWER(ipo_name) LIKE CONCAT('%', LOWER(p_keyword), '%')
  ORDER BY ipo_date DESC;
END$$

CREATE PROCEDURE ipo_performance(IN p_ipo_name VARCHAR(255))
BEGIN
  SELECT ipo_name, ipo_date, issue_size_crores, offer_price, list_price,
         listing_gain, current_gains, total_subscription, qib_subscription,
         hni_subscription, rii_subscription
  FROM ipo_data
  WHERE ipo_name = p_ipo_name;
END$$

CREATE PROCEDURE subscription_analysis(IN p_min_total DECIMAL(10,2))
BEGIN
  SELECT ipo_name, ipo_date, total_subscription, qib_subscription, hni_subscription,
         rii_subscription, current_gains
  FROM ipo_data
  WHERE total_subscription >= p_min_total
  ORDER BY total_subscription DESC, current_gains DESC;
END$$

CREATE PROCEDURE dashboard_kpis()
BEGIN
  SELECT
    COUNT(*) AS total_ipos,
    ROUND(AVG(listing_gain), 2) AS avg_listing_gain,
    ROUND(AVG(current_gains), 2) AS avg_current_gain,
    ROUND(AVG(total_subscription), 2) AS avg_subscription
  FROM ipo_data;
END$$

CREATE PROCEDURE yearly_ipo_analysis()
BEGIN
  SELECT
    YEAR(ipo_date) AS ipo_year,
    COUNT(*) AS ipo_count,
    ROUND(AVG(total_subscription), 2) AS avg_subscription,
    ROUND(AVG(current_gains), 2) AS avg_current_gain
  FROM ipo_data
  GROUP BY YEAR(ipo_date)
  ORDER BY ipo_year;
END$$

DELIMITER ;
