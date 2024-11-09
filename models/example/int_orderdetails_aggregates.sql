
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}



-- models/intermediate/int_orderdetails_aggregates.sql

WITH stg_orderdetails AS (
    SELECT * FROM {{ ref('stg_orderdetails') }}
)

SELECT
    payment_method,
    COUNT(order_id) AS order_count,
    SUM(total_amount) AS total_amount,
    SUM(shipping_cost) AS total_shipping_cost,
    SUM(discount_amount) AS total_discount_amount
FROM stg_orderdetails
GROUP BY payment_method
