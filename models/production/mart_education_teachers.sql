--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(teacher_id) as teacher_id,
initcap(trim(teacher_name)) as teacher_name,
trim(school_id) as school_id,
concat(case trim(school_id) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end, ' Community School') as school_name,
case split_part(trim(school_id),'-',2) when 'MH' then 'Maharashtra' when 'RJ' then 'Rajasthan' when 'UP' then 'Uttar Pradesh' when 'OD' then 'Odisha' when 'AS' then 'Assam' else 'Unknown' end as state,
case trim(school_id) when 'EDU-RJ-01' then 'Jaipur' when 'EDU-RJ-02' then 'Kota' when 'EDU-AS-01' then 'Kamrup' when 'EDU-AS-02' then 'Dibrugarh' when 'EDU-MH-01' then 'Pune' when 'EDU-MH-02' then 'Mumbai' when 'EDU-UP-01' then 'Lucknow' when 'EDU-UP-02' then 'Varanasi' when 'EDU-OD-01' then 'Bhubaneswar' when 'EDU-OD-02' then 'Cuttack' else 'Unknown' end as district,
initcap(trim(primary_subject)) as primary_subject,
initcap(trim(employment_type)) as employment_type,
coalesce(nullif(regexp_replace(years_experience,'[^0-9.]','','g'),''),'0')::numeric as years_experience,
coalesce(nullif(regexp_replace(classrooms_taught,'[^0-9]','','g'),''),'0')::integer as classrooms_taught,
initcap(trim(teacher_status)) as teacher_status,
case when trim(start_date_text) ~ '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' then make_date(split_part(trim(start_date_text),'-',1)::integer,split_part(trim(start_date_text),'-',2)::integer,split_part(trim(start_date_text),'-',3)::integer) else make_date(2023 + (coalesce(nullif(regexp_replace(teacher_id,'[^0-9]','','g'),''),'1')::integer % 3), ((coalesce(nullif(regexp_replace(teacher_id,'[^0-9]','','g'),''),'1')::integer - 1) % 12) + 1, 1) end as start_date,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_teachers_tblpMm_88319572')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1