-- Step 1: Bronze model se raw data read kar rahe hain
with source_data as (

    select *
    from {{ ref('bronze_retention_risk_analytics') }}

),

-- Step 2: Data cleaning aur standardization kar rahe hain
cleaned_data as (

    select

        -- customerID me extra spaces ho sakte hain, isliye trim karke clean kar rahe hain
        trim(customerID) as customer_id,

        -- gender ko lowercase + trim karke standard format me la rahe hain
        lower(trim(gender)) as gender,

        -- SeniorCitizen ko integer me convert kar rahe hain
        cast(SeniorCitizen as int) as senior_citizen,

        -- Partner aur Dependents me extra spaces remove kar rahe hain
        trim(Partner) as partner,
        trim(Dependents) as dependents,

        -- tenure ko integer datatype me convert kar rahe hain
        cast(tenure as int) as tenure,

        -- tenure ke basis par customer group bana rahe hain
        {{ tenure_group('cast(tenure as int)') }} as tenure_group,

        -- phone related columns ko clean kar rahe hain
        trim(PhoneService) as phone_service,
        trim(MultipleLines) as multiple_lines,

        -- internet related columns ko clean kar rahe hain
        trim(InternetService) as internet_service,
        trim(OnlineSecurity) as online_security,

        -- contract aur billing related columns clean kar rahe hain
        trim(Contract) as contract,
        trim(PaperlessBilling) as paperless_billing,
        trim(PaymentMethod) as payment_method,

        -- MonthlyCharges ko safe decimal me convert kar rahe hain
        coalesce(try_cast(trim(MonthlyCharges) as decimal(10,2)), 0.00) as monthly_charges,

        -- TotalCharges ko safe decimal me convert kar rahe hain
        coalesce(try_cast(trim(TotalCharges) as decimal(10,2)), 0.00) as total_charges,

        -- Churn column ko clean kar rahe hain
        trim(Churn) as churn,

        -- Macro use karke churn ko numeric flag me convert kar rahe hain
        {{ churn_flag("trim(Churn)") }} as churn_flag

    from source_data

),

-- Step 3: Invalid customer IDs remove kar rahe hain
final as (

    select *
    from cleaned_data
    where customer_id is not null
      and customer_id <> ''

)

-- Step 4: Final cleaned silver dataset output kar rahe hain
select *
from final