-- ======================================
-- Analysis 1: Monthly Revenue Trend
-- ======================================

CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT
    DATE_TRUNC('month', invoice_date)::DATE AS month,
    ROUND(SUM(quantity * unit_price), 2) AS monthly_revenue
FROM ecommerce_sales_final
GROUP BY 1
ORDER BY 1;

-- ======================================
-- Analysis 2: Month-over-Month (MoM) Growth
-- ======================================

CREATE OR REPLACE VIEW vw_monthly_revenue_mom AS
SELECT
    month,
    monthly_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month))
        / NULLIF(LAG(monthly_revenue) OVER (ORDER BY month), 0)
        * 100,
        2
    ) AS mom_growth_pct
FROM vw_monthly_revenue
ORDER BY month;

-- ======================================
-- Analysis 3: Top Products by Revenue (Overall)
-- ======================================

CREATE OR REPLACE VIEW vw_top_products AS
SELECT
    stock_code,
    description,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    SUM(quantity) AS total_units_sold
FROM ecommerce_sales_final
WHERE stock_code NOT IN ('POST', 'DOT', 'AMAZONFEE', 'M', 'B')
GROUP BY stock_code, description
ORDER BY total_revenue DESC;

-- ======================================
-- Analysis 4: Top Products by Month
-- ======================================

CREATE OR REPLACE VIEW vw_top_products_by_month AS
SELECT
    month,
    stock_code,
    description,
    total_revenue,
    RANK() OVER (
        PARTITION BY month
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        DATE_TRUNC('month', invoice_date)::DATE AS month,
        stock_code,
        description,
        SUM(quantity * unit_price) AS total_revenue
    FROM ecommerce_sales_final
    WHERE stock_code NOT IN ('POST', 'DOT', 'AMAZONFEE', 'M', 'B')
    GROUP BY 1, stock_code, description
) t;

-- ======================================
-- Analysis 5: Country Revenue and Share
-- ======================================

CREATE OR REPLACE VIEW vw_country_revenue AS
WITH country_revenue AS (
    SELECT
        country,
        SUM(quantity * unit_price) AS revenue
    FROM ecommerce_sales_final
    GROUP BY country
),
total AS (
    SELECT SUM(revenue) AS total_revenue
    FROM country_revenue
)
SELECT
    cr.country,
    ROUND(cr.revenue, 2) AS revenue,
    ROUND(
        cr.revenue / NULLIF(t.total_revenue, 0) * 100,
        2
    ) AS revenue_share_pct
FROM country_revenue cr
CROSS JOIN total t
ORDER BY cr.revenue DESC;

-- ======================================
-- Analysis 6.1: Customer-level Aggregation
-- ======================================

CREATE OR REPLACE VIEW vw_customer_sales AS
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS order_count,
    SUM(quantity * unit_price) AS total_revenue
FROM ecommerce_sales_final
WHERE customer_id IS NOT NULL
GROUP BY customer_id;

-- ======================================
-- Analysis 6.2: Repeat Customer Rate
-- ======================================

CREATE OR REPLACE VIEW vw_repeat_customer_rate AS
SELECT
    COUNT(*) FILTER (WHERE order_count > 1) * 1.0
    / COUNT(*) AS repeat_customer_rate
FROM vw_customer_sales;

-- ======================================
-- Analysis 6.3: Revenue by Customer Type
-- ======================================

CREATE OR REPLACE VIEW vw_customer_revenue_split AS
SELECT
    CASE
        WHEN order_count = 1 THEN 'one_time'
        ELSE 'repeat'
    END AS customer_type,
    ROUND(SUM(total_revenue), 2) AS revenue
FROM vw_customer_sales
GROUP BY customer_type;

-- ======================================
-- Analysis 6.4: Average Revenue per Customer (ARPC)
-- ======================================

CREATE OR REPLACE VIEW vw_arpc AS
SELECT
    ROUND(AVG(total_revenue), 2) AS arpc
FROM vw_customer_sales;




