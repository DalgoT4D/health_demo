with clinic_followups as (

    select
        'clinic_meeting' as source_area,
        meeting_id as source_record_id,
        follow_up_date as due_date,
        beneficiary_id,
        child_id,
        null::text as mother_id,
        household_id,
        district,
        ward,
        area,
        patient_name as person_name,
        meeting_status as current_status,
        has_follow_up as requires_follow_up,
        (
            follow_up_date < current_date
        ) as is_overdue
    from {{ ref('fct_health_clinic_meetings') }}
    where
        follow_up_date is not null
        and meeting_status in ('completed', 'rescheduled')

),

child_followups as (

    select
        'child_development' as source_area,
        tracking_id as source_record_id,
        next_review_date as due_date,
        caregiver_beneficiary_id as beneficiary_id,
        child_id,
        mother_id,
        household_id,
        district,
        ward,
        area,
        child_name as person_name,
        case_status as current_status,
        case_status in ('active', 'on_hold') as requires_follow_up,
        (
            next_review_date < current_date
        ) as is_overdue
    from {{ ref('fct_health_child_development_visits') }}
    where
        next_review_date is not null
        and case_status in ('active', 'on_hold')

),

maternal_followups as (

    select
        'maternal_health' as source_area,
        visit_id as source_record_id,
        next_visit_date as due_date,
        beneficiary_id,
        null::text as child_id,
        mother_id,
        household_id,
        district,
        ward,
        area,
        mother_name as person_name,
        case_status as current_status,
        case_status in ('open', 'lost_to_follow_up') or is_high_risk as requires_follow_up,
        (
            next_visit_date < current_date
        ) as is_overdue
    from {{ ref('fct_health_maternal_risk_visits') }}
    where
        next_visit_date is not null
        and case_status in ('open', 'lost_to_follow_up')

)

select * from clinic_followups
union all
select * from child_followups
union all
select * from maternal_followups
