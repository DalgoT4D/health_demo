--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(assessment_id) as assessment_id,
trim(classroom_id) as classroom_id,
trim(classroom_name) as classroom_name,
split_part(trim(classroom_id),'-G',1) as school_id,
case split_part(trim(classroom_id),'-',2) when 'MH' then 'Maharashtra' when 'RJ' then 'Rajasthan' when 'UP' then 'Uttar Pradesh' when 'OD' then 'Odisha' when 'AS' then 'Assam' else 'Unknown' end as state,
case split_part(trim(classroom_id),'-G',1) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end as district,
case when trim(classroom_id) like '%-G5-%' then 'Grade 5' when trim(classroom_id) like '%-G7-%' then 'Grade 7' else 'Other' end as grade,
right(trim(classroom_id),1) as section,
concat(case split_part(trim(classroom_id),'-G',1) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end, ' Community School') as school_name,
initcap(trim(subject)) as subject,
initcap(trim(assessment_round)) as assessment_round,
assessment_date_text::date as assessment_date,
date_trunc('month', assessment_date_text)::date as assessment_month,
students_tested::integer as students_tested,
students_proficient::integer as students_proficient,
average_score::numeric as average_score,
max_score::numeric as max_score,
round(100.0 * students_proficient::numeric / nullif(students_tested::numeric,0),1) as proficiency_rate,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_assessments_tbl_19800387')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1