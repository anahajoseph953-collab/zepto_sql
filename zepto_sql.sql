-- ZEPTO RETAIL DATA ANALYSIS PROJECT

--DATA EXPLORATION

-- 2. Display a sample of 10 products

SELECT *
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
LIMIT 10;

-- 3. Identify rows containing NULL values

SELECT *
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- 4. Find all distinct product categories

SELECT DISTINCT category
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
ORDER BY category;


-- 5. Count products in stock versus out of stock
SELECT
    outOfStock,
    COUNT(*) AS product_count
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
GROUP BY outOfStock
ORDER BY outOfStock;


-- 6. Find product names appearing multiple times
SELECT
    name,
    COUNT(sku_id) AS number_of_skus
FROM `Zepto_project.zepto_v2`
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;

-- SECTION 2: DATA CLEANING

-- 7. Identify products with zero MRP or selling price
SELECT *
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
WHERE mrp = 0
   OR discountedSellingPrice = 0;

--SECTION 3: DATA ANALYSIS

-- Q1. Find the top 10 best-value products based on
--     the discount percentage.

SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`

ORDER BY discountPercent DESC
LIMIT 10;


-- Q2. What are the products with high MRP but out of stock?
--     Condition: MRP greater than 300.
SELECT DISTINCT
    name,
    mrp
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;


-- Q3. Calculate estimated inventory revenue for each category.
--     This estimates the value of available inventory,
--     not actual sales revenue.
SELECT
    category,
    ROUND(
        SUM(discountedSellingPrice * availableQuantity),
        2
    ) AS estimated_inventory_revenue
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
GROUP BY category
ORDER BY estimated_inventory_revenue DESC;


-- Q4. Find products where MRP is greater than 500
--     and discount percentage is less than 10%.
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


-- Q5. Identify the top 5 categories offering
--     the highest average discount percentage.
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;


-- Q6. Find the price per gram for products weighing
--     at least 100 grams and sort by best value.
SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(
        SAFE_DIVIDE(discountedSellingPrice, weightInGms),
        4
    ) AS price_per_gram
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;


-- Q7. Group products into Low, Medium, and Bulk
--     categories according to their weight.
SELECT DISTINCT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 10 THEN 'Low'
        WHEN weightInGms < 50 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
ORDER BY weightInGms;


-- Q8. Calculate the total inventory weight per category.
SELECT
    category,
    SUM(weightInGms * availableQuantity)
        AS total_inventory_weight_gms
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
GROUP BY category
ORDER BY total_inventory_weight_gms DESC;


-- Q9. Top 3 discounted products in each category

WITH ranked_products AS (
    SELECT
        category,
        name,
        mrp,
        discountedSellingPrice,
        discountPercent,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY discountPercent DESC
        ) AS discount_rank
    FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
    WHERE discountPercent IS NOT NULL
)
SELECT
    category,
    name,
    mrp,
    discountedSellingPrice,
    discountPercent,
    discount_rank
FROM ranked_products
WHERE discount_rank <= 3
ORDER BY category, discount_rank;

-- Q10. Categories with above-average inventory value


WITH category_inventory AS (
    SELECT
        category,
        SUM(
            discountedSellingPrice * availableQuantity
        ) AS inventory_value
    FROM `Zepto_project.zepto_v2`
    GROUP BY category
)
SELECT
    category,
    ROUND(inventory_value, 2) AS inventory_value
FROM category_inventory
WHERE inventory_value > (
    SELECT AVG(inventory_value)
    FROM category_inventory
)
ORDER BY inventory_value DESC;

-- Q11. Products discounted more than their category average

WITH product_discount_analysis AS (
    SELECT
        category,
        name,
        mrp,
        discountedSellingPrice,
        discountPercent,
        AVG(discountPercent) OVER (
            PARTITION BY category
        ) AS category_avg_discount
    FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
    WHERE discountPercent IS NOT NULL
)
SELECT
    category,
    name,
    discountPercent,
    ROUND(category_avg_discount, 2)
        AS category_avg_discount,
    ROUND(
        discountPercent - category_avg_discount,
        2
    ) AS difference_from_average
FROM product_discount_analysis
WHERE discountPercent > category_avg_discount
ORDER BY difference_from_average DESC;


-- Q12. Inventory availability and stock risk by category
SELECT
    category,
    COUNT(*) AS total_products,
    COUNTIF(outOfStock = TRUE) AS out_of_stock_products,
    COUNTIF(outOfStock = FALSE) AS in_stock_products,
    ROUND(
        100 * SAFE_DIVIDE(
            COUNTIF(outOfStock = TRUE),
            COUNT(*)
        ),
        2
    ) AS out_of_stock_percentage,
    SUM(
        CASE
            WHEN outOfStock = TRUE
            THEN availableQuantity
            ELSE 0
        END
    ) AS quantity_marked_out_of_stock
FROM `zepto-sql-analysis.Zepto_project.zepto_v2`
GROUP BY category
ORDER BY out_of_stock_percentage DESC;






