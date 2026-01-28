-- Step 5: Validation & Sanity Checks
-- Purpose: Verify that cleaning and deduplication steps worked as intended
-- No data is modified in this step

-- ---------------------------------------------------
-- 1. Check for invalid quantity or price values
-- Expectation: result should be 0
-- ---------------------------------------------------
SELECT COUNT(*) AS invalid_quantity_or_price
FROM ecommerce_sales_final
WHERE quantity <= 0
   OR unit_price <= 0;


-- ---------------------------------------------------
-- 2. Check for cancelled invoices
-- Expectation: result should be 0
-- ---------------------------------------------------
SELECT COUNT(*) AS cancelled_invoices_remaining
FROM ecommerce_sales_final
WHERE invoice_no LIKE 'C%';


-- ---------------------------------------------------
-- 3. Check for nulls in critical fields
-- Expectation: result should be 0
-- ---------------------------------------------------
SELECT COUNT(*) AS null_critical_fields
FROM ecommerce_sales_final
WHERE invoice_date IS NULL
   OR stock_code IS NULL
   OR unit_price IS NULL
   OR quantity IS NULL;


-- ---------------------------------------------------
-- 4. Validate deduplication using business keys
-- Expectation: result set should be empty
-- ---------------------------------------------------
SELECT
    invoice_no,
    stock_code,
    quantity,
    unit_price,
    COUNT(*) AS duplicate_count
FROM ecommerce_sales_final
GROUP BY
    invoice_no,
    stock_code,
    quantity,
    unit_price
HAVING COUNT(*) > 1;


-- ---------------------------------------------------
-- 5. Row count comparison (informational)
-- Used to understand impact of deduplication
-- ---------------------------------------------------
SELECT
    (SELECT COUNT(*) FROM ecommerce_sales_clean)  AS before_dedup,
    (SELECT COUNT(*) FROM ecommerce_sales_final)  AS after_dedup,
    (SELECT COUNT(*) FROM ecommerce_sales_clean)
  - (SELECT COUNT(*) FROM ecommerce_sales_final)  AS removed_duplicates;
