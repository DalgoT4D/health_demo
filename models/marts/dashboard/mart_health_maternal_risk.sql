with visits as (

    select
        *,
        case
            when age_years < 18 then 'Under 18'
            when age_years between 18 and 24 then '18-24'
            when age_years between 25 and 34 then '25-34'
            when age_years >= 35 then '35+'
            else 'Unknown'
        end as maternal_age_band,
        case
            when gestational_age_weeks < 13 then '1st trimester'
            when gestational_age_weeks < 28 then '2nd trimester'
            when gestational_age_weeks is not null then '3rd trimester'
            else 'Unknown'
        end as trimester
    from {{ ref('fct_health_maternal_risk_visits') }}

)

select
    visit_month,
    coalesce(state, 'Unknown') as state,
    coalesce(district, 'Unknown') as district,
    coalesce(partner_ngo, 'Unassigned Partner') as partner_ngo,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    coalesce(risk_level, 'Unknown') as risk_level,
    coalesce(anemia_status, 'Unknown') as anemia_status,
    coalesce(hypertension_flag, false) as hypertension_flag,
    coalesce(referral_status, 'Unknown') as referral_status,
    coalesce(referred_facility, 'Not referred') as referred_facility,
    coalesce(transport_support, false) as transport_support,
    coalesce(case_status, 'Unknown') as case_status,
    maternal_age_band,
    trimester,

    count(*) as visit_count,
    count(distinct mother_id) filter (where mother_id is not null) as unique_mothers,
    count(distinct pregnancy_id) filter (where pregnancy_id is not null) as unique_pregnancies,
    sum(is_high_risk::integer) as high_risk_visits,
    sum((risk_level = 'critical')::integer) as critical_risk_visits,
    sum((risk_level = 'high')::integer) as high_risk_level_visits,
    sum((anemia_status in ('moderate', 'severe'))::integer) as moderate_or_severe_anemia_visits,
    sum(coalesce(hypertension_flag, false)::integer) as hypertension_visits,
    sum((danger_signs is not null)::integer) as danger_sign_visits,
    sum(is_referred::integer) as referred_visits,
    sum((referral_status = 'referral_pending')::integer) as referral_pending_visits,
    sum(coalesce(transport_support, false)::integer) as transport_supported_visits,
    round(avg(hemoglobin_g_dl), 1) as avg_hemoglobin_g_dl,
    round(avg(bp_systolic), 1) as avg_bp_systolic,
    round(avg(bp_diastolic), 1) as avg_bp_diastolic,
    round(avg(gestational_age_weeks), 1) as avg_gestational_age_weeks
from visits
where visit_month is not null
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
