--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte4 as (
SELECT
"_airbyte_extracted_at",
"_airbyte_generation_id",
"_airbyte_meta",
"_airbyte_raw_id",
"avg_score_boys_text",
"avg_score_girls_text",
"boys_reached_text",
"disruption_type_raw",
"district_raw",
"girls_reached_text",
"population_estimate_text",
"report_id",
"report_month_text",
"source_row_id",
"state_raw",
"students_reached_text",
"submission_status",
"submitted_at_text",
"submitted_by"
FROM {{source('staging_education', 'edu_raw_monthly_district_report')}}
WHERE ("submission_status" = 'Verified')) , cte3 as (
SELECT initcap(trim(state_raw))::varchar AS statename,
initcap(trim(district_raw))::varchar AS districtname,
CASE
  WHEN trim(report_month_text) ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
    THEN to_date(trim(report_month_text), 'DD/MM/YYYY')
  ELSE to_date(trim(report_month_text), 'Mon-YYYY')
END AS date,
replace(trim(students_reached_text), ',', '')::bigint AS students,
replace(trim(boys_reached_text), ',', '')::bigint AS males,
replace(trim(girls_reached_text), ',', '')::bigint AS females,
trim(avg_score_boys_text)::numeric AS male_score,
trim(avg_score_girls_text)::numeric AS female_score,
replace(trim(population_estimate_text), ',', '')::bigint AS population,
CASE lower(regexp_replace(coalesce(disruption_type_raw, ''), '\s', '', 'g'))
  WHEN 'flood'    THEN 'flood'
  WHEN 'flooding' THEN 'flood'
  WHEN 'heatwave' THEN 'heatwave'
  WHEN 'coldwave' THEN 'coldwave'
  ELSE 'none'
END AS climate_event  FROM cte4) , cte2 as (
SELECT
"statename",
"districtname",
"date",
"students",
"males",
"females",
"male_score",
"female_score",
"population",
"climate_event",
CASE
    WHEN "climate_event" = 'flood' THEN 'Flood disruption'
    WHEN "climate_event" = 'heatwave' THEN 'Heatwave disruption'
    WHEN "climate_event" = 'coldwave' THEN 'Cold-wave disruption'
    ELSE 'No recorded shock'
END AS "climate_resilience_status"
FROM cte3
) , cte1 as (
SELECT 'EDU-' || CASE statename WHEN 'Maharashtra' THEN 'MH' WHEN 'Rajasthan' THEN 'RJ' WHEN 'Uttar Pradesh' THEN 'UP' WHEN 'Odisha' THEN 'OD' WHEN 'Assam' THEN 'AS' WHEN 'Karnataka' THEN 'KA' ELSE 'UN' END || '-' || upper(left(regexp_replace(districtname, '[^A-Za-z]', '', 'g'), 3)) || '-' || to_char(date, 'YYYYMM') AS id,
'India'::text AS country,
statename,
districtname,
CASE statename WHEN 'Maharashtra' THEN 'MH' WHEN 'Rajasthan' THEN 'RJ' WHEN 'Uttar Pradesh' THEN 'UP' WHEN 'Odisha' THEN 'OD' WHEN 'Assam' THEN 'AS' WHEN 'Karnataka' THEN 'KA' ELSE 'UN' END || '-' || upper(left(regexp_replace(districtname, '[^A-Za-z]', '', 'g'), 3)) AS districtcode,
date,
students,
males,
females,
male_score,
female_score,
population,
climate_event,
climate_resilience_status,
ROUND(students::numeric / NULLIF(population, 0), 4) AS monthly_coverage_pct,
ROUND(male_score - female_score, 2) AS score_gap  FROM cte2)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1