select
    distribution_month,
    coalesce(state, 'Unknown') as state,
    coalesce(district, 'Unknown') as district,
    coalesce(partner_ngo, 'Unassigned Partner') as partner_ngo,
    coalesce(ward, 'Unknown') as ward,
    coalesce(area, 'Unknown') as area,
    coalesce(cluster, 'Unknown') as cluster,
    coalesce(beneficiary_group, 'Unknown') as beneficiary_group,
    coalesce(product_type, 'Unknown') as product_type,
    coalesce(unit, 'Unknown') as unit,
    coalesce(donor_or_program, 'Unknown') as donor_or_program,
    coalesce(distribution_channel, 'Unknown') as distribution_channel,
    coalesce(awareness_session_attended, false) as awareness_session_attended,
    coalesce(stockout_reported, false) as stockout_reported,
    coalesce(receipt_acknowledgement, 'Unknown') as receipt_acknowledgement,

    count(*) as distribution_event_count,
    count(distinct beneficiary_id) filter (where beneficiary_id is not null) as unique_beneficiaries,
    count(distinct household_id) filter (where household_id is not null) as unique_households,
    sum(coalesce(quantity, 0)) as total_quantity,
    sum(coalesce(awareness_session_attended, false)::integer) as awareness_attended_count,
    sum(coalesce(stockout_reported, false)::integer) as stockout_event_count,
    sum((receipt_acknowledgement is not null)::integer) as acknowledged_receipts
from {{ ref('fct_health_sanitary_distribution') }}
where distribution_month is not null
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
