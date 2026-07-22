with visits as (

    select
        *,
        case
            when age_months < 12 then '0-11 months'
            when age_months < 24 then '12-23 months'
            when age_months < 36 then '24-35 months'
            when age_months < 60 then '36-59 months'
            when age_months is not null then '60+ months'
            else 'Unknown'
        end as age_band
    from {{ ref('fct_health_child_development_visits') }}

)

select
    visit_month,
    coalesce(district, 'Unknown') as district,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    coalesce(screening_tool, 'Unknown') as screening_tool,
    coalesce(diagnosis, 'Unknown') as diagnosis,
    coalesce(severity, 'Unknown') as severity,
    coalesce(therapy_referred, 'none') as therapy_referred,
    coalesce(school_status, 'Unknown') as school_status,
    coalesce(case_status, 'Unknown') as case_status,
    coalesce(sex, 'Unknown') as sex,
    age_band,

    count(*) as visit_count,
    count(distinct child_id) filter (where child_id is not null) as unique_children,
    count(distinct caregiver_beneficiary_id) filter (where caregiver_beneficiary_id is not null) as unique_caregivers,
    sum(has_below_cutoff_score::integer) as below_cutoff_visits,
    sum((severity in ('severe', 'at_risk'))::integer) as severe_or_at_risk_visits,
    sum((therapy_referred is not null and therapy_referred != 'none')::integer) as therapy_referrals,
    sum(is_active_case::integer) as active_cases,
    sum(home_program_given::integer) as home_programs_given,
    sum(coalesce(sessions_attended_last_month, 0)) as therapy_sessions_attended,
    round(avg(average_domain_score), 1) as avg_domain_score,
    round(avg(gross_motor_score), 1) as avg_gross_motor_score,
    round(avg(fine_motor_score), 1) as avg_fine_motor_score,
    round(avg(communication_score), 1) as avg_communication_score,
    round(avg(social_score), 1) as avg_social_score
from visits
where visit_month is not null
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
