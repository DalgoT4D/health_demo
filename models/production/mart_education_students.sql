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
concat(case split_part(trim(classroom_id),'-G',1) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end, ' Community School') as school_name,
enrollment_date_text::date as enrollment_date,
date_trunc('month', enrollment_date_text)::date as enrollment_month,
initcap(trim(student_status)) as student_status,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_students_tbl5xi_70289669')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1