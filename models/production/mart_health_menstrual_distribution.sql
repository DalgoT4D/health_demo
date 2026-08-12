--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(distribution_id_raw) as distribution_id,
trim(beneficiary_id_raw) as beneficiary_id,
trim(beneficiary_name_raw) as beneficiary_name,
coalesce(nullif(regexp_replace(age_raw, '[^0-9]', '', 'g'), ''), '0')::integer as age_years,
case
  when coalesce(nullif(regexp_replace(age_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 15 then 'Under 15'
  when coalesce(nullif(regexp_replace(age_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 20 then '15-19'
  when coalesce(nullif(regexp_replace(age_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 30 then '20-29'
  when coalesce(nullif(regexp_replace(age_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 40 then '30-39'
  else '40+'
end as age_group,
initcap(trim(beneficiary_group_raw)) as beneficiary_group,
case
  when lower(trim(product_type_raw)) like '%cup%' then 'Menstrual Cup'
  when lower(trim(product_type_raw)) like '%reusable%' then 'Reusable Cloth Pad Kit'
  when lower(trim(product_type_raw)) like '%kit%' then 'Period Hygiene Kit'
  else 'Sanitary Pads'
end as product_type,
coalesce(nullif(regexp_replace(quantity_raw, '[^0-9]', '', 'g'), ''), '0')::integer as products_distributed,
lower(trim(unit_raw)) as distribution_unit,
coalesce(
  case
    when trim(distribution_date_raw) ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then trim(distribution_date_raw)::date
    when trim(distribution_date_raw) ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' then to_date(trim(distribution_date_raw), 'YYYY/MM/DD')
    when trim(distribution_date_raw) ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' then to_date(trim(distribution_date_raw), 'DD-MM-YY')
    when trim(distribution_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' and split_part(trim(distribution_date_raw), '/', 2)::integer > 12 then to_date(trim(distribution_date_raw), 'MM/DD/YYYY')
    when trim(distribution_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' then to_date(trim(distribution_date_raw), 'DD/MM/YYYY')
    when trim(distribution_date_raw) ~ '^[A-Za-z]{3} [A-Za-z]{3} [0-9]{2} [0-9]{4}$' then to_date(trim(distribution_date_raw), 'Dy Mon DD YYYY')
    else null
  end,
  make_date(2026, ((coalesce(nullif(regexp_replace(distribution_id_raw, '[^0-9]', '', 'g'), ''), '1')::integer - 1) % 12) + 1, 15)
) as distribution_date,
date_trunc('month', coalesce(
  case
    when trim(distribution_date_raw) ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then trim(distribution_date_raw)::date
    when trim(distribution_date_raw) ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' then to_date(trim(distribution_date_raw), 'YYYY/MM/DD')
    when trim(distribution_date_raw) ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' then to_date(trim(distribution_date_raw), 'DD-MM-YY')
    when trim(distribution_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' and split_part(trim(distribution_date_raw), '/', 2)::integer > 12 then to_date(trim(distribution_date_raw), 'MM/DD/YYYY')
    when trim(distribution_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' then to_date(trim(distribution_date_raw), 'DD/MM/YYYY')
    when trim(distribution_date_raw) ~ '^[A-Za-z]{3} [A-Za-z]{3} [0-9]{2} [0-9]{4}$' then to_date(trim(distribution_date_raw), 'Dy Mon DD YYYY')
    else null
  end,
  make_date(2026, ((coalesce(nullif(regexp_replace(distribution_id_raw, '[^0-9]', '', 'g'), ''), '1')::integer - 1) % 12) + 1, 15)
))::date as distribution_month,
not (trim(distribution_date_raw) ~ '^[0-9]{4}[-/][0-9]{2}[-/][0-9]{2}$' or trim(distribution_date_raw) ~ '^[0-9]{2}[-/][0-9]{2}[-/][0-9]{2,4}$' or trim(distribution_date_raw) ~ '^[A-Za-z]{3} [A-Za-z]{3} [0-9]{2} [0-9]{4}$') as distribution_date_imputed,
trim(area_raw) as area,
trim(cluster_raw) as cluster,
trim(ward_raw) as ward,
trim(district_raw) as district,
trim(state_raw) as state,
trim(partner_ngo_raw) as partner_ngo,
lower(trim(distribution_channel_raw)) as distribution_channel,
lower(trim(stockout_reported_raw)) in ('yes','y','true','1') as stockout_reported,
lower(trim(awareness_session_attended_raw)) in ('yes','y','true','1') as awareness_session_attended,
nullif(lower(trim(receipt_ack_raw)), 'null') as receipt_acknowledgement,
trim(household_id_raw) as household_id,
trim(field_worker_id_raw) as field_worker_id,
nullif(trim(batch_no_raw), 'NULL') as batch_no,
initcap(trim(donor_or_program_raw)) as donor_or_program  FROM {{source('staging_health', 'raw_sanitary_dist')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1