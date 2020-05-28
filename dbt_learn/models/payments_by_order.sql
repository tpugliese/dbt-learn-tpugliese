/*
# manage trailing commas DONE
# make list avaible to other things WORK - DONE
# know what they are (list of values) - DONE
# remove white space? - DONE
# last column loop - DONE
*/

{% set payment_method_query %}
select distinct
payment_method
from {{ ref('stg_payments') }}
order by 1
{% endset %}

{% set results = run_query(payment_method_query) %}

{% if execute %}
{# Return the first column #}
{% set payment_method = results.columns[0].values() %}
{% else %}
{% set payment_method= [] %}
{% endif %}

with payments as (
    SELECT 
     order_id,
    {%- for abcd in payment_method %}
        sum(case when payment_method = '{{ abcd }}' then amount else 0 end) as {{ abcd }}_amount
    {%- if not loop.last -%},{%- endif -%}
    {% endfor %}
    FROM {{ ref('stg_payments') }}
    GROUP BY order_id
)

SELECT *
FROM payments

