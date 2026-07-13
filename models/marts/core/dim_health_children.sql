with children as (

    select
        child_id,
        child_name,
        caregiver_beneficiary_id,
        mother_id,
        household_id,
        age_months,
        sex,
        diagnosis,
        severity,
        case_status,
        source_loaded_at
    from {{ ref('stg_health__child_development_tracking') }}
    where child_id is not null

    union all

    select
        child_id,
        patient_name as child_name,
        beneficiary_id as caregiver_beneficiary_id,
        null as mother_id,
        household_id,
        age_months,
        sex,
        diagnosis_or_concern as diagnosis,
        null as severity,
        null as case_status,
        source_loaded_at
    from {{ ref('stg_health__clinic_meetings') }}
    where child_id is not null

),

ranked as (

    select
        *,
        count(*) over (partition by child_id) as source_record_count,
        row_number() over (
            partition by child_id
            order by source_loaded_at desc, (diagnosis is null)::integer asc, child_name asc
        ) as child_rank
    from children

)

select
    child_id,
    child_name,
    caregiver_beneficiary_id,
    mother_id,
    household_id,
    age_months,
    round(age_months / 12.0, 1) as age_years,
    sex,
    diagnosis,
    severity,
    case_status,
    source_record_count
from ranked
where child_rank = 1
