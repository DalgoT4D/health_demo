--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(tracking_id_raw) as tracking_id,
trim(child_id_raw) as child_id,
trim(child_name_raw) as child_name,
trim(caregiver_beneficiary_id_raw) as caregiver_beneficiary_id,
trim(mother_id_raw) as mother_id,
trim(household_id_raw) as household_id,
initcap(trim(sex_raw)) as sex,
coalesce(nullif(regexp_replace(age_months_raw, '[^0-9]', '', 'g'), ''), '0')::integer as age_months,
case when coalesce(nullif(regexp_replace(age_months_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 12 then 'Under 1' when coalesce(nullif(regexp_replace(age_months_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 36 then '1-2 years' when coalesce(nullif(regexp_replace(age_months_raw, '[^0-9]', '', 'g'), ''), '0')::integer < 60 then '3-4 years' else '5+ years' end as age_group,
coalesce(case when trim(visit_date_raw) ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then trim(visit_date_raw)::date when trim(visit_date_raw) ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' then to_date(trim(visit_date_raw),'YYYY/MM/DD') when trim(visit_date_raw) ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' then to_date(trim(visit_date_raw),'DD-MM-YY') when trim(visit_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' and split_part(trim(visit_date_raw),'/',2)::integer > 12 then to_date(trim(visit_date_raw),'MM/DD/YYYY') when trim(visit_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' then to_date(trim(visit_date_raw),'DD/MM/YYYY') when trim(visit_date_raw) ~ '^[A-Za-z]{3} [A-Za-z]{3} [0-9]{2} [0-9]{4}$' then to_date(trim(visit_date_raw),'Dy Mon DD YYYY') end, make_date(2026,((coalesce(nullif(regexp_replace(tracking_id_raw,'[^0-9]','','g'),''),'1')::integer-1)%12)+1,15)) as visit_date,
case when trim(next_review_date_raw) ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then trim(next_review_date_raw)::date when trim(next_review_date_raw) ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' then to_date(trim(next_review_date_raw),'YYYY/MM/DD') when trim(next_review_date_raw) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' then to_date(trim(next_review_date_raw),'DD/MM/YYYY') else null end as next_review_date,
initcap(trim(severity_raw)) as severity,
initcap(trim(diagnosis_raw)) as diagnosis,
initcap(trim(case_status_raw)) as case_status,
initcap(trim(screening_tool_raw)) as screening_tool,
nullif(regexp_replace(gross_motor_score_raw,'[^0-9.]','','g'),'')::numeric as gross_motor_score,
nullif(regexp_replace(fine_motor_score_raw,'[^0-9.]','','g'),'')::numeric as fine_motor_score,
nullif(regexp_replace(communication_score_raw,'[^0-9.]','','g'),'')::numeric as communication_score,
nullif(regexp_replace(social_score_raw,'[^0-9.]','','g'),'')::numeric as social_score,
initcap(trim(therapy_referred_raw)) as therapy_referral,
lower(trim(therapy_referred_raw)) in ('yes','y','true','1','referred') as therapy_referred,
coalesce(nullif(regexp_replace(sessions_attended_last_month_raw,'[^0-9]','','g'),''),'0')::integer as sessions_attended_last_month,
initcap(trim(school_status_raw)) as school_status,
trim(area_raw) as area,
trim(ward_raw) as ward,
trim(district_raw) as district,
trim(state_raw) as state,
trim(partner_ngo_raw) as partner_ngo  FROM {{source('staging_health', 'raw_child_dev_tracking')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1