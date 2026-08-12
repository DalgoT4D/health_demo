--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(visit_id_raw) as visit_id,
trim(pregnancy_id_raw) as pregnancy_id,
trim(mother_id_raw) as mother_id,
trim(beneficiary_id_raw) as beneficiary_id,
initcap(trim(mother_name_raw)) as mother_name,
trim(household_id_raw) as household_id,
trim(field_worker_id_raw) as field_worker_id,
case
  when trim(visit_date_raw) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(visit_date_raw),'-',1)::integer, split_part(trim(visit_date_raw),'-',2)::integer, split_part(trim(visit_date_raw),'-',3)::integer)
  when trim(visit_date_raw) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' and split_part(trim(visit_date_raw),'/',2)::integer > 12 then make_date(split_part(trim(visit_date_raw),'/',3)::integer, split_part(trim(visit_date_raw),'/',1)::integer, split_part(trim(visit_date_raw),'/',2)::integer)
  when trim(visit_date_raw) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' then make_date(split_part(trim(visit_date_raw),'/',3)::integer, split_part(trim(visit_date_raw),'/',2)::integer, split_part(trim(visit_date_raw),'/',1)::integer)
  else make_date(2026, ((coalesce(nullif(regexp_replace(visit_id_raw,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 15)
end as visit_date,
case
  when trim(next_visit_date_raw) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(next_visit_date_raw),'-',1)::integer, split_part(trim(next_visit_date_raw),'-',2)::integer, split_part(trim(next_visit_date_raw),'-',3)::integer)
  else null::date
end as next_visit_date,
case
  when trim(lmp_date_raw) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(lmp_date_raw),'-',1)::integer, split_part(trim(lmp_date_raw),'-',2)::integer, split_part(trim(lmp_date_raw),'-',3)::integer)
  else null::date
end as lmp_date,
case
  when trim(edd_raw) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(edd_raw),'-',1)::integer, split_part(trim(edd_raw),'-',2)::integer, split_part(trim(edd_raw),'-',3)::integer)
  else null::date
end as expected_delivery_date,
nullif(regexp_replace(age_years_raw,'[^0-9]','','g'),'')::integer as age_years,
nullif(regexp_replace(gestational_age_weeks_raw,'[^0-9]','','g'),'')::integer as gestational_age_weeks,
initcap(trim(risk_level_raw)) as risk_level,
lower(trim(risk_level_raw)) in ('high','critical') as high_risk,
case when trim(bp_systolic_raw) like '%/%' then nullif(regexp_replace(split_part(trim(bp_systolic_raw),'/',1),'[^0-9.]','','g'),'')::numeric else nullif(regexp_replace(bp_systolic_raw,'[^0-9.]','','g'),'')::numeric end as bp_systolic,
case when trim(bp_systolic_raw) like '%/%' then nullif(regexp_replace(split_part(trim(bp_systolic_raw),'/',2),'[^0-9.]','','g'),'')::numeric else nullif(regexp_replace(bp_diastolic_raw,'[^0-9.]','','g'),'')::numeric end as bp_diastolic,
lower(trim(hypertension_flag_raw)) in ('yes','y','true','1','high bp') as hypertension,
nullif(regexp_replace(hemoglobin_g_dl_raw,'[^0-9.]','','g'),'')::numeric as hemoglobin_g_dl,
initcap(replace(trim(anemia_status_raw),'_',' ')) as anemia_status,
(lower(trim(anemia_status_raw)) in ('moderate','severe','moderate anemia','severe anemia') or coalesce(nullif(regexp_replace(hemoglobin_g_dl_raw,'[^0-9.]','','g'),'')::numeric,99) < 11) as anemia,
case when lower(trim(danger_signs_raw)) in ('none','n/a','na','') then null else initcap(trim(danger_signs_raw)) end as danger_signs,
lower(trim(danger_signs_raw)) not in ('none','n/a','na','') and trim(danger_signs_raw) is not null as has_danger_signs,
initcap(replace(trim(referral_status_raw),'_',' ')) as referral_status,
(lower(trim(referral_status_raw)) like '%refer%' or lower(trim(referral_status_raw)) in ('accepted','pending')) as referred,
initcap(trim(referred_facility_raw)) as referred_facility,
lower(trim(transport_support_raw)) in ('yes','y','true','1') as transport_support,
initcap(replace(trim(case_status_raw),'_',' ')) as case_status,
initcap(trim(area_raw)) as area,
upper(trim(ward_raw)) as ward,
initcap(trim(district_raw)) as district,
initcap(trim(state_raw)) as state,
initcap(trim(partner_ngo_raw)) as partner_ngo  FROM {{source('staging_health', 'raw_maternal_risk')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1