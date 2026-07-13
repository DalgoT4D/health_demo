with clinic as (

    select
        clinic_meeting_row_sk as event_sk,
        'clinic_meeting' as event_type,
        'clinic' as program_area,
        meeting_date as event_date,
        meeting_month as event_month,
        meeting_status as event_status,
        beneficiary_id,
        child_id,
        null::text as mother_id,
        household_id,
        district,
        ward,
        area,
        is_completed,
        false as is_high_risk,
        action_taken like '%referral%' as is_referred,
        null::integer as product_quantity,
        false as escalated_to_human
    from {{ ref('fct_health_clinic_meetings') }}

),

sanitary as (

    select
        sanitary_distribution_row_sk as event_sk,
        'sanitary_distribution' as event_type,
        'menstrual_health' as program_area,
        distribution_date as event_date,
        distribution_month as event_month,
        product_type as event_status,
        beneficiary_id,
        null::text as child_id,
        null::text as mother_id,
        household_id,
        district,
        ward,
        area,
        true as is_completed,
        false as is_high_risk,
        false as is_referred,
        quantity as product_quantity,
        false as escalated_to_human
    from {{ ref('fct_health_sanitary_distribution') }}

),

child_visits as (

    select
        child_development_row_sk as event_sk,
        'child_development_visit' as event_type,
        'child_development' as program_area,
        visit_date as event_date,
        visit_month as event_month,
        case_status as event_status,
        caregiver_beneficiary_id as beneficiary_id,
        child_id,
        mother_id,
        household_id,
        district,
        ward,
        area,
        true as is_completed,
        severity in ('severe', 'at_risk') or has_below_cutoff_score as is_high_risk,
        therapy_referred is not null and therapy_referred != 'none' as is_referred,
        null::integer as product_quantity,
        false as escalated_to_human
    from {{ ref('fct_health_child_development_visits') }}

),

maternal as (

    select
        maternal_risk_row_sk as event_sk,
        'maternal_risk_visit' as event_type,
        'maternal_health' as program_area,
        visit_date as event_date,
        visit_month as event_month,
        case_status as event_status,
        beneficiary_id,
        null::text as child_id,
        mother_id,
        household_id,
        district,
        ward,
        area,
        true as is_completed,
        is_high_risk,
        is_referred,
        null::integer as product_quantity,
        false as escalated_to_human
    from {{ ref('fct_health_maternal_risk_visits') }}

),

chatbot as (

    select
        chatbot_interaction_row_sk as event_sk,
        'chatbot_interaction' as event_type,
        'chatbot' as program_area,
        interaction_date as event_date,
        interaction_month as event_month,
        resolution_status as event_status,
        beneficiary_id,
        child_id,
        mother_id,
        household_id,
        district,
        ward,
        area,
        resolution_status in ('resolved_by_bot', 'human_follow_up') as is_completed,
        sentiment = 'urgent' or escalation_reason in ('danger sign', 'possible emergency') as is_high_risk,
        escalated_to_human as is_referred,
        null::integer as product_quantity,
        escalated_to_human
    from {{ ref('fct_health_chatbot_interactions') }}

)

select * from clinic
union all
select * from sanitary
union all
select * from child_visits
union all
select * from maternal
union all
select * from chatbot
