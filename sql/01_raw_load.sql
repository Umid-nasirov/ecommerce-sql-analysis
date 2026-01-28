-- Step 1: Raw data load
-- The dataset is loaded as-is without any transformation.
-- All columns are stored as TEXT to preserve the original data.

CREATE TABLE ecommerce_raw (
    invoice_no     TEXT,
    stock_code     TEXT,
    description    TEXT,
    quantity       TEXT,
    invoice_date   TEXT,
    unit_price     TEXT,
    customer_id    TEXT,
    country        TEXT
);

-- Raw CSV is loaded locally (file not included in repository)
-- Example usage:
-- \copy ecommerce_raw FROM '/local/path/ecommerce_data.csv' CSV HEADER;

