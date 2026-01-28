# E-commerce SQL Analysis

End-to-end SQL analysis of e-commerce sales data, focusing on data cleaning, validation, and business-driven insights.

## Dataset

Source: Kaggle – Online Retail Dataset  
https://www.kaggle.com/datasets/carrie1/ecommerce-data

Note: The raw CSV file is not included in this repository due to size considerations.


## Workflow

1. Raw data ingestion with no transformations to preserve the original dataset  
2. Data type standardization to enable reliable calculations and aggregations  
3. Business rule cleaning to remove cancellations, returns, and invalid sales records  
4. Separation of sales data from customer-level data to avoid unintended revenue loss  
5. Deduplication based on business-defined transaction keys rather than all columns  
6. Validation and sanity checks to ensure data quality after cleaning and deduplication  
7. Analytical view creation for reusable reporting and business analysis  
8. Non-product line items (e.g. shipping fees and platform charges) were excluded from product-level revenue analysis to ensure accurate product performance evaluation


## Key Analyses

- Monthly revenue trend and month-over-month (MoM) growth  
- Top products by revenue and monthly performance  
- Revenue concentration analysis (Pareto principle)  
- Customer behavior analysis (repeat rate, revenue share, ARPC)  
- Country-level performance (revenue and AOV)

## Tools

- PostgreSQL  
- SQL

## Summary

This project demonstrates a complete SQL analytics workflow, from raw data cleaning to actionable business insights.

## Insights

- Monthly revenue shows a clear upward trend with noticeable seasonal fluctuations, indicating periods of higher customer demand.
- Month-over-month (MoM) analysis highlights several high-growth months as well as short-term declines, suggesting potential campaign or seasonality effects.
- Revenue is distributed across a large number of products, indicating a long-tail sales structure rather than reliance on a small set of top items.
- Product leadership changes across months, indicating that top-performing products are not static and vary over time.
- A small number of countries account for the majority of revenue, highlighting clear priority markets for the business.
- Repeat customers generate a disproportionately large share of revenue compared to one-time customers, underlining the importance of customer retention strategies.
