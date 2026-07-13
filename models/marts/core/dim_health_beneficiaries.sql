with people as (

    select
        beneficiary_id,
        beneficiary_name as person_name,
        household_id,
        age_years,
        'sanitary_distribution' as source_model,
        true as received_sanitary_products,
        false as has_maternal_record,
        false as has_clinic_record,
        false as has_chatbot_record
    from {{ ref('stg_health__sanitary_distribution') }}
    where beneficiary_id is not null

    union all

    select
        beneficiary_id,
        mother_name as person_name,
        household_id,
        age_years,
        'maternal_mortality_risk' as source_model,
        false as received_sanitary_products,
        true as has_maternal_record,
        false as has_clinic_record,
        false as has_chatbot_record
    from {{ ref('stg_health__maternal_mortality_risk') }}
    where beneficiary_id is not null

    union all

    select
        beneficiary_id,
        case when child_id is null then patient_name end as person_name,
        household_id,
        age_years,
        'clinic_meetings' as source_model,
        false as received_sanitary_products,
        false as has_maternal_record,
        true as has_clinic_record,
        false as has_chatbot_record
    from {{ ref('stg_health__clinic_meetings') }}
    where beneficiary_id is not null

    union all

    select
        beneficiary_id,
        null as person_name,
        household_id,
        null as age_years,
        'chatbot_interactions' as source_model,
        false as received_sanitary_products,
        false as has_maternal_record,
        false as has_clinic_record,
        true as has_chatbot_record
    from {{ ref('stg_health__chatbot_interactions') }}
    where beneficiary_id is not null

)

select
    beneficiary_id,
    max(person_name) filter (where person_name is not null) as person_name,
    max(household_id) filter (where household_id is not null) as household_id,
    max(age_years) filter (where age_years is not null) as age_years,
    bool_or(received_sanitary_products) as received_sanitary_products,
    bool_or(has_maternal_record) as has_maternal_record,
    bool_or(has_clinic_record) as has_clinic_record,
    bool_or(has_chatbot_record) as has_chatbot_record,
    count(*) as source_record_count,
    count(distinct source_model) as source_model_count
from people
group by beneficiary_id
