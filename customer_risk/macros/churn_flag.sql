{% macro churn_flag(column_name) %}

case
    when {{ column_name }} = 'Yes' then 1
    else 0
end

{% endmacro %}