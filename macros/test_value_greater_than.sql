{% test value_greater_than(model, column_name, min_value=0) %}

SELECT
    *
FROM {{ model }}
WHERE {{ column_name }} <= {{ min_value }}

{% endtest %}