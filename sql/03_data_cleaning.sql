-- Step 3: Apply business rules for sales cleaning
-- Remove cancellations and invalid sales records
-- Customer_id NULL values are kept for sales analysis

CREATE TABLE ecommerce_sales_clean AS
SELECT *
FROM ecommerce_typed
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no NOT LIKE 'C%';
