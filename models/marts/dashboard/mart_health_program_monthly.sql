select
    event_month,
    program_area,
    coalesce(state, 'Unknown') as state,
    coalesce(district, 'Unknown') as district,
    coalesce(partner_ngo, 'Unassigned Partner') as partner_ngo,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    count(*) as event_count,
    count(distinct beneficiary_id) filter (where beneficiary_id is not null) as unique_beneficiaries,
    count(distinct child_id) filter (where child_id is not null) as unique_children,
    count(distinct mother_id) filter (where mother_id is not null) as unique_mothers,
    sum(product_quantity) as product_quantity,
    sum(is_completed::integer) as completed_events,
    sum(is_high_risk::integer) as high_risk_events,
    sum(is_referred::integer) as referred_events,
    sum(escalated_to_human::integer) as chatbot_escalations
from {{ ref('mart_health_service_events') }}
where event_month is not null
group by 1, 2, 3, 4, 5, 6, 7
