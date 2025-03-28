{% macro get_percent_change(current_value, previous_value) %}
    case
        when {{ previous_value }} is null or {{ previous_value }} = 0 then null
        else round(100.0 * ({{ current_value }} - {{ previous_value }}) / {{ previous_value }}, 2)
    end
{% endmacro %}