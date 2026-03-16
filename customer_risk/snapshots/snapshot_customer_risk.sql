{% snapshot snapshot_customer_risk %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=['contract', 'payment_method', 'monthly_charges', 'total_charges', 'churn']
    )
}}

select
    customer_id,
    contract,
    payment_method,
    monthly_charges,
    total_charges,
    churn
from {{ ref('silver_retention_risk_analytics') }}

{% endsnapshot %}