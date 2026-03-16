-- Contract type ke hisab se churn analysis
with silver_data as (

    select *
    from {{ ref('silver_retention_risk_analytics') }}

),

final as (

    select
        contract,
        count(*) as total_customers,
        sum(churn_flag) as churned_customers,
        round(100.0 * sum(churn_flag) / count(*), 2) as churn_rate_percent,
        round(avg(monthly_charges), 2) as avg_monthly_charges,
        round(avg(tenure), 2) as avg_tenure
    from silver_data
    group by contract

)

select *
from final
