{% macro tenure_group(column_name) %}

case
    when {{ column_name }} <= 12 then 'New Customer'
    when {{ column_name }} <= 24 then 'Mid Customer'
    else 'Loyal Customer'
end

{% endmacro %}