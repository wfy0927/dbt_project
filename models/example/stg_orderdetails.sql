
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}



-- models/staging/stg_orderdetails.sql

WITH raw_data AS (
    SELECT
        order_id,
        customer_id,
        customer_email,
        order_date,
        status,
        total_amount,
        shipping_address,
        shipping_zip_code,
        billing_address,
        payment_method,
        shipping_cost,
        discount_amount,
        channel,
        created_at,
        updated_at
    FROM dbt_achen.orderdetails
)

SELECT
    order_id,
    customer_id,
    LOWER(customer_email) AS customer_email,
    order_date AT TIME ZONE 'UTC' AS order_date_utc,
    status,
    total_amount::NUMERIC(10, 2) AS total_amount,
    shipping_address,
    shipping_zip_code,
    billing_address,
    payment_method,
    shipping_cost::NUMERIC(10, 2) AS shipping_cost,
    discount_amount::NUMERIC(10, 2) AS discount_amount,
    channel,
    created_at AT TIME ZONE 'UTC' AS created_at_utc,
    updated_at AT TIME ZONE 'UTC' AS updated_at_utc
FROM raw_data
