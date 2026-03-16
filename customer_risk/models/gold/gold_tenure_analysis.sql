-- Step 1: Silver cleaned dataset read kar rahe hain
with silver_data as (

    select *
    from {{ ref('silver_retention_risk_analytics') }}

),

-- Step 2: Tenure group ke basis par churn analysis kar rahe hain
final as (

    select
        tenure_group,

        -- total customers count
        count(*) as total_customers,

        -- churned customers
        sum(churn_flag) as churned_customers,

        -- churn rate percentage
        round(100.0 * sum(churn_flag) / count(*), 2) as churn_rate_percent,

        -- average monthly charges
        round(avg(monthly_charges), 2) as avg_monthly_charges,

        -- average tenure
        round(avg(tenure), 2) as avg_tenure

    from silver_data
    group by tenure_group

)

-- Step 3: Final output
select *
from final