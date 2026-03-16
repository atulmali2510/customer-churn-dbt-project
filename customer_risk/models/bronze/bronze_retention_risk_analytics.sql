select *
from 
    {{ source('source', 'retention_risk_analytics') }}