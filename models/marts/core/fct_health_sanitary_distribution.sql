select
    dist.sanitary_distribution_row_sk,
    dist.distribution_id,
    dist.distribution_date,
    date_trunc('month', dist.distribution_date)::date as distribution_month,
    dist.beneficiary_id,
    dist.household_id,
    dist.field_worker_id,
    dist.beneficiary_name,
    dist.age_years,
    coalesce(dist.district, households.district) as district,
    coalesce(dist.state, households.state) as state,
    coalesce(dist.partner_ngo, households.partner_ngo) as partner_ngo,
    coalesce(dist.ward, households.ward) as ward,
    coalesce(dist.area, households.area) as area,
    coalesce(dist.cluster, households.cluster) as cluster,
    dist.beneficiary_group,
    dist.product_type,
    dist.quantity,
    dist.unit,
    dist.batch_no,
    dist.donor_or_program,
    dist.distribution_channel,
    dist.awareness_session_attended,
    dist.stockout_reported,
    dist.receipt_acknowledgement,
    dist.entered_by,
    dist.source_loaded_at
from {{ ref('stg_health__sanitary_distribution') }} as dist
left join {{ ref('dim_health_households') }} as households
    on dist.household_id = households.household_id
where not dist.is_duplicate_distribution_id
