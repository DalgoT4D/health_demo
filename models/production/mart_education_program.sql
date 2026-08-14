--DBT AUTOMATION has generated this model, please DO NOT EDIT 
--Please make sure you dont change the model name 

{{ config(materialized='table', schema='production') }}
WITH cte4 as (
SELECT
"id",
"country",
"statename",
"districtname",
"districtcode",
"climate_event",
"_airbyte_raw_id",
"_airbyte_extracted_at",
"_airbyte_meta",
CAST("date" AS DATE) AS "date",
CAST("students" AS BIGINT) AS "students",
CAST("males" AS BIGINT) AS "males",
CAST("females" AS BIGINT) AS "females",
CAST("male_score" AS NUMERIC) AS "male_score",
CAST("female_score" AS NUMERIC) AS "female_score",
CAST("population" AS BIGINT) AS "population"
FROM {{source('staging_education', 'raw_student_program')}}
) , cte3 as (
SELECT
"id",
"country",
"statename",
"districtname",
"districtcode",
"date",
"students",
"males",
"females",
"male_score",
"female_score",
"population",
"climate_event",
"_airbyte_raw_id",
"_airbyte_extracted_at",
"_airbyte_meta",
CASE
    WHEN "climate_event" = 'flood' THEN 'Flood disruption'
    WHEN "climate_event" = 'cyclone' THEN 'Cyclone disruption'
    WHEN "climate_event" = 'drought' THEN 'Drought pressure'
    WHEN "climate_event" = 'heatwave' THEN 'Heatwave disruption'
    ELSE 'No recorded shock'
END AS "climate_resilience_status"
FROM cte4
) , cte2 as (
SELECT "id", "country", "statename", "districtname", "districtcode", "date", "students", "males", "females", "male_score", "female_score", "population", "climate_event", "climate_resilience_status"
FROM cte3
) , cte1 as (
SELECT *,
      round(students::numeric / nullif(population, 0), 4) AS monthly_coverage_pct,
      round(male_score - female_score, 2) AS score_gap  FROM cte2)
-- Final SELECT statement combining the outputs of all CTEs
SELECT *
FROM cte1