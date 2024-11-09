
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/


{{ config(materialized='table') }}

WITH payment_method_counts AS (
    SELECT
        payment_method,
        order_count
    FROM {{ ref('int_orderdetails_aggregates') }}
),

preferred_payment_method AS (
    SELECT
        payment_method,
        order_count,
        RANK() OVER (ORDER BY order_count DESC) AS popularity_rank
    FROM payment_method_counts
)

SELECT 
    payment_method,
    order_count AS total_orders
FROM preferred_payment_method
WHERE popularity_rank = 1
