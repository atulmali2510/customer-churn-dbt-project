select
    s.customer_id,
    s.churn,
    m.churn_flag
from {{ ref('silver_retention_risk_analytics') }} s
left join {{ ref('churn_mapping') }} m
on s.churn = m.churn_label