USE ipo_analysis;

CREATE INDEX idx_ipo_data_ipo_name ON ipo_data (ipo_name);

CREATE INDEX idx_ipo_data_ipo_date ON ipo_data (ipo_date);

CREATE INDEX idx_ipo_data_listing_gain ON ipo_data (listing_gain);

CREATE INDEX idx_ipo_data_total_subscription ON ipo_data (total_subscription);
