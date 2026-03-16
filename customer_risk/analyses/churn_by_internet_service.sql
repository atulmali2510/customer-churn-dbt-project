select
    internet_service,

    count(*) as total_customers,

    sum(churn_flag) as churned_customers,

    round(100.0 * sum(churn_flag) / count(*), 2) as churn_rate_percent

from {{ ref('silver_retention_risk_analytics') }}

group by internet_service
order by churn_rate_percent desc