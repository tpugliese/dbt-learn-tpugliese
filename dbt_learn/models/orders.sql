
with orders as (
    select * from {{ ref('stg_orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
),
customer_orders as (
    select
        customer_id,
        orders.order_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,
        sum(amount) as sum_payments
    from orders
    JOIN payments ON orders.order_id = payments.order_id
    group by
    1, 2
)

select * from customer_orders
/* 
order_id
customer_id
amount
*/
