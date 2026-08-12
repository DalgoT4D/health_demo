--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte1 as (
SELECT trim(classroom_id) as classroom_id,
trim(classroom_name) as classroom_name,
trim(school_id) as school_id,
initcap(trim(school_name)) as school_name,
initcap(trim(state)) as state,
initcap(trim(district)) as district,
initcap(trim(grade)) as grade,
upper(trim(section)) as section,
initcap(trim(school_management)) as school_management,
coalesce(nullif(regexp_replace(enrolled_students,'[^0-9]','','g'),''),'0')::integer as enrolled_students,
coalesce(nullif(regexp_replace(classroom_capacity,'[^0-9]','','g'),''),'0')::integer as classroom_capacity,
greatest(coalesce(nullif(regexp_replace(classroom_capacity,'[^0-9]','','g'),''),'0')::integer - coalesce(nullif(regexp_replace(enrolled_students,'[^0-9]','','g'),''),'0')::integer,0) as seats_available,
round(100.0 * coalesce(nullif(regexp_replace(enrolled_students,'[^0-9]','','g'),''),'0')::numeric / nullif(coalesce(nullif(regexp_replace(classroom_capacity,'[^0-9]','','g'),''),'0')::numeric,0),1) as utilization_rate,
initcap(trim(classroom_status)) as classroom_status,
trim(academic_year) as academic_year  FROM {{source('staging', 'education_ngo_airtable_source_xlsx_raw_classrooms_tblb_61427117')}})
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1