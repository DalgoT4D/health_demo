with source as (

    select * from {{ source('staging_health', 'raw_clinic_meetings') }}

),

cleaned as (

    select
        md5(concat_ws('||', coalesce(_airbyte_raw_id, ''), coalesce(source_row_id, ''))) as clinic_meeting_row_sk,
        _airbyte_raw_id,
        _airbyte_extracted_at as source_loaded_at,
        _airbyte_generation_id,
        source_row_id,

        {{ clean_id('meeting_id_raw') }} as meeting_id,
        {{ clean_id('encounter_id') }} as encounter_id,
        {{ clean_id('doctor_id_raw') }} as doctor_id,
        {{ clean_id('child_id_raw') }} as child_id,
        {{ clean_id('beneficiary_id_raw') }} as beneficiary_id,
        {{ clean_id('household_id_raw') }} as household_id,

        {{ parse_raw_date('meeting_date_raw') }} as meeting_date,
        {{ parse_raw_date('follow_up_date_raw') }} as follow_up_date,
        {{ parse_raw_date('last_updated_raw') }} as last_updated_date,
        {{ clean_text('meeting_start_time_raw') }} as meeting_start_time_raw,

        initcap({{ clean_label('clinic_site_raw') }}) as clinic_site,
        initcap({{ clean_label('doctor_name_raw') }}) as doctor_name,
        initcap(replace({{ clean_label('speciality_raw') }}, 'paediatric', 'pediatric')) as specialty,
        initcap({{ clean_label('patient_name_raw') }}) as patient_name,

        case
            when {{ clean_label('sex_raw') }} in ('f', 'female') then 'female'
            when {{ clean_label('sex_raw') }} in ('m', 'male') then 'male'
            else null
        end as sex,

        case
            when {{ clean_label('age_raw') }} like '%month%' or {{ clean_label('age_raw') }} like '%m'
                then {{ int_from_raw('age_raw') }}
            when {{ clean_id('child_id_raw') }} is not null
                then {{ int_from_raw('age_raw') }}
            else null
        end as age_months,

        case
            when {{ clean_label('age_raw') }} like '%month%' or {{ clean_label('age_raw') }} like '%m'
                then round({{ first_numeric('age_raw') }} / 12.0, 1)
            when {{ clean_label('age_raw') }} like '%yr%' or {{ clean_label('age_raw') }} like '%year%'
                then {{ first_numeric('age_raw') }}
            when {{ clean_id('child_id_raw') }} is null
                then {{ first_numeric('age_raw') }}
            else null
        end as age_years,

        case
            when {{ clean_label('status_raw') }} like '%cancel%' then 'cancelled'
            when {{ clean_label('status_raw') }} like '%no show%' then 'no_show'
            when {{ clean_label('status_raw') }} like '%resched%' then 'rescheduled'
            when {{ clean_label('status_raw') }} like '%unavailable%' then 'doctor_unavailable'
            when {{ clean_label('status_raw') }} = 'completed' then 'completed'
            else {{ clean_label('status_raw') }}
        end as meeting_status,

        case
            when {{ clean_label('meeting_type_raw') }} like '%first%' then 'first_visit'
            when {{ clean_label('meeting_type_raw') }} like '%follow%' then 'follow_up'
            when {{ clean_label('meeting_type_raw') }} like '%tele%' then 'teleconsult'
            when {{ clean_label('meeting_type_raw') }} like '%group%' then 'group_clinic'
            when {{ clean_label('meeting_type_raw') }} like '%home%' then 'home_visit_review'
            when {{ clean_label('meeting_type_raw') }} like '%emergency%' then 'emergency_referral'
            else {{ clean_label('meeting_type_raw') }}
        end as meeting_type,

        {{ clean_label('referral_source_raw') }} as referral_source,
        {{ clean_label('reason_for_visit_raw') }} as reason_for_visit,
        {{ clean_label('diagnosis_or_concern_raw') }} as diagnosis_or_concern,
        {{ clean_label('action_taken_raw') }} as action_taken,

        case
            when {{ clean_label('duration_mins_raw') }} like '%hour%' then {{ first_numeric('duration_mins_raw') }} * 60
            else {{ first_numeric('duration_mins_raw') }}
        end::integer as duration_minutes,

        {{ clean_text('entered_by') }} as entered_by,
        {{ clean_text('notes_raw') }} as notes,
        synthetic_record_flag

    from source

),

ranked as (

    select
        *,
        row_number() over (
            partition by meeting_id
            order by source_loaded_at desc, source_row_id desc, clinic_meeting_row_sk asc
        ) as meeting_id_rank
    from cleaned

)

select
    *,
    meeting_id_rank > 1 as is_duplicate_meeting_id,
    meeting_status = 'completed' as is_completed,
    follow_up_date is not null and meeting_status in ('completed', 'rescheduled') as has_follow_up
from ranked
