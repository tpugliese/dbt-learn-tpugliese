SELECT
    id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    amount,
    created
FROM raw.stripe.payment