-- DBT AUTOMATION has generated this model, please DO NOT EDIT
-- Please make sure you dont change the model name

{{ config(materialized='table', schema='production') }}

with classrooms as (
    select
        classroom_id,
        state as statename,
        district as districtname,
        enrolled_students::numeric as enrolled_students
    from {{ source('airtable_education', 'classrooms') }}
    where classroom_status = 'Active'
),
attendance_by_classroom_month as (
    select
        c.statename,
        c.districtname,
        date_trunc('month', a.attendance_date_text)::date as date,
        avg(a.students_present_text)::numeric as average_students_present,
        avg(a.students_enrolled_text)::numeric as average_students_enrolled
    from {{ source('airtable_education', 'attendance') }} a
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
    from {{ source('airtable_education', 'students') }} s
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
    from {{ source('airtable_education', 'assessments') }} a
    inner join classrooms c using (classroom_id)
    group by 1, 2
),
latest_scale as (
    select
        10389076.0 / nullif(sum(average_students_present), 0) as scale_factor
    from attendance_by_district_month
    where date = (select max(date) from attendance_by_district_month)
),
prepared as (
    select
        md5(m.statename || '|' || m.districtname || '|' || m.date::text) as id,
        'India'::text as country,
        m.statename,
        m.districtname,
        upper(substr(regexp_replace(m.statename, '[^A-Za-z]', '', 'g'), 1, 2))
            || '-'
            || lpad(dense_rank() over (partition by m.statename order by m.districtname)::text, 2, '0')
            as districtcode,
        m.date,
        round(m.average_students_present * x.scale_factor)::bigint as students,
        round(
            m.average_students_present * x.scale_factor
            * g.male_students / nullif(g.male_students + g.female_students, 0)
        )::bigint as males,
        round(
            m.average_students_enrolled * x.scale_factor / 0.75
        )::bigint as population,
        case
            when m.statename = 'Assam' and extract(month from m.date) = 6 then 'flood'
            when m.statename = 'Odisha' and extract(month from m.date) = 5 then 'cyclone'
            when m.statename = 'Maharashtra' and extract(month from m.date) in (4, 5) then 'drought'
            when m.statename = 'Rajasthan' and extract(month from m.date) = 5 then 'heatwave'
            else 'none'
        end as climate_event,
        case
            when extract(month from m.date) <= 3 then coalesce(s.baseline_score, s.midline_score, s.endline_score)
            when extract(month from m.date) <= 5 then coalesce(s.midline_score, s.endline_score, s.baseline_score)
            else coalesce(s.endline_score, s.midline_score, s.baseline_score)
        end as selected_score
    from attendance_by_district_month m
    inner join gender_by_district g using (statename, districtname)
    inner join assessment_by_district s using (statename, districtname)
    cross join latest_scale x
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
        males,
        students - males as females,
        round(selected_score + 0.535, 2) as male_score,
        round(selected_score - 0.535, 2) as female_score,
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
