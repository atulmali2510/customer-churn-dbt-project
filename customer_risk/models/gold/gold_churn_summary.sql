-- Churn basis par summary table
with silver_data as (

    select *
    from {{ ref('silver_retention_risk_analytics') }}

),

final as (

    select
        churn,
        count(*) as total_customers,
        round(avg(monthly_charges), 2) as avg_monthly_charges,
        round(avg(total_charges), 2) as avg_total_charges,
        round(avg(tenure), 2) as avg_tenure,
        sum(churn_flag) as total_churned_customers
    from silver_data
    group by churn

)

select *
from final
