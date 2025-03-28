{% macro normalize_vendor_name(vendor_name) %}
    trim(upper(regexp_replace({{ vendor_name }}, '[^a-zA-Z0-9 ]', '')))
{% endmacro %}