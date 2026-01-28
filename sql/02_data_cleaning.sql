-- Step 2: Create typed table from raw data
-- Convert data types but do not apply any 

CREATE TABLE ecommerce_typed AS
SELECT
    invoice_no,
    stock_code,
    description,
    CAST(quantity AS INTEGER)      AS quantity,
    CAST(invoice_date AS TIMESTAMP) AS invoice_date,
    CAST(unit_price AS NUMERIC)    AS unit_price,
    CAST(customer_id AS INTEGER)   AS customer_id,
    country
FROM ecommerce_raw;
