CREATE DATABASE IF NOT EXISTS ipo_analysis
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ipo_analysis;

CREATE TABLE IF NOT EXISTS ipo_data (
  ipo_date DATE NOT NULL,
  ipo_name VARCHAR(255) NOT NULL,
  issue_size_crores DECIMAL(12,2) NULL,
  qib_subscription DECIMAL(10,2) NULL,
  hni_subscription DECIMAL(10,2) NULL,
  rii_subscription DECIMAL(10,2) NULL,
  total_subscription DECIMAL(10,2) NULL,
  offer_price DECIMAL(12,2) NULL,
  list_price DECIMAL(12,2) NULL,
  listing_gain DECIMAL(12,2) NULL,
  cmp_bse DECIMAL(12,2) NULL,
  cmp_nse DECIMAL(12,2) NULL,
  current_gains DECIMAL(12,2) NULL,
  PRIMARY KEY (ipo_date, ipo_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
