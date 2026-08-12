--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(student_id) as student_id,
initcap(trim(student_name)) as student_name,
initcap(trim(gender)) as gender,
trim(classroom_id) as classroom_id,
trim(classroom_name) as classroom_name,
split_part(trim(classroom_id),'-G',1) as school_id,
case split_part(trim(classroom_id),'-',2) when 'MH' then 'Maharashtra' when 'RJ' then 'Rajasthan' when 'UP' then 'Uttar Pradesh' when 'OD' then 'Odisha' when 'AS' then 'Assam' else 'Unknown' end as state,
case split_part(trim(classroom_id),'-G',1) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end as district,
case when trim(classroom_id) like '%-G5-%' then 'Grade 5' when trim(classroom_id) like '%-G7-%' then 'Grade 7' else 'Other' end as grade,
right(trim(classroom_id),1) as section,
case when trim(enrollment_date_text) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(enrollment_date_text),'-',1)::integer,split_part(trim(enrollment_date_text),'-',2)::integer,split_part(trim(enrollment_date_text),'-',3)::integer) else make_date(2025 + ((coalesce(nullif(regexp_replace(student_id,'[^0-9]','','g'),''),'1')::integer % 2)), ((coalesce(nullif(regexp_replace(student_id,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 1) end as enrollment_date,
gs.snapshot_month::date as snapshot_month,
initcap(trim(student_status)) as student_status,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_students_tbl5xi_70289669')}} cross join lateral generate_series(date_trunc('month', case when trim(enrollment_date_text) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(enrollment_date_text),'-',1)::integer,split_part(trim(enrollment_date_text),'-',2)::integer,split_part(trim(enrollment_date_text),'-',3)::integer) else make_date(2025 + ((coalesce(nullif(regexp_replace(student_id,'[^0-9]','','g'),''),'1')::integer % 2)), ((coalesce(nullif(regexp_replace(student_id,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 1) end)::date, date '2026-07-01', interval '1 month') as gs(snapshot_month))
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1