Zepto Retail Data Analysis using SQL (Google BigQuery)

Project Overview

This project focuses on analyzing Zepto retail inventory and product pricing data using Google BigQuery and SQL. The objective is to explore product categories, evaluate discount strategies, assess inventory availability, and identify insights that can support retail business decisions.

The project includes data exploration, data quality checks, pricing analysis, inventory analysis, and advanced SQL queries using Common Table Expressions (CTEs), window functions, conditional aggregation, and ranking techniques.

Tools & Technologies

Google BigQuery Sandbox – SQL querying and data analysis

SQL (GoogleSQL) – Data exploration, cleaning, and business analysis

GitHub – Project documentation and version control

Dataset Overview

The dataset contains product-level retail information, including:

SKU ID and product name

Product category

Maximum Retail Price (MRP)

Discount percentage

Discounted selling price

Available inventory quantity

Product weight

Stock availability status

Project Objectives

Explore product data and identify data quality issues.

Analyze product pricing and discount strategies.

Identify high-value products and category-level discount patterns.

Estimate inventory value and total inventory weight.

Examine product availability and potential stock-related risks.

Apply advanced SQL techniques to answer business questions.

SQL Analysis & Business Insights

1. Data Exploration

Q1. Total Number of Records

Counts the total rows in the dataset to understand its size and scope.

Business insight: Establishes the volume of product records available for analysis.

Q2. Sample Product Records

Retrieves a sample of 10 products to inspect the dataset structure and values.

Business insight: Helps understand the columns, data formats, and overall structure before analysis.

Q3. Identify Missing Values

Checks for NULL values across key product attributes, including price, category, discount, quantity, and stock status.

Business insight: Identifies potential data quality issues that could affect the accuracy of downstream analysis.

Q4. Identify Unique Product Categories

Lists all distinct product categories.

Business insight: Provides an overview of the product assortment and the different categories represented in the dataset.

Q5. In-Stock vs. Out-of-Stock Products

Counts products by their stock availability status.

Business insight: Helps assess product availability and understand the proportion of products marked out of stock.

Q6. Products with Multiple SKUs

Identifies product names associated with multiple SKU records.

Business insight: Helps investigate products with multiple variants or repeated records. Duplicate names do not necessarily indicate duplicate products.

2. Data Cleaning

Q7. Identify Products with Zero Prices

Finds products with an MRP or discounted selling price of zero.

Business insight: Highlights records that may require validation before pricing analysis.

Q8. Remove Invalid Zero-MRP Records

Demonstrates how to remove records with zero MRP when they are confirmed to be invalid.

Business insight: Helps improve data quality before conducting product pricing analysis. Destructive changes should be made to a copy of the original table whenever possible.

Q9. Price Unit Conversion

Demonstrates how to convert prices from paise to rupees when the source data is stored in paise.

Business insight: Ensures price values use a consistent currency unit for meaningful comparisons and reporting. The conversion should only be performed after verifying the source units.

3. Business Analysis

Q10. Top 10 Best-Value Products by Discount Percentage

Ranks products by their discount percentage to identify the highest-discount offers.

Business insight: Helps identify products with attractive discounts for promotional analysis and customer value comparisons.

Q11. High-MRP Products That Are Out of Stock

Identifies out-of-stock products with an MRP above ₹300.

Business insight: Highlights relatively high-priced products that may warrant inventory availability checks.

Q12. Estimated Inventory Value by Category

Calculates the estimated value of available inventory using discounted selling price multiplied by available quantity.

Business insight: Identifies categories holding higher estimated inventory value and helps prioritize inventory management. This is an estimate of stock value, not actual sales revenue.

Q13. Products with MRP Above ₹500 and Discounts Below 10%

Identifies higher-priced products offering relatively small discounts.

Business insight: Supports pricing comparisons and helps identify products that may need further promotional evaluation.

Q14. Top 5 Categories by Average Discount

Calculates the average discount percentage for each category and ranks the top five.

Business insight: Reveals categories that generally offer higher discounts and supports category-level promotional comparisons.

Q15. Price per Gram Analysis

Calculates the discounted price per gram for products weighing at least 100 grams.

Business insight: Helps compare unit prices across products and identify potentially better-value options. Product type, quality, and packaging should also be considered when making comparisons.

Q16. Product Weight Classification

Classifies products into Low, Medium, and Bulk groups according to weight.

Low: Below 1,000 grams

Medium: 1,000 to below 5,000 grams

Bulk: 5,000 grams or more

Business insight: Helps segment products by size for inventory planning, packaging analysis, and assortment management.

Q17. Total Inventory Weight by Category

Calculates the total inventory weight by multiplying product weight by available quantity and aggregating by category.

Business insight: Helps identify categories with higher estimated inventory weight, which may be useful for storage and logistics planning.

4. Advanced SQL Analysis

Q18. Top 3 Highest-Discounted Products in Each Category

Uses DENSE_RANK() and a CTE to rank products by discount percentage within each category.

Business insight: Identifies the most heavily discounted products within each category rather than across the entire dataset.

Q19. Categories with Above-Average Inventory Value

Uses a CTE and subquery to compare each category's estimated inventory value with the average category inventory value.

Business insight: Highlights categories with inventory values above the overall category average, helping prioritize further inventory analysis.

Q20. Products Discounted Above Their Category Average

Uses the AVG() window function to compare individual product discounts with their category's average discount.

Business insight: Identifies products with higher-than-average discounts relative to their own category.

Q21. Inventory Availability and Stock Risk by Category

Uses COUNTIF(), conditional aggregation, and SAFE_DIVIDE() to analyze in-stock and out-of-stock products by category.

Business insight: Highlights categories with higher out-of-stock percentages and helps identify potential availability issues. Quantity and stock-status inconsistencies can also be investigated.

SQL Concepts Demonstrated

SELECT, WHERE, DISTINCT, and ORDER BY

Aggregate functions: COUNT(), SUM(), and AVG()

GROUP BY and HAVING

CASE statements

Common Table Expressions (CTEs)

Window functions: DENSE_RANK() and AVG() OVER()

Subqueries

Conditional aggregation using COUNTIF()

Safe calculations using SAFE_DIVIDE()

Data quality checks and data cleaning

Inventory and pricing analysis

Key Business Outcomes

This project demonstrates how SQL can be used to:

Assess product data quality and identify potential anomalies.

Compare discount strategies across products and categories.

Estimate the value and weight of available inventory.

Identify products with high prices and low discounts.

Evaluate stock availability and investigate potential inventory risks.

Use advanced SQL techniques to answer practical retail business questions.
