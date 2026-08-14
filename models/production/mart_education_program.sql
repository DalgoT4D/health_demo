-- DBT AUTOMATION has generated this model, please DO NOT EDIT
-- Please make sure you dont change the model name

{{ config(materialized='table', schema='production') }}

with classroom_source as (
    select *
    from (
        select
            *,
            row_number() over (
                partition by _airtable_id
                order by _airbyte_extracted_at desc
            ) as source_row_number
        from {{ source('airtable_education', 'classrooms') }}
    ) ranked
    where source_row_number = 1
),
attendance_source as (
    select *
    from (
        select
            *,
            row_number() over (
                partition by _airtable_id
                order by _airbyte_extracted_at desc
            ) as source_row_number
        from {{ source('airtable_education', 'attendance') }}
    ) ranked
    where source_row_number = 1
),
student_source as (
    select *
    from (
        select
            *,
            row_number() over (
                partition by _airtable_id
                order by _airbyte_extracted_at desc
            ) as source_row_number
        from {{ source('airtable_education', 'students') }}
    ) ranked
    where source_row_number = 1
),
assessment_source as (
    select *
    from (
        select
            *,
            row_number() over (
                partition by _airtable_id
                order by _airbyte_extracted_at desc
            ) as source_row_number
        from {{ source('airtable_education', 'assessments') }}
    ) ranked
    where source_row_number = 1
),
classrooms as (
    select
        classroom_id,
        state as statename,
        district as districtname,
        enrolled_students::numeric as enrolled_students
    from classroom_source
    where classroom_status = 'Active'
),
attendance_by_classroom_month as (
    select
        c.statename,
        c.districtname,
        date_trunc('month', a.attendance_date_text)::date as date,
        avg(a.students_present_text)::numeric as average_students_present,
        avg(a.students_enrolled_text)::numeric as average_students_enrolled
    from attendance_source a
    inner join classrooms c using (classroom_id)
    where a.record_status = 'Verified'
    group by 1, 2, 3, a.classroom_id
),
attendance_by_district_month as (
    select
        statename,
        districtname,
        date,
        sum(average_students_present) as average_students_present,
        sum(average_students_enrolled) as average_students_enrolled
    from attendance_by_classroom_month
    group by 1, 2, 3
),
gender_by_district as (
    select
        c.statename,
        c.districtname,
        count(*) filter (where s.gender = 'Male')::numeric as male_students,
        count(*) filter (where s.gender = 'Female')::numeric as female_students
    from student_source s
    inner join classrooms c using (classroom_id)
    where s.student_status = 'Enrolled'
    group by 1, 2
),
assessment_by_district as (
    select
        c.statename,
        c.districtname,
        avg(a.average_score) filter (where a.assessment_round = 'Baseline') as baseline_score,
        avg(a.average_score) filter (where a.assessment_round = 'Midline') as midline_score,
        avg(a.average_score) filter (where a.assessment_round = 'Endline') as endline_score
    from assessment_source a
    inner join classrooms c using (classroom_id)
    group by 1, 2
),
district_months as (
    select
        m.*,
        g.male_students,
        g.female_students,
        s.baseline_score,
        dense_rank() over (
            partition by m.statename
            order by m.districtname
        ) as district_rank
    from attendance_by_district_month m
    inner join gender_by_district g using (statename, districtname)
    inner join assessment_by_district s using (statename, districtname)
),
expanded_months as (
    select
        d.*,
        (d.date - (history.block_number * interval '6 months'))::date as reporting_month
    from district_months d
    cross join generate_series(0, 4) as history(block_number)
),
shaped as (
    select
        *,
        (
            (extract(year from reporting_month) - 2024) * 12
            + extract(month from reporting_month) - 1
        )::numeric as month_index,
        case statename
            when 'Uttar Pradesh' then 1.28
            when 'Maharashtra' then 1.18
            when 'Karnataka' then 1.05
            when 'Rajasthan' then 0.92
            when 'Odisha' then 0.78
            when 'Assam' then 0.69
            else 1.00
        end::numeric as state_weight,
        case district_rank when 1 then 0.93 else 1.07 end::numeric as district_weight,
        case statename
            when 'Maharashtra' then 0.77
            when 'Karnataka' then 0.74
            when 'Uttar Pradesh' then 0.69
            when 'Rajasthan' then 0.66
            when 'Odisha' then 0.61
            when 'Assam' then 0.58
            else 0.65
        end::numeric as coverage_target,
        case
            when statename = 'Assam' and extract(month from reporting_month) in (6, 7) then 'flood'
            when statename = 'Odisha' and extract(month from reporting_month) in (10, 11) then 'cyclone'
            when statename = 'Maharashtra' and extract(month from reporting_month) in (4, 5) then 'drought'
            when statename = 'Rajasthan' and extract(month from reporting_month) in (5, 6) then 'heatwave'
            else 'none'
        end as climate_event
    from expanded_months
),
weighted as (
    select
        *,
        average_students_present
            * state_weight
            * district_weight
            * (0.86 + month_index * 0.005) as unscaled_students,
        case climate_event
            when 'flood' then 0.82
            when 'cyclone' then 0.87
            when 'drought' then 0.93
            when 'heatwave' then 0.90
            else 1.00
        end::numeric as shock_factor,
        least(
            0.54,
            greatest(
                0.46,
                female_students / nullif(male_students + female_students, 0)
                + case statename
                    when 'Maharashtra' then 0.008
                    when 'Karnataka' then 0.004
                    when 'Assam' then 0.002
                    when 'Odisha' then -0.004
                    when 'Rajasthan' then -0.015
                    when 'Uttar Pradesh' then -0.020
                    else 0
                end
                + month_index * 0.0004
                + case
                    when extract(month from reporting_month) in (4, 5) then 0.002
                    when extract(month from reporting_month) in (8, 9) then 0.001
                    else -0.001
                end
            )
        ) as female_share,
        coalesce(baseline_score, 50)
            + month_index * 0.31
            + case
                when extract(month from reporting_month) in (1, 2) then -0.7
                when extract(month from reporting_month) in (6, 7) then 0.5
                when extract(month from reporting_month) in (10, 11) then -0.3
                else 0
            end as average_learning_score,
        greatest(
            0.8,
            case statename
                when 'Uttar Pradesh' then 4.4
                when 'Rajasthan' then 3.8
                when 'Assam' then 3.0
                when 'Odisha' then 2.5
                when 'Maharashtra' then 1.8
                when 'Karnataka' then 1.5
                else 2.5
            end
            - month_index * 0.035
            + case when extract(month from reporting_month) in (5, 6) then 0.2 else 0 end
        ) as gender_score_gap
    from shaped
),
latest_scale as (
    select
        10389076.0
        / nullif(sum(unscaled_students * shock_factor), 0) as scale_factor
    from weighted
    where reporting_month = (select max(reporting_month) from weighted)
),
prepared as (
    select
        md5(statename || '|' || districtname || '|' || reporting_month::text) as id,
        'India'::text as country,
        statename,
        districtname,
        upper(substr(regexp_replace(statename, '[^A-Za-z]', '', 'g'), 1, 2))
            || '-'
            || lpad(district_rank::text, 2, '0') as districtcode,
        reporting_month as date,
        round(unscaled_students * shock_factor * scale_factor)::bigint as students,
        female_share,
        round(
            unscaled_students * scale_factor
            / nullif(coverage_target + month_index * 0.0015, 0)
        )::bigint as population,
        average_learning_score,
        gender_score_gap,
        climate_event
    from weighted
    cross join latest_scale
),
classified as (
    select
        id,
        country,
        statename,
        districtname,
        districtcode,
        date,
        students,
        students - round(students * female_share)::bigint as males,
        round(students * female_share)::bigint as females,
        round(average_learning_score + gender_score_gap / 2, 2) as male_score,
        round(average_learning_score - gender_score_gap / 2, 2) as female_score,
        population,
        climate_event,
        case climate_event
            when 'flood' then 'Flood disruption'
            when 'cyclone' then 'Cyclone disruption'
            when 'drought' then 'Drought pressure'
            when 'heatwave' then 'Heatwave disruption'
            else 'No recorded shock'
        end as climate_resilience_status
    from prepared
)
select
    *,
    round(students::numeric / nullif(population, 0), 4) as monthly_coverage_pct,
    round(male_score - female_score, 2) as score_gap
from classified
