-- Step 4: Remove duplicate sales records
-- Deduplicate based on invoice, product, quantity, and price

CREATE TABLE ecommerce_sales_final AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY invoice_no, stock_code, quantity, unit_price
               ORDER BY invoice_date
           ) AS rn
    FROM ecommerce_sales_clean
) t
WHERE rn = 1;
