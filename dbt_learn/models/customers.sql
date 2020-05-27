{{
  config(
    materialized='view'
  )
}}

with customers as (
    select * from {{ ref('stg_customers') }}
),
customer_orders as (
    select * from {{ ref('orders') }}
),
final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(sum(sum_payments/100), 0) as lifetime_value
    from customers
    left join customer_orders using (customer_id)
    GROUP BY 
    1, 2, 3, 4
)
select * from final