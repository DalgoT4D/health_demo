select
    meeting_month,
    coalesce(state, 'Unknown') as state,
    coalesce(district, 'Unknown') as district,
    coalesce(partner_ngo, 'Unassigned Partner') as partner_ngo,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    coalesce(clinic_site, 'Unknown') as clinic_site,
    coalesce(specialty, 'Unknown') as specialty,
    coalesce(meeting_type, 'Unknown') as meeting_type,
    coalesce(meeting_status, 'Unknown') as meeting_status,
    coalesce(referral_source, 'Unknown') as referral_source,
    coalesce(reason_for_visit, 'Unknown') as reason_for_visit,

    count(*) as appointment_count,
    count(distinct beneficiary_id) filter (where beneficiary_id is not null) as unique_patients,
    count(distinct child_id) filter (where child_id is not null) as unique_children,
    sum(is_completed::integer) as completed_appointments,
    sum((meeting_status = 'no_show')::integer) as no_show_appointments,
    sum((meeting_status = 'rescheduled')::integer) as rescheduled_appointments,
    sum((meeting_status = 'cancelled')::integer) as cancelled_appointments,
    sum(has_follow_up::integer) as follow_up_required,
    sum((action_taken like '%referral%')::integer) as referrals_made,
    round(avg(duration_minutes) filter (where duration_minutes is not null), 1) as avg_duration_minutes
from {{ ref('fct_health_clinic_meetings') }}
where meeting_month is not null
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
