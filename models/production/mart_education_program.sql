-- DBT AUTOMATION has generated this model, please DO NOT EDIT
-- Please make sure you dont change the model name

{{ config(materialized='table', schema='production') }}

with cast_fields as (
    select
        id,
        country,
        statename,
        districtname,
        districtcode,
        cast(date as date) as date,
        cast(students as bigint) as students,
        cast(males as bigint) as males,
        cast(females as bigint) as females,
        cast(male_score as numeric) as male_score,
        cast(female_score as numeric) as female_score,
        cast(population as bigint) as population,
        climate_event,
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta
    from {{ source('staging_education', 'raw_student_program') }}
),
classify_resilience as (
    select
        *,
        case climate_event
            when 'flood' then 'Flood disruption'
            when 'cyclone' then 'Cyclone disruption'
            when 'drought' then 'Drought pressure'
            when 'heatwave' then 'Heatwave disruption'
            else 'No recorded shock'
        end as climate_resilience_status
    from cast_fields
),
drop_ingestion_metadata as (
    select
        id,
        country,
        statename,
        districtname,
        districtcode,
        date,
        students,
        males,
        females,
        male_score,
        female_score,
        population,
        climate_event,
        climate_resilience_status
    from classify_resilience
)
select
    *,
    round(students::numeric / nullif(population, 0), 4) as monthly_coverage_pct,
    round(male_score - female_score, 2) as score_gap
from drop_ingestion_metadata
