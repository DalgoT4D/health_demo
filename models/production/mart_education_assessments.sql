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
case when trim(assessment_date_text) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(assessment_date_text),'-',1)::integer,split_part(trim(assessment_date_text),'-',2)::integer,split_part(trim(assessment_date_text),'-',3)::integer) else make_date(2026, ((coalesce(nullif(regexp_replace(assessment_id,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 15) end as assessment_date,
date_trunc('month', case when trim(assessment_date_text) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(assessment_date_text),'-',1)::integer,split_part(trim(assessment_date_text),'-',2)::integer,split_part(trim(assessment_date_text),'-',3)::integer) else make_date(2026, ((coalesce(nullif(regexp_replace(assessment_id,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 15) end)::date as assessment_month,
coalesce(nullif(regexp_replace(students_tested,'[^0-9]','','g'),''),'0')::integer as students_tested,
coalesce(nullif(regexp_replace(students_proficient,'[^0-9]','','g'),''),'0')::integer as students_proficient,
coalesce(nullif(regexp_replace(average_score,'[^0-9.]','','g'),''),'0')::numeric as average_score,
coalesce(nullif(regexp_replace(max_score,'[^0-9.]','','g'),''),'100')::numeric as max_score,
round(100.0 * coalesce(nullif(regexp_replace(students_proficient,'[^0-9]','','g'),''),'0')::integer::numeric / nullif(coalesce(nullif(regexp_replace(students_tested,'[^0-9]','','g'),''),'0')::integer::numeric,0),1) as proficiency_rate,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_assessments_tbl_19800387')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1