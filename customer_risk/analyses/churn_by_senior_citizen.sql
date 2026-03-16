select
    senior_citizen,

    count(*) as total_customers,

    sum(churn_flag) as churned_customers,

    round(100.0 * sum(churn_flag) / count(*), 2) as churn_rate_percent,

    round(avg(monthly_charges), 2) as avg_monthly_charges

from {{ ref('silver_retention_risk_analytics') }}

group by senior_citizen
order by churn_rate_percent desc