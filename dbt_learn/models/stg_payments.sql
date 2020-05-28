SELECT
    id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    (amount/100.0) as amount,
    created
FROM {{ source('stripe', 'payment') }}