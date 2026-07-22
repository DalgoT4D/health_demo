select
    child.child_development_row_sk,
    child.tracking_id,
    child.child_id,
    child.caregiver_beneficiary_id,
    child.mother_id,
    child.household_id,
    child.linked_clinic_meeting_id,
    child.child_name,
    child.visit_date,
    date_trunc('month', child.visit_date)::date as visit_month,
    child.next_review_date,
    child.age_months,
    round(child.age_months / 12.0, 1) as age_years,
    child.sex,
    coalesce(child.district, households.district) as district,
    coalesce(child.state, households.state) as state,
    coalesce(child.partner_ngo, households.partner_ngo) as partner_ngo,
    coalesce(child.ward, households.ward) as ward,
    coalesce(child.area, households.area) as area,
    child.screening_tool,
    child.diagnosis,
    child.severity,
    child.gross_motor_score,
    child.fine_motor_score,
    child.communication_score,
    child.social_score,
    (
        coalesce(child.gross_motor_score, 0)
        + coalesce(child.fine_motor_score, 0)
        + coalesce(child.communication_score, 0)
        + coalesce(child.social_score, 0)
    )::numeric
    / nullif(
        (child.gross_motor_score is not null)::integer
        + (child.fine_motor_score is not null)::integer
        + (child.communication_score is not null)::integer
        + (child.social_score is not null)::integer,
        0
    ) as average_domain_score,
    child.has_below_cutoff_score,
    child.therapy_referred,
    child.sessions_attended_last_month,
    child.school_status,
    child.assistive_device,
    child.home_program_given,
    child.case_status,
    child.is_active_case,
    child.entered_by,
    child.source_loaded_at
from {{ ref('stg_health__child_development_tracking') }} as child
left join {{ ref('dim_health_households') }} as households
    on child.household_id = households.household_id
where not child.is_duplicate_tracking_id
